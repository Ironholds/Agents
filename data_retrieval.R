#Dependencies, options
library(WMUtils)
library(pageviews)
library(uaparser)
library(data.table)
library(parallel)

options(scipen = 500)

editors <- function(){
  editor_data <- global_query("SELECT cuc_user_text AS user, cuc_agent AS ua, ts_tags AS tags
                              FROM cu_changes INNER JOIN tag_summary ON cuc_this_oldid = ts_rev_id")
  editor_data[,"project" := NULL]
  editor_data$tags[grepl(x = editor_data$tags, pattern = "mobile")] <- "mobile"
  editor_data$tags[!editor_data$tags == "mobile"] <- "desktop"
  editor_data <- editor_data[,j = {
    if(length(unique(user)) < 50){
      NULL
    } else {
      .N
    }
  }, by = c("ua","tags")]
  setnames(editor_data, 1:3, c("agent", "class", "appearances"))
  parsed_agents <- uaparser(editor_data$agent, fields = c("os", "os_major", "browser","browser_major"))
  cat(".")
  parsed_agents <- as.data.table(cbind(parsed_agents, editor_data))

  write.table(editor_data[editor_data$class == "desktop",c("agent", "appearances"), with = FALSE], file.path(getwd(),"data","desktop_editors_raw.tsv"),
                          sep = "\t", row.names = FALSE)
  write.table(editor_data[editor_data$class == "mobile",c("agent", "appearances"), with = FALSE], file.path(getwd(),"data","mobile_editors_raw.tsv"),
              sep = "\t", row.names = FALSE)
  parsed_agents <- parsed_agents[,j=list(edits = sum(appearances)), by = c("class","os","os_major", "browser", "browser_major")]
  write.table(parsed_agents[parsed_agents$class == "desktop",], file.path(getwd(),"data","desktop_editors_parsed.tsv"),
              sep = "\t", row.names = FALSE)
  write.table(parsed_agents[parsed_agents$class == "mobile",], file.path(getwd(),"data","mobile_editors_parsed.tsv"),
              sep = "\t", row.names = FALSE)
  
}

readers <- function(){
  
  date <- Sys.Date() - 1
  start_date <- date - 30
  files <- get_files(start_date, date)
  agents <- mclapply(files, function(x){
    result <- to_pageviews(read_sampled_log(x))
    result <- data.table(agents = result$user_agent,
                         class = identify_access_method(result$url))
    result <- result[!result$class == "mobile app",]
    result <- result[,j = list(pageviews = .N), by = c("agents","class")]
    result <- result[result$pageviews > 500,]
    cat(".")
    return(result)
  }, mc.preschedule = FALSE, mc.cores = 4)
  agents <- do.call("rbind", agents)
  agents <- agents[,j=list(pageviews = sum(pageviews)), by = c("agents","class")]
  setnames(agents,1:3, c("agent","class","pageviews"))
  write.table(agents[agents$class == "desktop",c("agent", "pageviews"), with = FALSE], file.path(getwd(),"data","desktop_readers_raw.tsv"),
              sep = "\t", row.names = FALSE)
  write.table(agents[agents$class == "mobile web",c("agent", "pageviews"), with = FALSE], file.path(getwd(),"data","mobile_readers_raw.tsv"),
              sep = "\t", row.names = FALSE)
  parsed_agents <- cbind(agents, uaparser(agents$agent, fields = c("os", "os_major", "browser","browser_major")))
  parsed_agents <- parsed_agents[,j=list(pageviews = sum(pageviews)), by = c("class","os","os_major", "browser", "browser_major")]
  write.table(parsed_agents[parsed_agents$class == "mobile web", c("os","os_major","browser","browser_major","pageviews"), with = FALSE],
              file.path(getwd(),"data","mobile_readers_parsed.tsv"), sep = "\t", row.names = FALSE)
  write.table(parsed_agents[parsed_agents$class == "desktop", c("os","os_major","browser","browser_major","pageviews"), with = FALSE],
              file.path(getwd(),"data","desktop_readers_parsed.tsv"), sep = "\t", row.names = FALSE)
}