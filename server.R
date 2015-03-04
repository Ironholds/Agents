library(shiny)

#Generates a link to the raw or parsed files, based on the user's selection.
generate_download_link <- function(access_method, user_class, is_raw = TRUE){
  if(is_raw){
    type <- "raw"
  } else {
    type <- "parsed"
  }
  download_link <- file.path(getwd(),"data", paste0(paste(access_method, user_class, type, sep = "_"),".tsv"))
  return(download_link)
}

shinyServer(function(input, output) {
  
  #Generate the relevant download links - one for the "raw" file (which
  #just contains the user agents and a count) and one for the "parsed"
  #file (which contains a data.frame of the parsed fields)
  output$links <- renderUI({
    HTML(paste0("You can download the <a href ='", generate_download_link(input$access_method, input$user_type, TRUE),"'> raw agents</a>"),
         " and the <a href='", generate_download_link(input$access_method, input$user_type, FALSE),"'> parsed agents</a>
          for this subset. The full set of files can be found <a href = ''> here</a>.")
  })
  
  output$agent_table <- renderDataTable({
    read.delim(generate_download_link(input$access_method, input$user_type, FALSE), as.is = TRUE, header = TRUE)
  }, options = list(searching = FALSE))
  
})
