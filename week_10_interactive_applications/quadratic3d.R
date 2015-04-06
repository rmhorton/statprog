x <- seq(-10, 10, by=1)
y <- x^2
z <- 2*y + 5*x + 6
plot(x,z)
library(rgl)
plot3d(x,y,z)


