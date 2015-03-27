
# http://en.wikipedia.org/wiki/Covariance#Calculating_the_sample_covariance
E <- function(v) sum(v) / (length(v) - 1)
sigma <- function(x, y) E( (x - mean(x)) * (y - mean(y)) )	# cov
rho <- function(x,y) sigma(x,y) / (sd(x) * sd(y))			# cor

x <- runif(100, min=0, max=100)
y <- 5 + 1.2 * x + rnorm(100, sd=3)
z <- runif(100, max=100)

# http://en.wikipedia.org/wiki/Correlation_and_dependence
# See pictures of various nonlinear relationships with correlation of 0
# "the correlation matrix is the same as the covariance matrix of the standardized random variables"

std_df <- data.frame(lapply(df, function(v) v/sd(v)))
# std_df2 <- data.frame(apply(df, 2, function(v) v/sd(v))) # returns a matrix
# all.equal(std_df, std_df2) # TRUE
cov(std_df)
cor(df)



# PCA only needs the covariance matrix
princomp(df)
princomp(covmat = cov(df))
