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
           Agents are provided in both parsed and raw form - the parsed generated using the
           open-source <a href = 'http://www.uaparser.org/'>ua-parser</a> project."),
      h3("Details"),
      HTML("The intent
           behind releasing the parsed agents is to make it easier for Wikimedia developers
           to understand how to best test their software for the group they're targeting;
           the intent behind releasing the raw agents is to give the wider world an idea
           of the sort of users hitting a global, top-10 property, and give ua-parser
           and other community-driven parsers a dataset to test against.<br/><br/>"),
      htmlOutput("links"),
      h2("Reusing this data"),
      HTML("The data is released into the public domain under the
           <a href = 'https://creativecommons.org/publicdomain/zero/1.0/'>CC-0 public domain dedication</a>, and can be freely reused
           by all and sundry. Iff you decide you want to credit it to people, though, the appropriate citation is:
           <br/><br/>
           <blockquote><a href = 'http://blog.ironholds.org/'>Keyes, Oliver</a> (2015)
              <em><a href = 'http://dx.doi.org/10.6084/m9.figshare.1317408'>Browser Choices of Wikimedia Readers and Editors</a></em>
           </blockquote>")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput("agent_table")
    )
  ), theme = shinytheme("cosmo")
))
