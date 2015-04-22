solve(t(X) %*% X) %*% t(X) %*% y -> beta
y_est <- X %*% beta

plot(x, y2, pch=19)
points(x, y, col="red")
for (i in seq_along(x)) lines(c(x[i],x[i]), c(y[i],y2[i]), col="red")

r

library(rgl)
persp3d(M)