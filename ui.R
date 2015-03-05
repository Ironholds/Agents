library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  titlePanel(title = "", windowTitle = "Agents of W.I.K.I.M.E.D.I.A."),
  h2("Agents of W.I.K.I.M.E.D.I.A."),
  h4("The common user agents of Wikimedia readers and editors"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "access_method",
                  label = "Site used:",
                  choices = c("desktop","mobile"),
                  selected = "desktop"),
      selectInput(inputId = "user_type",
                  label = "User type:",
                  choices = c("readers","editors"),
                  selected = "readers"),
      h2("About this data"),
      HTML("This data contains the most common user agents for Wikimedia readers and editors.
            Agents are provided parsed using the open-source <a href = 'http://www.uaparser.org/'>ua-parser</a> project."),
      h3("Details"),
      HTML("The intent
           behind releasing the parsed agents is to make it easier for Wikimedia developers
           to understand how to best test their software for the group they're targeting.<br/><br/>"),
      htmlOutput("links"),
      h2("Reusing this data"),
      HTML("The data is released into the public domain under the
           <a href = 'https://creativecommons.org/publicdomain/zero/1.0/'>CC-0 public domain dedication</a>, and can be freely reused
           by all and sundry. Iff you decide you want to credit it to people, though, the appropriate citation is:
           <br/><br/>
           <blockquote><a href = 'http://blog.ironholds.org/'>Keyes, Oliver</a> (2015)
              <em><a href = 'http://dx.doi.org/10.6084/m9.figshare.1326739'>Browser Choices of Wikimedia Readers and Editors</a></em>
           </blockquote>")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput("agent_table"),
      HTML("<small><em>Agents of W.I.K.I.M.E.D.I.A.</em>  is built using <a href = 'https://shiny.rstudio.com'>Shiny</a> and has source code
           on <a href = 'https://github.com/Ironholds/Agents'>GitHub</a>.</small>")
    )
  ), theme = shinytheme("cosmo")
))
