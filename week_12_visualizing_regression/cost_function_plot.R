set.seed(100)

m <- 1
b <- 0
x <- rnorm(20)	# runif(20, 0, 100)
y <- m*x + b + rnorm(length(x), mean=0, sd=1)

plot(x,y)
abline(b, m, lty=2, col="green")

num_m <- 100
num_b <- 100
m_val <- seq(0.2, 2.5, length=num_m)
b_val <- seq(-1,1,length=num_b)

M <- matrix(numeric(num_m * num_b), nrow=num_m, byrow=TRUE)
for (mi in 1:num_m){
	for (bi in 1:num_b){
		predicted <- m_val[mi]*x + b_val[bi]
		sse <- sum((predicted - y)^2)
		M[mi, bi] <- sse
	}
}

image(m_val, b_val, M, col=heat.colors(1024))
contour(m_val, b_val, M, add=TRUE)
min(M)
sum( ((m*x + b) - y )^2 )

require(rgl)
surface3d(m_val, b_val, M)
aspect3d(1,1,1)



###

set.seed(100)


cost_space <- function(m, b, min_m, max_m, min_b, max_b){
	x <- runif(20, 0, 100)
	y <- m*x + b + rnorm(length(x), mean=0, sd=1)

	# plot(x,y)
	# abline(b, m, lty=2, col="green")

	num_m <- 100
	num_b <- 100
	m_val <- seq(min_m, max_m, length=num_m)
	b_val <- seq(min_b,max_b,length=num_b)

	M <- matrix(numeric(num_m * num_b), nrow=num_m, byrow=TRUE)
	for (mi in 1:num_m){
		for (bi in 1:num_b){
			predicted <- m_val[mi]*x + b_val[bi]
			sse <- sum((predicted - y)^2)
			M[mi, bi] <- sse
		}
	}

	image(m_val, b_val, M, col=heat.colors(1024))
	contour(m_val, b_val, M, add=TRUE)
}

library(manipulate)
manipulate(cost_space(slope, intercept, min_m, max_m, min_b, max_b),
	slope=slider(-9, 9, step=0.1, initial = 0),
	intercept=slider(-10, 10, step=0.1, initial=0),
	min_m=slider(-20, -1, step=0.1, initial=-1),
	max_m=slider(1, 20, step=0.1, initial=1),
	min_b=slider(-20, -1, step=0.1, initial=-1),
	max_b=slider(1, 20, step=0.1, initial=1)
)

	