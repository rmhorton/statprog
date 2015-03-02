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
