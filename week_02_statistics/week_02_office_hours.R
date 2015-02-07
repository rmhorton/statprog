# Use a data frame to organize your data
mydata <- data.frame(
    hour=6:20, 
    delay=c(55,60,75,88,90,87,65,55,50,45,45,50,55,65,68)
)

mydata
mydata$delayHrs <- mydata$delay / 60
mydata
plot(mydata$hour, mydata$delayHrs)  # plot 2 vectors
with(mydata, {plot(hour, delayHrs)})  # use plain variable names inside "with" block
plot(delayHrs ~ hour, mydata)  # call plot using a formula 

# Put two figures on one page
op <- par(mfrow=c(1,2)) # save original graphic parameters
plot( delayHrs ~ hour, mydata)
plot( delayHrs ~ hour, mydata, type="l", col="red")
par(op)  # restore original graphic parameters
# or explicitly set it back to a single figure: par(mfrow=c(1,1))

# simple example of univariate linear regression
x <- runif(100, 0, 50)
y <- 1.5 * x + 12 + rnorm(100, 0, 3)
plot(x,y)
fit <- lm(y ~ x)
abline(fit, col="red")
coef(fit)

# Same thing using a data frame
mydata <- data.frame(exks=x, why=y)
head(mydata)
mydata <- data.frame(ecks=x, why=y)
head(mydata)
plot( why ~ ecks, mydata, col="green")
fit2 <- lm(why ~ ecks, data=mydata)
abline(fit2, col="blue")
coef(fit2)
abline(15, 1.2, lty=2, col="red")  # guess a line
resid(fit2)  # residuals are errors made by model predictions
hist(resid(fit2))  # see if errors look normally distributed

# With a larger sample size we get better estimates
N <- 1e5
x <- runif(N, 0, 50)
y <- 1.5 * x + 12 + rnorm(N, 0, 3)
plot(x,y)
fit <- lm(y ~ x)
abline(fit, col="red")
coef(fit)
hist(resid(fit))  # errors are normally distributed
