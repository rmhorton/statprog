N <- 50000

y <- numeric()
system.time({
	for (i in 1:N) y[i] <- i^2
})

z <- numeric(N)
system.time({
	for (i in 1:N) z[i] <- i^2
})

system.time({
	x <- 1:N
	w <- x^2
})

#####################################################################
#     Wrap these three approaches in functions, run them with
# a series of different N values, and collect the results into
# a data frame.
#####################################################################

N <- 50000

# Define functions for the three approaches
dynamic_alloc <- function(N){
	y <- double()
	for (i in 1:N)
		y[i] <- i^2
	y
}

pre_allocated <- function(N){
	y <- double(N)	# we know how big the output vector needs to be
	for (i in 1:N)
		y[i] <- i^2
	y
}

vectorized <- function(N) (1:N)^2

# This is a wrapper that runs system.time on a given function 
# with a given parameter and returns the elapsed time.
get_time <- function(param, fun)
	system.time( fun(param) )['elapsed']

# Define a sequence of N values to try
vector_length <- 1000 * 2^(0:6)

# Make a data frame where the rows are the N values, and the columns are
# the times for each function.
timing_results <- data.frame(
	dynamic_alloc = sapply(vector_length, get_time, dynamic_alloc),
	pre_allocated = sapply(vector_length, get_time, pre_allocated),
	vectorized    = sapply(vector_length, get_time, vectorized),
	row.names = vector_length
)

# Plot using base graphics
with(timing_results, {
	plot(vector_length, dynamic_alloc, type='l', ylab="elapsed time")
	lines(vector_length, pre_allocated, col="red")
	lines(vector_length, vectorized, col="blue")
	legend("topleft", text.col=c("black", "red", "blue"), 
		bty='n', legend=colnames(timing_results) )
})

#####################################################################

# Even more functional approach

# put the functions in a named vector

squaring_functions <- c(
	dynamic_alloc = function(N){
		y <- double()
		for (i in 1:N)
			y[i] <- i^2
		y
	},

	pre_allocated = function(N){
		y <- double(N)
		for (i in 1:N)
			y[i] <- i^2
		y
	},

	vectorized = function(N) (1:N)^2
)

vector_length <- 1000 * 2^(0:6)

timing_results <- data.frame( 
	N = vector_length,
	lapply(squaring_functions, function(f){
		sapply(vector_length, function(vl)
			system.time( f(vl) )['elapsed'])
	})
)

# Plot the results
# install.packages(c("tidyr", "ggplot2"))
# reformat the data into keys and values
library("tidyr")	# instead of reshape2::melt
tidy_tr <- gather(timing_results, key="method", value="time", -N)

library("ggplot2")
ggplot(data=tidy_tr, aes(x=N, y=time, group=method, colour=method) ) + 
	geom_line() + geom_point( size=2, shape=21, fill="white" )

# note that plotting N vs sqrt(time) gives a fairly straight line
ggplot(data=tidy_tr, aes(x=N, y=sqrt(time), group=method, colour=method) ) + 
	geom_line() + geom_point( size=2, shape=21, fill="white" )
