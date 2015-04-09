# Modified from "diamonds explorer", https://gist.github.com/jcheng5/3239667

library(shiny)
library(ggplot2)
library(dplyr)

site <- "http://data.princeton.edu/wws509/datasets/phbirths.dat"

# phbirths <- site %>% url %>% readLines %>% 
#   gsub(" +", "\t", .) %>% 
#   paste(collapse="\n") %>%
#   textConnection %>%
#   read.delim(header=TRUE)
# 
# dataset <- phbirths   # diamonds

dataset <- readRDS("phbirths.rds")

shinyUI(pageWithSidebar(
  
  headerPanel("Dataset Explorer"),
  
  sidebarPanel(
    
    sliderInput('sampleSize', 'Sample Size', min=1, max=(nrow(dataset)-1),
                value=min(1000, nrow(dataset)), step=10, round=0),
    
    selectInput('x', 'X', names(dataset), names(dataset)[[2]]),
    selectInput('y', 'Y', names(dataset), names(dataset)[[1]]),
    selectInput('color', 'Color', c('None', names(dataset))),
    
    checkboxInput('jitter', 'Jitter'),
    checkboxInput('smooth', 'Smooth'),
    
    selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
    selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
  ),
  
  mainPanel(
    tabsetPanel(
      tabPanel("Plot", plotOutput('plot', height=700)),
      tabPanel("Static Table", tableOutput('table')),
      tabPanel("Data Table", dataTableOutput('dataTable'))
    )
  )
))