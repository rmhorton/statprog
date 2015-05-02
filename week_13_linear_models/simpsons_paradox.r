# In Simpson's Paradox, the overall effect is in the opposite direction of the effect for each category.

sim_simpsons <- function(slopes, intercepts,  doses, N = 100){
  
  category <- sample(LETTERS[1:2], N, replace=T)
  dose <- doses[category] + rnorm(N)
  response = intercepts[category] + slopes[category] * dose + rnorm(N)
  data.frame( category, dose, response )
}

plot_simpsons <- function(df, cat_colors){
  
  with(df, plot(response ~ dose, col=cat_colors[category]))
  
  fit1 <- lm( response ~ dose, data=df)
  abline(fit1, lty=2, lwd=4)
  
  fit2 <- lm( response ~ category - 1, data=df)
  abline(h=coef(fit2)[["categoryA"]], col=cat_colors["A"], lty=3, lwd=3)
  abline(h=coef(fit2)[["categoryB"]], col=cat_colors["B"], lty=3, lwd=3)
  
  fit3 <- lm( response ~ category + category:dose - 1, data=df)
  abline(coef(fit3)[["categoryA"]], coef(fit3)[["categoryA:dose"]], col=cat_colors["A"], lty=2, lwd=4)
  abline(coef(fit3)[["categoryB"]], coef(fit3)[["categoryB:dose"]], col=cat_colors["B"], lty=2, lwd=4)
}

df <- sim_simpsons(slopes = c(A=1.1, B=1.1), intercepts = c(A=12, B=5), doses=c(A=8, B=10),  N=100)

plot_simpsons(df, cat_colors=c(A="blue", B="red"))

library(manipulate)
N <- 1000

manipulate({
    df <- sim_simpsons(slopes = c(A=slopeA, B=slopeB), 
                       intercepts = c(A=interceptA, B=interceptB), 
                       doses=c(A=doseA, B=doseB),  N=100)
    plot_simpsons(df, cat_colors=c(A="blue", B="red"))
  }, 
  slopeA = slider(min=-10, max=10, initial=1.1, step=0.1),
  slopeB = slider(min=-10, max=10, initial=1.1, step=0.1),
  doseA = slider(min=0, max=15, initial=8, step=0.1),
  doseB = slider(min=0, max=15, initial=10, step=0.1),
  interceptA = slider(min=0, max=20, initial=12, step=0.1),
  interceptB = slider(min=0, max=20, initial=5, step=0.1)
)

###

simulate_dose_symptoms_data <- function(N=300){
  severity = sample(c("mild", "moderate", "severe"), N, replace=T)
  mean_dose = c(mild=5, moderate=10, severe=15)
  dose = rnorm(N, mean=mean_dose[severity], sd=2)
  untreated_symptoms = c(mild=5, moderate=10, severe=15)
  symptoms = untreated_symptoms[severity] - 0.5 * dose + rnorm(N, sd=2)
  data.frame(severity, dose, symptoms)
}
ds_data <- simulate_dose_symptoms_data(300)
plot(symptoms ~ dose, col=severity, data=ds_data)

fit_wrong <- lm(symptoms ~ dose, data=ds_data)
abline(fit_wrong)

fit_right <- lm( symptoms ~ severity + dose - 1, data=ds_data)
points( ds_data$dose, fit_right$fitted.values, col="blue", pch=4)
summary(fit_right)
