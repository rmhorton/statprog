head(women)
fit <- lm(weight ~ height, data=women)
plot(weight ~ height, data=women)
abline(fit)
fit2 <- lm(weight ~ height + I(height^2), data=women)
lines(women$height, fit2$fitted, col="red")
x <- seq(-10, 10, length=50)
y <- 3* x^2 + 25 * x + 5
plot(x, y)
x <- seq(-100, 50, length=50)
y <- 3* x^2 + 25 * x + 5
plot(x, y)
y <- -3* x^2 + 25 * x + 5
plot(x, y)
y <- 7 * x^3 - 3* x^2 + 25 * x + 5
plot(x, y)
x <- seq(-75, 75, length=50)
plot(x, y)
y <- 7 * x^3 - 30* x^2 - 25 * x + 5
plot(x, y)
?I
x <- rnorm(1000, mean=50, sd=10)
hist(x)
hist(x)
?quantile
seq(0, 1, 0.25)
quantile(x)
min(x)
max(x)
length(x)
length(x[x<43.61247])
percentiles <- quantile(x, probs=0:100/100)
percentiles
quantile(x)
xcat <- cut(x, breaks=quantile(x))
head(xcat)
xcat <- cut(x, breaks=quantile(x), include.lowest=TRUE)
head(xcat)
xcat <- cut(x, breaks=c(-Inf, 43.6, 50.1, 67.4, Inf), include.lowest=TRUE)
head(xcat
)
table(xcat)
xcat <- cut(x, breaks=quantile(x))
table(xcat)
xcat <- cut(x, breaks=quantile(x), include.lowest=TRUE)
table(xcat)
xcat <- cut(x, breaks=quantile(x, probs=0:10/10), include.lowest=TRUE)
table(xcat)
0:10/10
seq(0, 1, by=0.1)
