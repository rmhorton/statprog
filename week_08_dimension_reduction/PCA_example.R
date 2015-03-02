N <- 20
g1 <- rnorm(N, mean=100, sd=30)
g2 <- 0.5 * g1 + rnorm(N, sd=3)

# https://class.coursera.org/netsysbio-002/lecture/59

g1 <- c(2.5, 0.5, 2.2, 1.9, 3.1, 2.3, 2.0, 1.0, 1.5, 1.1)
g2 <- c(2.4, 0.7, 2.9, 2.2, 3.0, 2.7, 1.6, 1.1, 1.6, 0.9)
N <- length(g1)
D <- rbind(g1, g2)

plot(D[1,], D[2,])

Dcentered <- D - rowMeans(D)
# t(apply(D, 1, function(v) v - mean(v)))
plot(Dcentered[1,], Dcentered[2,])
C <- (1/N) * Dcentered %*% t(Dcentered)
# same as cov(t(D))
# The values in the matrix C given at 2:52 are cov(t(D))
eigen(C)

# the values in the video are eigen(cov(t(D)))$values

# Eigenvectors are the same for C and cov(t(D)); centering only changes the eigen values.

# Place eigenvectors in a matrix in descending order by eigenvalue

eigenC <- eigen(C)
W <- eigenC$vectors[, order(eigenC$values, decreasing=TRUE)]

Dpca <- t(W) %*% Dcentered
