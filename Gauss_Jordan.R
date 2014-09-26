# Gauss-Jordan elimination: 
#     This is a draft of an exercise to review Matrix
# operations and practice matrix indexing at the same time. We
# use row and cell indexing to perform the Gauss-Jordan
# elimination "manually", then check the math by using the
# built-in solver.

# Generate deterministic pseudo-random matrix based on user ID:
# This way we can give each student their own problem.

random_invertable_matrix <- function(n, seed=NA){
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

random_invertable_matrix(5, "bob")
random_invertable_matrix(3, "patricia")


n <- 3

A <- random_invertable_matrix(n, "bob")
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
* Why is the inverse of a matrix useful? 
* Why is the R function to compute the inverse of a matrix named "solve"?
