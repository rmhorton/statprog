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

get_time <- function(param, fun)
	system.time( fun(param) )['elapsed']

vector_length <- 1000 * 2^(0:6)
timing_results <- data.frame(
	N = vector_length,
	dynamic_alloc = sapply(vector_length, get_time, dynamic_alloc),
	pre_allocated = sapply(vector_length, get_time, pre_allocated),
	vectorized    = sapply(vector_length, get_time, vectorized)
)

# plot using base graphics
with(timing_results, {
	plot(N, dynamic_alloc, type='l', ylab="elapsed time")
	lines(N, pre_allocated, col="red")
	lines(N, vectorized, col="blue")
	legend("topleft", lty=1, col=c("black", "red", "blue"), legend=c("dynamic_alloc", "pre_allocation", "vectorized") )
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

# reformat the data into keys and values
library("tidyr")	# instead of reshape2::melt
mdf <- gather(timing_results, key="method", value="time", -N)

library("ggplot2")
ggplot(data=mdf, aes(x=N, y=time, group=method, colour=method) ) + 
	geom_line() + geom_point( size=2, shape=21, fill="white" )

# note that plotting N vs sqrt(time) gives a fairly straight line
