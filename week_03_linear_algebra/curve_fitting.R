# Use the lm() function to fit a polynomial curve to a set of data points
N <- 5
x <- sort(sample(1:100, N))
y <- sample(1:100, N)
plot(y ~ x)

fit <- lm(y ~ poly(x,N-1))
newx <- seq(min(x), max(x), len=100)
lines(newx, predict(fit, newdata=data.frame(x=newx)), col="red", lwd=3, lty=2)

my_poly <- function(N)
	as.formula(paste("y ~", paste("x", N:2, sep="^", collapse=" + "), "+ x - 1"))
fit2 <- lm(my_poly(N))
newx <- seq(min(x), max(x), len=100)
lines(newx, predict(fit, newdata=data.frame(x=newx)), col="yellow", lwd=4, lty=1)


# x <- c(13, 36, 57, 91, 97)
# y <- c(71, 96, 88, 35, 50)
# plot(y ~ x)

# fit4 <- lm(y ~ I(x^5) + I(x^4) + I(x^3) + I(x^2) + I(x))


x <- c(13, 36, 57, 91, 97)
y <- c(71, 96, 88, 35, 50)
plot(y ~ x)

df <- data.frame(y, x, x2=x^2, x3=x^3, x4=x^4, x5=x^5)
newx <- seq(min(x), max(x), len=100)

fit5 <- lm( y ~ x5 + x4 + x3 + x2 + x - 1, data=df)	# we do not want an intercept
pcurve <- function(v)
	vapply(v, function(i) coef(fit5) %*% i^(5:1), 1)

lines(newx, pcurve(newx), col="green")


##############

x <- c(13, 36, 57, 91, 97)
y <- c(71, 96, 88, 35, 50)

polynomialize_column <- function(df, col, degree){
	ex <- 2:degree
	newcols <- do.call("cbind", lapply(ex, function(pow) df[[col]] ^ pow))
	colnames(newcols) <- paste0(col, ex)
	cbind(df, newcols)
}

poly_formula <- function(ycol, xcol, degree)
	as.formula(paste(ycol, "~", 
		paste(xcol, N:2, sep="", collapse=" + "), 
		"+", xcol, "- 1"))

}

my_data <- data.frame(
	y=c(71, 96, 88, 35, 50), 
	x=c(13, 36, 57, 91, 97)
)
my_data <- polynomialize_column( my_data, 'x', 5 )

my_formula <- poly_formula('y', 'x', 5)

my_fit <- lm(my_formula, my_data)

plot(y ~ x, data=my_data)
newdata <- data.frame(x=10:100)
newdata <- polynomialize_column(newdata, "x", 5)
lines(newx, predict(my_fit, newdata=newdata), col="yellow", lwd=4, lty=1)

fitting_function_factory <- function(fittedModel){
	beta <- coef(fittedModel)
	function(x) sapply(x, function(i) beta %*% i^(length(beta):1))
}

f <- fitting_function_factory(my_fit)
x <- 10:100
plot(x, f(x))
curve(f, col="yellow", from=10, to=100)

coef2equation <- function(co)
	paste(co, names(co), sep=' * ', collapse=' + ')

coef2func <- function(co){
	fstr <- paste("function(x)", paste(co, length(co):1, sep="*x^", collapse=' + '))
	eval(parse(text=fstr))
}
	