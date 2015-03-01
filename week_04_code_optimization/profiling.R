really_slow_squares <- function(N){
	y <- numeric()
	for (i in 1:N){
		res <- i^2
		y[i] <- res
	}
	y
}

slow_squares <- function(N){
	y <- numeric(N)
	for (i in 1:N){
		res <- i^2
		y[i] <- res
	}
	y
}

sapply_squares <- function(N){
	sapply(1:N, function(i) i^2)
}

vapply_squares <- function(N){
	vapply(1:N, function(i) i^2, numeric(1))
}

vectorized_squares <- function(N) (1:N)^2

run_all <- function(N){
	a <- really_slow_squares(N)
	b <- slow_squares(N)
	c <- sapply_squares(N)
	d <- vapply_squares(N)
	e <- vectorized_squares(N)
}

Rprof("run_all_profile.out")

run_all(500000)

Rprof()

summaryRprof("run_all_profile.out")

## 
devtools::install_github("hadley/lineprof")
library(lineprof)

lp_res <- lineprof( run_all(1000), torture=TRUE )
shine(lp_res)
