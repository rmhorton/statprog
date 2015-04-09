
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(rCharts)
library(ggvis)


shinyServer(function(input, output) {

  df <-  loadRDS( "../explorer/phbirths.rds")
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- df[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
