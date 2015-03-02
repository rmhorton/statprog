# This is an example of a simulated data -> analysis exercise.
# First we generate a data set with engineered relationships among the variables,
# then we explore and analyze the data to practice "re-discovering" the relationships.

# Generate simulated data
set.seed(1)
N <- 500
sex <- sample(c("M","F"), N, replace=T)
mean_height <- c(M=69.1, F=63.7)	# inches
sd_height <- c(M=2.9, F=2.7)
beers_per_week <- c(M=6, F=3)
football_hours_per_week <- c(M=8, F=4)

main_colors <- grep("(\\d|light|dark|medium)", colors(), invert=T, value=T)
main_colors <- main_colors[nchar(main_colors) < 6]
favorite_color <- list(
	F=grep("[pyam]", main_colors, value=T),
	M=grep("[dbwg]", main_colors, value=T)
)

intersect(favorite_color[['M']], favorite_color[['F']])
setdiff(favorite_color[['M']], favorite_color[['F']]) 
setdiff(favorite_color[['F']], favorite_color[['M']]) 

pay_data <- data.frame(
	sex = sex,
	height = round(rnorm(N, mean=mean_height[sex], sd=sd_height[sex]),1),
	beers = rpois(N, lambda=beers_per_week[sex]),
	football = rpois(N, lambda=football_hours_per_week[sex]),
	favorite_color = sapply(sex, function(g) sample(favorite_color[[g]], 1))
)

# add outcome
base_pay <- c(M=15, F=68.2)
pay_height_coeff <- c(M=1, F=0.25)

pay_data$pay <- with(pay_data, round(base_pay[as.character(sex)] + pay_height_coeff[as.character(sex)] * height + rnorm(N, sd=1),1))

# Examine the simulated data
summary(pay_data[pay_data$sex=="M","pay"])
summary(pay_data[pay_data$sex=="F","pay"])

library(ggplot2)
ggplot(pay_data, aes(x=height, col=sex)) + geom_density()
ggplot(pay_data, aes(x=pay, col=sex)) + geom_density()

plot(pay ~ height, pay_data, col=pay_data$sex)
abline(base_pay["M"], pay_height_coeff["M"], lty=2, lwd=3, col="palegreen")
abline(base_pay["F"], pay_height_coeff["F"], lty=2, lwd=3, col="lightblue")

# Fit a linear regression model
fit <- lm(pay ~ sex*height, pay_data)
summary(fit)
# income depends on sex and height

# visualize the predictions
pay_data$predicted <- predict(fit)
points(predicted ~ height, pay_data, col="yellow", pch=4)
# also try col=c("blue", "green")[pay_data$sex]

# visualize the fitted model
coeff <- summary(fit)$coeff[,"Estimate"]
# F is the base, since it is the first factor level
abline( coeff["(Intercept)"], coeff["height"], col="blue")
# add adjustments for M
abline( coeff["(Intercept)"] + coeff["sexM"], coeff["height"] + coeff["sexM:height"], col="green")

# Exploration questions:
# What happens if you change N to 50? To 5000?

# Simulation topics:
# Diabetes: association of weight and blood sugar.
