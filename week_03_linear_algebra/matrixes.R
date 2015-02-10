###

A <- matrix(c(1, 2, 1, 4, 2, 4), nrow=2)
B <- t(A)
dim(A)	# 2 * 3
dim(B)	# 3 * 2
A %*% B	# 2 * 2
B %*% A	# 3 * 3


plot(1:10, 1:10, ylim=c(-12,12), xlim=c(-12,12), type="n")
lines(c(0,-12), c(0,16))
lines(c(0,12), c(0,9))

a <- c(-12, 16)
b <- c(12, 9)
t(a) %*% b
sum(a*b)
# if the dot product is 0, the vectors are orthogonal
# Plot the vectors

# Eigenvectors of real symmetric matrices are orthogonal
A <- matrix(sample(1:12), nrow=3)
B <- A %*% t(A)
C <- eigen(B)$vectors
# The eigen function normalizes the eigenvectors
sum(C[,1]^2)
sum(C[,2]^2)
sum(C[,3]^2)
# Orthogonal matrices have a dot product of zero
round(C[,1] %*% C[,2],15)
round(C[,1] %*% C[,3],15)
# The determinant of an orthonormal matrix is +/- 1
det(C)

round(C %*% t(C),15)
