N <- 200

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
	stimulus = rnorm(N)
)

df <- transform(df, 
	response = 0 + ifelse( category=="A", coeffA, coeffB) * stimulus + rnorm(N)
)

with(df, plot(response ~ stimulus, col=category))
# If this were not colored by category would you see a pattern?


fit1 <- lm( response ~ stimulus, data=df)
summary(fit1)

fit2 <- lm( response ~ category - 1, data=df)
summary(fit2)
mean(df[df$category=="A","response"])
mean(df[df$category=="B","response"])

fit3 <- lm( response ~ stimulus:category, data=df)
summary(fit3)

# Try increasing the magnitude of coeffA and CoeffB to exaggerate the signal (leaving the noise the same).


# Show the linear predictions. For a simple line, you can just call "abline" on the fitted model,
# but for more complicated arrangements the easiest way to visualize the model is to plot the
# predicted outcomes.
df$fitted <- fit3$fitted.values
with(df, points(stimulus, fitted, col="green"))