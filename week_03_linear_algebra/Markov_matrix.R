M <- function(matrix_string){
	rows <- strsplit(matrix_string, ";")[[1]]
	ch_list <- lapply(strsplit(rows, " "), 
		function(s) vapply(s, 
			function(i) eval(parse(text=i), envir=sys.frame(1)), 
			numeric(1), USE.NAMES=FALSE
		)
	)
	do.call(rbind, ch_list)
}
	
A <- M("0 .3 .3 .3 .1;.1 0 .3 0 .6;0 0 .9 0 .1;0 0 .5 0 .5;.4 0 0 .6 0")
r <- c(1,0,0,0,0)
for (i in 1:100) r <- r %*% A	# left eigenvector
r/sqrt(sum(r*r))
eigen(t(A))$vectors[,1]


A <- M(".7 .2 .1;.1 .6 0;.2 .2 .9")
r <- c(1,0,0)
for (i in 1:100) r <- A%*% r
r/sqrt(sum(r*r))
eigen(A)$vectors[,1]

A <- M("0 .1 .2 .3;.2 .3 .2 .1;.3 .2 .5 .4;.5 .4 .1 .2")
r <- rep(0.5,4)
for (i in 1:100) r <- A %*% r
r / sqrt(sum(r*r))
eigen(A)$vectors[,1]	# they differ by a scalar constant

# symmetric exchange
A <- M(".8 .2 0;.2 .7 .1;0 .1 .9")
r <- c(1,0,0)
for (i in 1:100) r <- A %*% r
r / sqrt(sum(r*r))
eigen(A)$vectors[,1]