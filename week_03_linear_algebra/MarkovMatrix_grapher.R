# source("http://bioconductor.org/biocLite.R")
# biocLite("Rgraphviz")

library("Rgraphviz")
# set.seed(123)
# V <- letters[1:10]
# M <- 1:4
# g1 <- randomGraph(V, M, 0.2)
# plot(g1)
# 
# 
# eAttrs <- list()
# 
# eAttrs$label <- c("a~h"="Label 1", "c~h"="Label 2")
# $edge$arrowhead
# $edge$arrowsize
# $edge$labellfontsize

n <- 4
nodeNames <- letters[1:n]

MM <- matrix(c(
	0.3, 0.3, 0.4, 0.0,
	0.1, 0.5, 0.1, 0.3,
	0.0, 0.4, 0.2, 0.4,
	0.9, 0.0, 0.0, 0.1),
	nrow=n, byrow=T)
dimnames(MM) <- list( nodeNames, nodeNames )

r <- c(1,0,0,0)
for (i in 1:100) r <- r %*% MM

gray256 <- gray(0:255/255)

g <- new("graphNEL", nodes=nodeNames, edgemode="directed")

attrs <- list(
	node=list(fillcolor="lightgreen"),
	edge=list(labelfontsize=3)
)
eAttrs <- list()	# 
nAttrs <- list()

for (i in nodeNames){
	nAttrs$fillcolor[i] <- gray256[256 * r[i]]
	for (j in nodeNames)
		if (MM[i,j] > 0) {
			g <- addEdge(i, j, g, MM[i,j])
			edgeName <- paste(i, j, sep="~")
			eAttrs$label[edgeName] <- MM[i,j]
		}
}

# layout twopi, neato, dot; dot handles directional edges the best.
plot(g, "dot", nodeAttrs=nAttrs, edgeAttrs=eAttrs, attrs=attrs, recipEdges="distinct")


# plot MM graph with igraph

MM <- matrix(c(
	0.3, 0.3, 0.4, 0.0,
	0.1, 0.5, 0.1, 0.3,
	0.0, 0.4, 0.2, 0.4,
	0.9, 0.0, 0.0, 0.1),
	nrow=n, byrow=T)
rownames(MM) <- colnames(MM) <- letters[1:4]
g <- graph.adjacency(MM, mode=c("directed"), weighted=TRUE)
E(g)$label <- as.vector(t(MM))[as.vector(t(MM)) != 0]
plot(g)
