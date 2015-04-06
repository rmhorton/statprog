
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# Plot Polynomial Equation
# To Do: think about how to avoid repeating the repalcement of values 
# (currently the input values are substituted into the equation twice, 
# once in the plotting function and again when we make the character representation).

library(shiny)

theEquation <- "y <- a + b*x + c*x^2 + d*x^3 + e*x^4"

shinyServer(function(input, output) {

  output$polyPlot <- renderPlot({
    # generate y-vector using coefficients from ui.R
    x <- seq(input$x_rng[1], input$x_rng[2], length=100)
    y <- input$a + input$b*x + input$c*x^2 + input$d*x^3 + input$e*x^4

    plot(x, y, type="l")
  })

  output$equation <- renderText({
    eq <- theEquation
    for (coeff in letters[1:5]){
      replacement <- as.character(input[[coeff]])
      eq <- gsub(coeff, replacement, eq)
    }
    eq
  })
  
})
