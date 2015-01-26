# Use the lm() function to fit a polynomial curve to a set of data points
N <- 5
x <- sort(sample(1:100, N))
y <- sample(1:100, N)
plot(y ~ x)
lines(y ~ x)
fit <- lm(y ~ poly(x,N-1))
newx <- seq(min(x), max(x), len=100)
lines(newx, predict(fit, newdata=data.frame(x=newx)), col="red", lwd=3, lty=2)
