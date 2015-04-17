# http://www.r-bloggers.com/igraph-and-sna-an-amateurs-dabbling/

library(igraph)
set.seed(101)
#create a data set
X <- lapply(1:10, function(i) sample(LETTERS[1:10], 3))
Y <- data.frame(person = LETTERS[1:10], sex = rbinom(10, 1, .5), do.call(rbind, X))
names(Y)[3:5] <- paste0("choice.", 1:3)
 
#reshape the data to long format
Z <- reshape(Y, direction="long", varying=3:5)
colnames(Z)[3:4] <- c("choice.no",  "choice")
rownames(Z) <- NULL
Z <- Z[, c(1, 4, 3, 2)]
 
#turn the data into a graph structure
edges <- as.matrix(Z[, 1:2])
g <- graph.data.frame(edges, directed=TRUE)
plot(g)
V(g)$label <- V(g)$name
 
#change label size based on number of votes
SUMS <- data.frame(table(Z$choice))
SUMS$Var1 <- as.character(SUMS$Var1)
SUMS <- SUMS[order(as.character(SUMS$Var1)), ]
SUMS$Freq <- as.integer(SUMS$Freq)
label.size <- 2
V(g)$label.cex <- log(scale(SUMS$Freq) + max(abs(scale(SUMS$Freq)))+ label.size)
plot(g)

#Color edges that are reciprocal red
x <- t(apply(edges, 1, sort))
x <- paste0(x[, 1], x[, 2])
y <- x[duplicated(x)]
COLS <- ifelse(x %in% y, "red", "gray40")
E(g)$color <- COLS
plot(g)

#reverse score the choices.no and weight
E(g)$width <- (4 - Z$choice.no)*2
 
#color vertex based on sex
V(g)$gender <- Y$sex
V(g)$color <- ifelse(V(g)$gender==0, "pink", "lightblue")
 
#plot it
opar <- par()$mar; par(mar=rep(0, 4)) #Give the graph lots of room
plot.igraph(g, layout=layout.auto(g))
par(mar=opar)




##### ====================
# http://www.r-bloggers.com/using-sna-in-predictive-modeling/
library(igraph)

M <- matrix(c(0, 0, 0, 1, 0, 0, 0, 0, 0, 0,0, 0, 0, 1, 0, 0, 0, 0, 0, 0,0, 0, 0, 1, 0, 0, 0, 0, 0, 0,1, 1, 1, 0, 1, 0, 0, 0, 1, 0,0,0, 0, 1, 0, 1, 1, 1, 0, 0,0, 0, 0, 0, 1, 0, 0, 0, 0, 0,0 ,0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,0,0, 0, 1, 0, 0, 0, 0, 0, 1,0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ),10,10, byrow= TRUE)
G <- graph.adjacency(M, mode=c("undirected"))

plot(G)

# convert key player network matrix to an igraph object    
cent <- data.frame(bet=betweenness(G),eig=evcent(G)$vector) # calculate betweeness & eigenvector centrality 
res <- as.vector(lm(eig~bet,data=cent)$residuals)           # calculate residuals
cent <- transform(cent,res=res)                             # add to centrality data set
# write.csv(cent,"r_keyactorcentrality.csv") 

# evcent calculates eigenvector centralities
plot(G, layout = layout.fruchterman.reingold, 
	vertex.size = 20*evcent(G)$vector, vertex.label = as.factor(rownames(cent)))
	
# class(G)
# ?plot.igraph


#-------------------------------------------
# create analysis data set
#------------------------------------------
 
id <- c(1,2,3,4,5,6,7,8,9,10)  # create individual id's for reference
income <- c(35000, 37000, 43000, 63000, 72000, 27000, 30000, 34000, 45000, 55000) # income
default <- c(1,1,1,0,0,1,1,1,1,1) # default indicator
 
#-------------------------------------------
# basic regression
#------------------------------------------
 
creditrisk <- cbind(id,income, cent, default) # combine with eigenvector centrality derived above
 
# model default risk as a function of income and network relationship 
 
# OLS
model1 <- lm(creditrisk$default~  creditrisk$eig + creditrisk$income) 
summary(model1)
 
#logistic regression
model2 <- glm(creditrisk$default~  creditrisk$eig + creditrisk$income, family=binomial(link="logit"), na.action=na.pass)
summary(model2)
 
# decision tree
model3 <- rpart(creditrisk$default~  creditrisk$eig + creditrisk$income)
summary(model3)

#####
# http://web.stanford.edu/~messing/RforSNA.html
install.packages(c("igraph", "sna", "network", "statnet", "rpart"))

library("sna")

gplot(g, mode = "circle", main = "Circular Layout")
