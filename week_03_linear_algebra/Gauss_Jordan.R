# Gauss-Jordan elimination: 
#     This is a draft of an exercise to review Matrix
# operations and practice matrix indexing at the same time. We
# use row and cell indexing to perform the Gauss-Jordan
# elimination "manually", then check the math by using the
# built-in solver.

# Generate deterministic pseudo-random matrix based on user ID:
# This way we can give each student their own problem.

# Sourcing an R script from github
# http://tonybreyal.wordpress.com/2011/11/24/source_https-sourcing-an-r-script-from-github/

random_invertible_matrix <- function(n, seed=NA){
	if (!is.na(seed)){
		if(is.character(seed)){
			require(digest)
			seed <- strtoi(paste0("0x",substr(digest(seed),1,4)))
		}
		set.seed(seed)
	}
	# Initialize with a singular matrix
	A <- matrix( 1:n^2, nrow=n)
	# Choose random integer matrixes until we find a non-singular one
	while (det(A) == 0)
		A <- matrix( sample(1:99, n^2, replace=T), nrow=n)
	A
}

random_invertible_matrix(5, "bob")
random_invertible_matrix(3, "patricia")


n <- 3

A <- random_invertible_matrix(n, "bob")
A
#      [,1] [,2] [,3]
# [1,]   72   49   93
# [2,]   81    2   93
# [3,]   24   90   72

# Augment the square matrix by binding an identity matrix on the right.
Aaug <- cbind(A, diag(n))

# Perform the row operations necessary to complete the Gauss-Jordan elimination.

Aaug[1,] <- Aaug[1,] / Aaug[1,1]
Aaug[2,] <- Aaug[2,] - Aaug[1,] * Aaug[2,1]
Aaug[2,] <- Aaug[2,] / Aaug[2,2]

Aaug[3,] <- Aaug[3,] - Aaug[1,] * Aaug[3,1]
Aaug[3,] <- Aaug[3,] - Aaug[2,] * Aaug[3,2]
Aaug[3,] <- Aaug[3,] / Aaug[3,3]

Aaug[2,] <- Aaug[2,] - Aaug[3,] * Aaug[2,3]

Aaug[1,] <- Aaug[1,] - Aaug[2,] * Aaug[1,2]
Aaug[1,] <- Aaug[1,] - Aaug[3,] * Aaug[1,3]

Ainv <- Aaug[,4:6]

Ainv

# check using built-in solver
solve(A)

# check by multiplication to get Identity matrix
A %*% Ainv
round(A %*% Ainv,12)	# round to 12 decimal places

# Review questions:
# * Why is the inverse of a matrix useful? 
# * Why is the R function to compute the inverse of a matrix named "solve"?


# Elimination Matrixes
set.seed(1)
n <- 3
A <- matrix( sample(0:10, n^2, replace=T), nrow=n)
A
#      [,1] [,2] [,3]
# [1,]    2    9   10
# [2,]    4    2    7
# [3,]    6    9    6

I <- diag(n)
P23 <- I[c(1,3,2),]	# permutation matrix
P23 %*% A	# swap rows 2 and 3
A %*% P23	# swap cols 2 and 3

E21 <- I; E21[2,1] <- -A[2,1]/A[1,1]
E31 <- I; E31[3,1] <- -A[3,1]/A[1,1]
B <- E21 %*% E31 %*% A	# temporary copy
E32 <- I; E32[3,2] <- -B[3,2]/B[2,2]
E12 <- I; E12[1,2] <- -B[1,2]/B[2,2]
C <- E32 %*% E12 %*% B
E13 <- I; E13[1,3] <- -C[1,3]/C[3,3]
E23 <- I; E23[2,3] <- -C[2,3]/C[3,3]
D <- E13 %*% E23 %*% C

E13 %*% E23 %*% E32 %*% E12 %*% E21 %*% E31 %*% A

E <- E13 %*% E23 %*% E32 %*% E12 %*% E21 %*% E31

round(E %*% A, 6)

N <- diag(1/diag(E%*%A)) # diag either creates a diagonal matrix, or pulls the diagonal from a matrix.

Ainv2 <- N %*% E
Ainv2
solve(A)

# Assignment: create a literate RMarkdown document to explain the following procedure.
# Use the random_invertable_matrix function with your own user name to make a 3 by 3 matrix.
# Augment the matrix by cbinding a 3 by 3 Identity matrix on the right.
# Write a series of row multiplication and subtraction steps to perform Gaussian elimination.
# (note that for Gaussian elimination, you are just getting the matrix in upper diagonal form,
# and the pivots are not set to 1, so this is a little different from the example given).
# Show the upper triangular matrix U you get by Gaussian elimination.
# Complete the Gauss-Jordan elimination by eliminating upward (leaving a diagonal matrix in the left three columns)
# then divide through to leave an identity matrix in the left three columns.
# Check your result three ways:
# 1) multiply the original matrix by your result, round to 12 decimal places, and see if you get the identity matrix.
# 2) compare to the inverted matrix you get using solve().
# 3) verify that the product of the pivots `prod(diag(U))` equals the determinant `det(A)`.
# For the full report, repeat the procedure using permutation and elimination matrices instead of addressing individual row.
