# In Simpson's Paradox, the overall effect is in the opposite direction of the effect for each category.

N <- 100

coeffA <- 1.1
coeffB <- 1.1

interceptA <- 12
interceptB <- 5

df <- data.frame(
	category = sample(LETTERS[1:2], N, prob=c(0.5, 0.5), replace=T)
)

df$stimulus <- ifelse( df$category=="A", 8 + rnorm(N), 10 + rnorm(N) )
df <- transform(df,
	response = ifelse( category=="A",
		interceptA + coeffA * stimulus, interceptB + coeffB * stimulus) + rnorm(N)
)

with(df, plot(response ~ stimulus, col=category))

fit1 <- lm( response ~ stimulus, data=df)
summary(fit1)

fit2 <- lm( response ~ category, data=df)
summary(fit2)

fit3 <- lm( response ~ stimulus:category, data=df)
summary(fit3)



library(manipulate)
N <- 1000

manipulate({
    category <- sample(LETTERS[1:2], N, prob=c(0.5, 0.5), replace=T)
    stimulus <- ifelse( category=="A", 
                        rnorm(N, stim_mean_A, stim_sd_A), 
                        rnorm(N, stim_mean_B, stim_sd_B) )
    response <- ifelse( category=="A",
                        interceptA + coeffA * stimulus, interceptB + coeffB * stimulus) + rnorm(N)
    
    plot(response ~ stimulus, col=factor(category))
    abline(lm(response[category=="A"] ~ stimulus[category=="A"]), col="green", lty=3, lwd=4)
    abline(lm(response[category=="B"] ~ stimulus[category=="B"]), col="green", lty=3, lwd=4)
    abline(lm(response ~ stimulus), col="blue", lty=3, lwd=4)
  }, 
  coeffA = slider(min=-10, max=10, initial=1, step=0.1),
  coeffB = slider(min=-10, max=10, initial=1, step=0.1),
  stim_mean_A = slider(min=0, max=10, initial=3, step=0.1),
  stim_mean_B = slider(min=0, max=10, initial=5, step=0.1),
  stim_sd_A = slider(min=0, max=10, initial=1, step=0.1),
  stim_sd_B = slider(min=0, max=10, initial=1, step=0.1),
  interceptA = slider(min=0, max=20, initial=8, step=0.1),
  interceptB = slider(min=0, max=20, initial=2, step=0.1)
)

