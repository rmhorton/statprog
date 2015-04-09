x <- runif(1000, min=-10, max=10)
y <- x^2
z <- 2*y + 5*x + 6
plot(x,z)
library(rgl)
plot3d(x,y,z)


