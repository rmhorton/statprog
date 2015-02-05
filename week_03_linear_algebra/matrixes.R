###

# Dot products
# a.k.a. "inner product" or "weighted combination"
coin_counts <- c( quarters=3, dimes=3, nickles=1, pennies=7 )
coin_values <- c( quarters=25, dimes=10, nickles=5, pennies=1 )
sum(coin_counts * coin_values)
t(coin_counts) %*% coin_values

class_coins <- matrix(c(
	5, 2, 0, 3,
	3, 0, 2, 5,
	8, 2, 2, 1), byrow=TRUE, nrow=3, 
	dimnames=list(c("Alice", "Bob", "Carol"), c("quarters", "dimes", "nickles", "pennies")))

class_coins %*% coin_values


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
