# show errors

set.seed(100)
N <- 12
SLOPE <- 1.5
INTERCEPT <- 12
x <- runif(N, 0, 100)
y <- SLOPE * x + INTERCEPT + rnorm(N, 0, 10)

b <- 10
m <- 1.2
plot(x, y, pch=16, xlim=c(0,100), ylim=c(0,max(y)), col="blue")
abline(b, m, col="yellow")
predictions <- m * x + b
residuals <- y - predictions
for (i in seq_along(x)){
    lines(c(x[i],x[i]),c(y[i],predictions[i]))
}
sse <- round(sum(residuals^2),1)
text(90,10,paste("Error:", sse))


# Fit a quadratic
# Show in 3d where x, x^2, and y are the three dimensions

