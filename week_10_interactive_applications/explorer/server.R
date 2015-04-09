# Modified from "diamonds explorer", https://gist.github.com/jcheng5/3239667

library(shiny)
library(ggplot2)
library(dplyr)

# site <- "http://data.princeton.edu/wws509/datasets/phbirths.dat"
# 
# phbirths <- site %>% url %>% readLines %>% 
#   gsub(" +", "\t", .) %>% 
#   paste(collapse="\n") %>%
#   textConnection %>%
#   read.delim(header=TRUE, row.names=1)


dataset <- readRDS("phbirths.rds")

shinyServer(function(input, output) {
  
  datasubset <- reactive({
    dataset[sample(nrow(dataset), input$sampleSize),]
  })
  
  output$plot <- renderPlot({
    
    p <- ggplot(datasubset(), aes_string(x=input$x, y=input$y))
    
    if ( is.factor(datasubset()[[input$x]]) | is.logical(datasubset()[[input$x]]) )
        p <- p + geom_violin(area="count") 
    else
      p <- p + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
  
  output$table <- renderTable(datasubset())
  
  output$dataTable <- renderDataTable(datasubset())  # http://rstudio.github.io/DT/
  
})