N <- 2000

# Try changing these coefficients; bigger numbers cause larger effects.
# Since we are not changing the noise, it appears relatively smaller 
# when the effect is larger.
# If the effects are equal and opposite and the categories are equally 
# probable, they can cancel out so there are no observable overall main effects.
coeffA <- 1.1		#  1.1
coeffB <- -1.1		# -1.1

# Try changing the probabilities of each category. If one group is a minority, the main effects for the overall population can give wrong predictions for the minority group.

df <- data.frame(
	category = sample(LETTERS[1:2], N, prob=c(0.5, 0.5), replace=T),
	stimulus = 5 + rnorm(N)
)

df <- transform(df, 
	response = 0 + ifelse( category=="A", coeffA, coeffB) * stimulus + rnorm(N)
)

with(df, plot(response ~ stimulus, col=category))

fit1 <- lm( response ~ stimulus, data=df)
summary(fit1)

fit2 <- lm( response ~ category, data=df)
summary(fit2)

fit3 <- lm( response ~ stimulus:category, data=df)
summary(fit3)

df$fitted <- fit3$fitted.values
with(df, points(stimulus, fitted, col="green"))