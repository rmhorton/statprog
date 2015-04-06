
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(shinyRGL)
library(rgl)

shinyUI(fluidPage(

  # Application title
  titlePanel("Quadratic Equations in Linear Models"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput("N", "number of points:", 1000, min=1, max=65535),
      sliderInput("intercept", "intercept",
                  min = -5, max = 5, value = 0, step=0.1),
      sliderInput("coefX", "x-coefficient",
                  min = -2, max = 2, value = 1, step=0.1),
      sliderInput("coefY", "y-coefficient",
                  min = -2, max = 2, value = 1, step=0.1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      webGLOutput("myWebGL")
    )
  )
))
