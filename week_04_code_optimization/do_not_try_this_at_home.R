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

vector_length <- 1000 * 2^(1:6)
timing_results <- data.frame(
	N = vector_length,
	dynamic_alloc = sapply(vector_length, get_time, dynamic_alloc),
	pre_allocated = sapply(vector_length, get_time, pre_allocated),
	vectorized    = sapply(vector_length, get_time, vectorized)
)

with(timing_results, {
	plot(N, dynamic_alloc, type='l', ylab="elapsed time")
	lines(N, pre_allocated, col="red")
	lines(N, vectorized, col="blue")
	legend("topleft", lty=1, col=c("black", "red", "blue"), legend=c("dynamic_alloc", "pre_allocation", "vectorized") )
})



# Even more functional

squaring_functions <- c(
	dynamic_alloc = function(N){
		y <- double()
		for (i in 1:N)
			y[i] <- i^2
		y
	},

	pre_allocated = function(N){
		y <- double(N)	# we know how big the output vector needs to be
		for (i in 1:N)
			y[i] <- i^2
		y
	},

	vectorized = function(N) (1:N)^2
)

get_time <- function(param, fun)
	system.time( fun(param) )['elapsed']

vector_length <- 1000 * 2^(1:6)

timing_results <- data.frame( 
	N = vector_length, 
	lapply(squaring_functions, function(f){
		sapply(vector_length, get_time, f)
	})
)

line_colors <- c("black", "red", "blue")
names(line_colors) <- names(squaring_functions)


with(timing_results, {
	plot(N, dynamic_alloc, type='n', ylab="elapsed time (sec)")
	for (funcName in names(squaring_functions))
		lines(N, timing_results[[funcName]], col=line_colors[funcName])
	legend("topleft", lty=1, bty='n', legend=names(squaring_functions) )
})

# Fitting a curve to the results:
dyn_alloc_model <- lm( log(dynamic_alloc) ~ N . N^2, data=times)

N_values <- seq(0, max(vector_length), length=10)

predicted_times <- exp( predict(dyn_alloc_model, list(N = N_values)) )

lines(N_values, predicted_times, col="green", lty=2)

