set.seed(1)
N <- 500
sex <- sample(c("M","F"), N, replace=T)
mean_height <- c(M=69.1, F=63.7)	# inches
sd_height <- c(M=2.9, F=2.7)
beers_per_week <- c(M=6, F=3)
football_hours_per_week <- c(M=8, F=4)

main_colors <- grep("\\d", colors(), invert=T, value=T)
favorite_colors <- list(
	F=grep("[pyam]", main_colors, value=T),
	M=grep("[dbwg]", main_colors, value=T)
)

intersect(favorite_color[['M']], favorite_color[['F']])
setdiff(favorite_color[['M']], favorite_color[['F']]) 
setdiff(favorite_color[['F']], favorite_color[['M']]) 

measurements <- data.frame(
	sex = sex,
	height = round(rnorm(N, mean=mean_height[sex], sd=sd_height[sex]),1),
	beers = rpois(N, lambda=beers_per_week[sex]),
	football = rpois(N, lambda=football_hours_per_week[sex]),
	favorite_color = sapply(sex, function(g) sample(favorite_colors[[g]], 1))
)

training_set <- measurements[1:300,]
test_set <- measurements[301:500,]

# logistic <- glm( sex ~ ., data=training_set, family="binomial")
logistic <- glm( sex ~ height + football + beers, data=training_set, family="binomial")
# predict(logistic, test_set, type="response")
logistic_prediction <- ifelse(predict(logistic, test_set)<0,"F","M")

# see http://www.statmethods.net/advstats/cart.html
library(rpart)
tree <- rpart( sex ~ height + football + beers, data=training_set, method="class" )
plot(tree)
text(tree)
post(tree, file = "tree.ps", 
  	title = "Regression Tree for Sex Classification")

# predicted <- with(as.data.frame(predict(tree, data=test_set)), ifelse(M>F,'M','F'))
# class(tree)
# predict.rpart
predicted <- c('F','M')[predict(tree, test_set, type="vector")]

library(randomForest)
# randf <- randomForest(sex ~ ., data=training_set)
# Can not handle categorical predictors with more than 53 categories.
randf <- randomForest(sex ~ height + football + beers, data=training_set)
print(randf)
importance(randf) # importance of each predictor

