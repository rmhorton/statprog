# Plotting a graph
M <- matrix(runif(120), nrow=10)
d <- dist(M)

library(igraph)
net <- graph.adjacency(as.matrix(d), mode="undirected", weighted=TRUE, diag=TRUE)
plot.igraph(net)
