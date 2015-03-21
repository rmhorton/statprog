 # These are the examples from the help file for Matrix::sparseMatrix
 # Project ideas: try a large matrix multiplication, maybe with FNDDS data.
 # Race against other approaches (like SQL, maybe SQLite in RAM)
 
 i <- c(1,3:8); j <- c(2,9,6:10); x <- 7 * (1:7)
 (A <- sparseMatrix(i, j, x = x))
 summary(A)
 str(A) # note that *internally* 0-based row indices are used
 
 ## dims can be larger than the maximum row or column indices
 (AA <- sparseMatrix(c(1,3:8), c(2,9,6:10), x = 7 * (1:7), dims = c(10,20)))
 summary(AA)
  
 
 dn <- list(LETTERS[1:3], letters[1:5])
 ## pointer vectors can be used, and the (i,x) slots are sorted if necessary:
 m <- sparseMatrix(i = c(3,1, 3:2, 2:1), p= c(0:2, 4,4,6), x = 1:6, dimnames = dn)
 m
 str(m)
 stopifnot(identical(dimnames(m), dn))
 
 sparseMatrix(x = 2.72, i=1:3, j=2:4) # recycling x
 sparseMatrix(x = TRUE, i=1:3, j=2:4) # recycling x, |--> "lgCMatrix"
 
 ## no 'x' --> patter*n* matrix:
 (n <- sparseMatrix(i=1:6, j=rev(2:7)))# -> ngCMatrix
 

 ##' @title Random Sparse Matrix
 ##' @param nrow,
 ##' @param ncol number of rows and columns, i.e., the matrix dimension
 ##' @param nnz number of non-zero entries
 ##' @param rand.x random number generator for 'x' slot
 ##' @param ... optionally further arguments passed to sparseMatrix()
 ##' @return a sparseMatrix of dimension (nrow, ncol)
 ##' @author Martin Maechler
 rSparseMatrix <- function(nrow, ncol, nnz,
						   rand.x = function(n) round(rnorm(nnz), 2), ...)
 {
	 stopifnot((nnz <- as.integer(nnz)) >= 0,
			   nrow >= 0, ncol >= 0, nnz <= nrow * ncol)
	 sparseMatrix(i = sample(nrow, nnz, replace = TRUE),
				  j = sample(ncol, nnz, replace = TRUE),
				  x = rand.x(nnz), dims = c(nrow, ncol), ...)
 }
 
 M1 <- rSparseMatrix(1000, 20, nnz = 200)
 summary(M1)

 