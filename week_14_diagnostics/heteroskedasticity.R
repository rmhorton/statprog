sim <- function(N=100){
  u <- runif(N, min=0, max=10)
  v <- runif(N, min=0, max=10)
  w <- runif(N, min=0, max=10)
  x <- runif(N, min=0, max=10)
  y <- 1.1 * u - 2.2 * v + 0.2 * w^2 - 3.3 * log(x) + rnorm(N)
  data.frame(u, v, w, x, y)
}

d <- sim(1000)
plot(d)
fit1 <- lm( y ~ ., data=d)

# Could we test for clusteredness by decile? 
# If residuals cluster by quantile of a variable, there is nonlinearity.
# This is probably too complicated
d$wcat <- cut(d$w, breaks=quantile(d$w, probs=0:10/10), include.lowest=T, labels=LETTERS[1:10])
d$xcat <- cut(d$x, breaks=quantile(d$x, probs=0:10/10), include.lowest=T, labels=LETTERS[1:10])

spectrum <- rainbow(10, end=5/6)

with(fit1, plot(fitted.values, residuals, col=spectrum[d$xcat]))
with(fit1, plot(fitted.values, residuals, col=spectrum[d$wcat]))

logistic <- function(t) 1/(1 + exp(-t))

with(fit1, plot(fitted.values, logistic(residuals), col=spectrum[d$wcat]))
# scale residuals in the range (-3, 3), then do logistic transform (so they don't squash up too much against the limits)
# or express residuals in standard deviations
with(fit1, plot(fitted.values, logistic(scale(residuals)), col=spectrum[d$wcat]))

# How many categories do you need to get good sensitivity of clusteredness?

# Plotting residuals may be a more sensitive way to visualize nonlinearity than plotting outcomes
plot(fit1$fitted.values, fit1$residuals)
plot(d$x, fit1$residuals)
plot(d$w, fit1$residuals)

