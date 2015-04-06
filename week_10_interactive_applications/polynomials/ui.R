
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Polynomial Equations"),
  # y <- a + b*x + c*x^2 + d*x^3 + e*x^4 + f*x^5

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("x_rng", "x range:", 
                  min = -100, max = 100, value = c(-10, 10)),
      sliderInput("a", "a (intercept):", 
                  min = -10000, max = 10000, value = 0),
      sliderInput("b", "b * x:", 
                  min = -1000, max = 1000, value = 0, step=10),
      sliderInput("c", "c * x^2:", 
                  min = -10, max = 10, value = 0),
      sliderInput("d", "d * x^3:", 
                  min = -1, max = 1, round=FALSE, value = 0, step=0.1),
      sliderInput("e", "e * x^4:", 
                  min = -0.1, max = 0.1, round=FALSE, value = 0, step=0.01)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      textOutput("equation"),
      plotOutput("polyPlot")
    )
  )
))
