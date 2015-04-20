
load("food_nutrient_mat.Rdata") # nutrients per 100g (see p. 31), not per serving.
foods <- loadRDS("foods.rds")

set.seed(123)
diet01 <- sample(0:5, dim(food_nutrient_mat)[1], prob=c(90, 2, 2, 2, 2, 2), replace=TRUE)
diet01 %*% food_nutrient_mat[,"Energy"]	# 4640

digit1_divisions <- c(1="milk and milk products", 2="meat, poultry, fish, and mixtures", 3="eggs", 4="legumes, nuts, and seeds", 5="grain products", 6="fruits", 7="vegetables", 8="fats, oils, and salad dressings", 9="sugars, sweets, and beverages")

vegetarian <- c(`1`=2, `3`=2, `4`=3, `5`=1, `6`=2, `7`=3, `8`=2, `9`=1)

generate_diet <- function(category_weights, min_calories, foods=foods){
	category_probs <- category_weights/sum(category_weights)
}

# See appendix E; WWEIA Food Category is an alternative organization (see appendix C).
vegetarian <- c(1,1,3,3,4,4,5,6,7,8,9)
vegan <- c(4,4,4:9)
meat_potatoes <- c(2,2,2,2,2,71,71,71,71,931,931,1:9)
alcoholic <- c(93,93,93,93,93,93,93,93,93,1:9)
sweet_tooth <- c(rep(92400000, 4), rep(91700010, 2), 1:9)
# soft drink = 92400000
# candy = 91700010
# recommended_servings: http://www.health.gov/dietaryguidelines/dga2000/document/build.htm
	# women: grains 6, vegetables 3, fruits 2, milk 2 or 3, meat/eggs/nuts/beans 2; 1600 cal
	# men: grains 9, vegetables 4, fruits 3, milk 2 or 3, meat/eggs/nuts/beans 2; 2200 cal
woman <- c(5,5,5,5,5,5,7,7,7,6,6,1,1,2:4)
man <- c(5,5,5,5,5,5,5,5,5,5,7,7,7,7,6,6,6,1,1,2:4)



### Portions of Ice Cream
# dbGetQuery(con, "SELECT * FROM FoodWeights fw join FoodPortionDesc fpc on fw.portion_code = fpc.portion_code where fw.food_code = 13110000")