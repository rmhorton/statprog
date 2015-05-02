N <- 1000

simulate_data <- function(intercepts, slopes, N){
  category = sample(names(intercepts), N, replace=T)
  dose = runif(N, min=0, max=10)
  response = intercepts[category] + slopes[category] * dose + rnorm(N)
  data.frame(category, dose, response)
}

intercepts <- c( Tall=10, Medium=5, Short=-10)
slopes <- c(Tall=-1, Medium=0, Short=1)
cat_colors <- c(Tall="red", Medium="orange", Short="darkgreen")

df <- simulate_data(intercepts, slopes, N=300)

with(df, plot(response ~ dose, col=cat_colors[as.character(category)]))

# First try: use a formula with all interactions between dose and category, plus intercept.
# The predicted values show the lines fit by the model, but the coefficients seem complicated.
fit1 <- lm(response ~ dose*category, data=df)
with(df, points(dose, fit1$fitted.value, col="blue", pch=4))
summary(fit1)

# Second try: specify only certain interaction terms; still includes intercept.
# The predicted values are the same, but you need to do some subtracting to find the group intercepts.
fit2 <- lm(response ~ category + dose:category, data=df)
with(df, points(dose, fit2$fitted.value, col="green", pch=4))
summary(fit2)

# Third try: leave off global intercept.
# Again, the predictions are the same, but now the group-specific intercepts are easy to see.
fit3 <- lm(response ~ category + dose:category - 1, data=df)
with(df, points(dose, fit2$fitted.value, col="yellow", pch=4))
summary(fit3)

