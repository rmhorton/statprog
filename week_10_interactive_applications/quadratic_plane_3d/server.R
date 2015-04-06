# 3d plot showing how a quadratic equation fits the comcept of a linear model

library(shiny)
library(shinyRGL)
library(rgl)

shinyServer(function(input, output) {

  output$myWebGL <- renderWebGL({
    N <- input$N
    x <- runif(N, min=-1, max=1)
    y1 <- runif(N, min=-1, max=1)
    y2 <- x^2
    z1 <- input$coefY*y1 - input$coefX*x - input$intercept
    z2 <- input$coefY*y2 - input$coefX*x - input$intercept
    # plot(x,z)
    points3d(x,y1,z1, color="orange")
    points3d(x,y2,z2, color="red")
    axes3d()
  })

})
