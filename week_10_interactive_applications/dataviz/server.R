library(shiny)
library(dplyr)
library(rCharts)
library(ggvis)

options(RCHART_WIDTH = 900)


shinyServer(function(input, output) {

  df <-  loadRDS( "../explorer/phbirths.rds")
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- df[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })
  
  output$chart1 <- renderChart2({
    library(rCharts)
    # aggregate with dplyr to produce summary.data. Use input variables to aggregate (e.g., input$groupvar)
    df %>% group_by_( input$groupvar) %>% summarize( 
    nPlot(Freq ~ Count.Var, group = groupvar, data = summary.data, type = "multiBarChart")
  })

})
