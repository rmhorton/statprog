# I found this on stackoverflow: http://stackoverflow.com/questions/27072346/r-shiny-dev-on-rstudio-server-shiny-crashes-when-app-launch
# See also: http://shiny.rstudio.com/articles/function.html
# Paste into R terminal session to run shiny app without RStudio.

library(shiny)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs), col = 'darkgray', border = 'white')
  })
}

ui <- shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 10, max = 500, value = 100)
    ),
    mainPanel(plotOutput("distPlot"))
  )
))

shinyApp(ui = ui, server = server)