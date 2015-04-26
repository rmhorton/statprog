logistic <- function(t) 1 / (1 + exp(-t))

N <- 1e6
df <- data.frame(
  carcinogens = runif(N, min=0, max=100),
  age = sample(10:99, N, replace=T)
)

library(manipulate)
manipulate({
  df <- transform(df, 
  	score = 10^a * (carcinogens - mean(carcinogens)) + 
  			10^b * (age - mean(age))) - 2
  df$prob <- logistic(df$score)
  hist(df$prob, breaks=50)
}, a=slider(-9, 9, step=0.1, initial = 0), b=slider(-9, 9, step=0.1, initial = 0) )
# try a <- -1.4; b <- -1.6

df <- transform(df, 
	score = 10^(-1) * (carcinogens - mean(carcinogens)) + 
			10^(-2) * (age - mean(age))) - 2
df$prob <- logistic(df$score)
hist(df$prob, breaks=50)

df$cancer <- factor(ifelse(df$prob > runif(N), "Yes", "No"))

fit <- glm(cancer ~ I(carcinogens - mean(carcinogens)) + I(age - mean(age)) + 1, 
		data=df, family="binomial")

plot(df$cancer, predict(fit, type="response"), notch=T)

coef(fit)

# df <- transform(df, score = -0.8 + 0.002 * carcinogens^2 + 0.05 * age )
# fit <- glm(cancer ~ I(carcinogens^2) + age, data=df, family="binomial")

