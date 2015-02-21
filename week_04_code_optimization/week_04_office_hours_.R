# Vectorize this function
addRandom <- function(i) i + rnorm(1)
addRandom(100)
x <- 0:10
addRandom(x)
y <- sapply(0:10, addRandom)
y
addRandomVectorized <- function(v) v + rnorm(length(v))
addRandomVectorized(y)
addRandomVectorized <- function(i) vapply(i, function(x) x+rnorm(1), 1)
addRandomVectorized(y)
addRandomVectorized <- function(x) sapply(x, addRandom)
addRandomVectorized(y)
addRandomVectorized <- Vectorize(addRandom)
addRandomVectorized(y)

# Compare speeds of different functions
install.packages("microbenchmark")
library(microbenchmark)
?microbenchmark

addRandom <- function(i) i + rnorm(1)
arv1 <- function(v) v + rnorm(length(v)),
arv2 <- function(i) vapply(i, function(x) x+rnorm(1), 1),
arv3 <- function(x) sapply(x, addRandom),
arv4 <- Vectorize(addRandom)
N <- 10000
microbenchmark(
	arv1(N),
	arv2(N),
	arv3(N),
	arv4(N)
)
N <- 1e6
microbenchmark(
	arv1(N),
	arv2(N),
	arv3(N),
	arv4(N)
)

# matrix multiplication of rows and columns; how to make a multiplication table
r <- matrix(1:10,1)
r
matrix(1:10)
t(r) %*% r
r %*% t(r)
r^2
t(r)^2

# Simple example of Gaussian elimination
A <- matrix(c(2, 5, 3, 8), 2, byrow=TRUE)
A
A[2,] <- A[2,] - (3/2) * A[1,]
A

# Flipping coins
coinflips <- strsplit('TTTHTHTTTH','')[[1]]
coinflips
flip10 <- sapply(1:10000, function(i) paste(sample(coinflips),collapse=''))
head(flip10)
length(unique(flip10))
?head
choose(10,3)
flip10 <- sapply(1:1000, function(i) paste(sample(coinflips),collapse=''))
length(unique(flip10))
flip10 <- sapply(1:300, function(i) paste(sample(coinflips),collapse=''))
length(unique(flip10))

# Estimating Pi
N <- 1000
x <- runif(N)
y <- runif(N)
plot(x,y)
points(x[3], y[3], col="red", pch=19)
lines(c(0,x[3]), c(0, y[3]), lty=3, col="red")
points(0,0,col="green", pch=19)
sqrt(x[3]^2 + y[3]^2)
vlength <- sqrt(x^2 + y^2)
hist(vlength, breaks=50)
plot(x,y)
in_circle <- vlength < 1
class(in_circle)
head(in_circle)
sum(in_circle)
sum(in_circle)/N
points(x , y ,col=c("red", "blue")[in_circle])
c("red", "blue")[in_circle]
points(x , y ,col=ifelse(in_circle, "red", "blue"))
sum(in_circle)/N
4 * sum(in_circle)/N
estimate_pi <- function(N) {
	x <- runif(N)
	y <- runif(N)
	4 * sum( (x^2 + y^2) < 1 )/N
}
estimate_pi(1e6)
head(in_circle)
head(as.integer(in_circle))
head(as.integer(in_circle),n=100)
# calling an anonymous function
(function(N) {
	x <- runif(N)
	y <- runif(N)
	4 * sum( (x^2 + y^2) < 1 )/N
})(100000)

# Fitting a line with lm()
x <- runif(100, min=20, max=100)
y <- 12 + 3.1 * x
plot(x,y)
y <- 12 + 3.1 * x + rnorm(100, sd=5)
plot(x,y)
abline(12, 3.1)
y <- 12 + 3.1 * x + rnorm(100, sd=15)
plot(x,y)
abline(12, 3.1)
e <- rnorm(100, sd=15)
hist(e)
hist(e, breaks=30)
y <- 12 + 3.1 * x + e
plot(x,y)
abline(12, 3.1)
fit <- lm(y ~ x)
coef(fit)
abline( fit, col"red", lty=2)
abline( fit, col="red", lty=2)
abline( coef(fit)[1], coef(fit)[2], col="yellow", lty=3, lwd=3)
coef(fit)[1]
coef(fit)[2]
