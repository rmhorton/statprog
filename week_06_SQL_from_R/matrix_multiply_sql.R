#     For the negative binomial distribution with size=1, prob
# corresponds to the probability of getting zero. Here we'll
# use this to make sparse matrices with approximately a given
# fraction of zeros.
# N <- 1000
# x <- 1:100/100 # prob in 1/100 increments
# y <- sapply(x, function(p) sum(rnbinom(N, prob=p, size=1)==0)/N) # fraction zeros
# plot(x,y); abline(0,1)

# Generate a random matrix with mostly zeros (represented in "dense" matrix format).
random_sparse_matrix <- function(numRows=5, numCols=5, probZero=0.7, seed=NULL){
	if(!is.null(seed)) set.seed(seed)
	matrix( rnbinom(numRows * numCols, prob=probZero, size=1), nrow=numRows )
}

# Convert a matrix into a data frame with one row per nonzero value.
dense2sparse <- function(M){
	num_values <- sum(M != 0)
	T <- data.frame( 
		row_num=integer(num_values), 
		col_num=integer(num_values), 
		value=numeric(num_values)
	)
	next_record <- 1
	for (i in 1:nrow(M)){
		for (j in 1:ncol(M)){
			val <- M[i,j]
			if (val != 0){
				T[next_record,] <- c(i,j,val)
				next_record <- next_record + 1
			}
		}
	}
	return(T)
}

# Convert a sparse matrix data frame to a matrix.
sparse2dense <- function(sparse_df, numRows=5, numCols=5){
	dense_m <- matrix(numeric(numRows * numCols), nrow=numRows)
	for (i in 1:nrow(sparse_df)){
		r <- sparse_df[i,]
		dense_m[r[[1]], r[[2]]] <- r[[3]]
	}
	dense_m
}

# Use SQL to multiply two sparse matrices.
sparse_multiply <- function(A, B){
	library("sqldf")
	sql <- "SELECT A.row_num, B.col_num, SUM(A.value * B.value) AS value \
		FROM A, B \
		WHERE A.col_num = B.row_num \
		GROUP BY A.row_num, B.col_num;"
	sqldf(sql)
}

A <- random_sparse_matrix(seed=1)
B <- random_sparse_matrix(seed=2)

C <- sparse2dense( sparse_multiply( dense2sparse(A), dense2sparse(B) ) )

all.equal(C, A %*% B)	# TRUE


# Converting from dense to sparse using tidyr
Adf <- as.data.frame(A)
colnames(Adf)[1:5] <- 1:5
Adf$row_num <- row.names(Adf)

library("magrittr")
library("dplyr")
library("tidyr")

## `dense2sparse` and `sparse2dense` essentially replicate `gather` and `spread`
gathered <- gather(Adf, col_num, value, -row_num)
gathered %>% spread(col_num, value)

## To get back the original matrix A exactly, we need to adjust types and attributes
gathered %>% spread(col_num, value) %>% 
	.[-1] %>% data.matrix() %>% (function(.){dimnames(.) <- NULL;.})

## Note that this is not exactly sparse2dense, since we did not drop the zero cells.

## We can reproduce dense2sparse exactly:
Adf %>% gather(col_num, value, -row_num) %>% filter(value != 0) %>% arrange(row_num)

dense2sparse(A)

