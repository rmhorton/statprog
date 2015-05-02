N <- 1000

# Try changing the probabilities of each category. If one group is a minority, the main effects for the overall population can give wrong predictions for the minority group.

simulate_data <- function(intercepts, slopes, N){
  category = sample(names(intercepts), N, replace=T)
  dose = runif(N, min=0, max=10)
  response = 0 + intercepts[as.character(category)] + slopes[as.character(category)] * dose + rnorm(N)
  data.frame(category, dose, response)
}

intercepts <- c( Tall=10, Medium=0, Short=-10)
slopes <- c(Tall=-1, Medium=0, Short=1)
cat_colors <- c(Tall="red", Medium="orange", Short="darkgreen")

df <- simulate_data(intercepts, slopes, N=300)

with(df, plot(response ~ dose, col=cat_colors[as.character(category)]))

fit1 <- lm(response ~ dose*category, data=df)
with(df, points(dose, fit1$fitted.value, col="blue", pch=4))
summary(fit1)

fit2 <- lm(response ~ category + dose:category, data=df)
with(df, points(dose, fit2$fitted.value, col="blue", pch=4))
summary(fit2)

fit3 <- lm(response ~ category + dose:category - 1, data=df)
with(df, points(dose, fit2$fitted.value, col="blue", pch=4))
summary(fit3)

