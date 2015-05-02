ll <- function(fit){
	# stats:::logLik.lm
	# stats:::AIC.default
	N <- length(fit$residuals)
	sse <- sum(fit$residuals ^ 2)
	ll <- 0.5 * (- N * (log(2 * pi) + 1 - log(N) + log(sse)))
	attr(ll, "df") <- fit$rank + 1
	# AIC = -2 * ll(fit) + 2 * K
	ll
}

aic <- function(fit){
	# http://pages.pomona.edu/~jsh04747/courses/math158/multlin4.pdf
	N <- length(fit$residuals)
	sse <- sum(fit$residuals ^ 2)
	K <- length(fit$coefficients) + 1
	
	# N * (1 + log(2*pi) + log(sse / N)) + 2 * (K)
	N * (1 + log(2*pi*sse / N)) + 2 * K
}

# BIC: Baysean Information Criterion - peanalizes number of parameters even more than AIC

N <- 1000
v <- rnorm(N, mean=50, sd=20)
w <- rnorm(N, mean=50, sd=20)
x <- rnorm(N, mean=50, sd=20)
y <- 2.2 * w + 3.3 * x + rnorm(N, sd=2)

fit1 <- lm( y ~ w )

fit2 <- lm( y ~ x )

fit3 <- lm( y ~ w + x )

fit4 <- lm( y ~ w + x + v )
