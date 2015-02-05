# https://www.youtube.com/watch?v=7ntHNH3OMBk
# x = [A]
# y = [B]
# 
# l = 1 cm (constant)
# 
# A300 = A300(x) + A300(y)
# A500 = A500(x) + A500(y)

# observations
b <- c(A300 = 0.35, A500 = 0.23)

# extinction coefficients
e <- data.frame(
	e300 = c(x=80, y=150),
	e500 = c(x=52, y=100)
)

# 80*x + 150*y = 0.35	# A300
# 52*x + 100*y = 0.23	# A500


A <- t(as.matrix(e))

M <- cbind(A, b)

# Gaussian elimination
M[2,] <- M[2,] - (52/80) * M[1,]
y <- M['e500','b']/M['e500','y']
x <- (M['e300','b'] - M['e300','y']*y)/M['e300','x']
x
y

x <- solve(A, b)
A %*% x