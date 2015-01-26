## Numeric integration
f <- function(x) sqrt(x)
integrate(f, 0, 10)

step_size <- 0.01
ecks <- seq(0, 10, by=step_size)
sum(step_size * f(ecks))

bell <- function(x) exp(-(x^2)/2)
curve(bell, from=-3, to=3)
integrate(bell, -Inf, Inf)

integrate(dnorm, -1.96, 1.96)
integrate(dexp, 0, Inf)
