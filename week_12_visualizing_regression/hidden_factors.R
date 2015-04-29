simulate_pca <- function(k=2){
	# k <- 2  # number of components
	n <- 10000

	# set.seed(1)
	P <- matrix( rnorm(k), nrow=k )
	M <- matrix( rnorm(k*6), nrow=k )

	EF <- matrix( runif(k*n, min=0, max=100), ncol=k )

	y <- EF %*% P
	X <- EF %*% M 
	X <- X + rnorm(length(X))	# need to add randomness to avoid singularity


	simple <- as.data.frame( cbind(y, EF) )
	names(simple) <- c("y", "EF1", "EF2")

	# library("rgl")
	# with(simple, plot3d(x=EF1, y=EF2, z=y))

	library(ggplot2)
	# g <- ggplot(simple, aes(x=EF1, y=EF2, col=y)) + geom_point()

	complex <- as.data.frame( cbind(y, X) )
	names(complex) <- c("y", paste0("X", 1:ncol(X)))

	library(psych)
	fa.parallel(complex[,-1], fa="pc", n.iter=100,
				   show.legend=FALSE, main="Scree plot with parallel analysis")

}
######


pcX <- principal(complex[-1])

pcX3 <- prcomp(complex[-1])
with(as.data.frame(pcX3$x), plot(PC2 ~ PC1))

plot( pcX3$x[,"PC1"], simple$EF1)
plot( pcX3$x[,"PC1"], simple$EF2)

# For seed == 1, PC1 seems to be fairly closely correlated with EF2, 
# but that can change if you don't set the seed.


plot( pcX3$x[,"PC2"], simple$EF1)

