# blood pressure simulation

bmi <- function(height, weight) weight/height^2

sbp <- function(sex, salt, bmi, etoh){
	if (sex == "M")
		90 + 0.005 * salt + 0.5 * bmi - 0.01 * etoh
	else
		80 + 0.005 * salt + 0.4 * bmi - 0.01 * etoh
}

generate_dataset <- function(N){
	HEIGHT_MEAN <- c( F = 1.6, M = 1.8 )
	HEIGHT_SD <- 0.05
	WEIGHT_MEAN <- c( F = 54, M = 70 )
	WEIGHT_SD <- 10
	sex <- sample(c("M", "F"), N, replace=TRUE)
	salt <- rnorm(N, mean=2200, sd=50)
	height <- rnorm(N, mean=HEIGHT_MEAN[sex], sd=HEIGHT_SD)
	weight <-  1.2 * ( height - HEIGHT_MEAN[sex] ) + WEIGHT_MEAN[sex] + rnorm(N, sd=5)
	etoh <- 50 * rpois(N, lambda=6)
	
	data.frame( sex, salt, height, weight, etoh)
}