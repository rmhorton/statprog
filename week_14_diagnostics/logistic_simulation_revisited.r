N <- 1e2

sim_cancer <- function(N){
	logistic <- function(t) 1 / (1 + exp(-t))

	carcinogens <- runif(N, min=0, max=100)
	age <- sample(10:99, N, replace=T)
	score <- 0.1 * (carcinogens - mean(carcinogens)) + 
			0.01 * (age - mean(age)) - 2
	prob <- logistic(score)
	cancer <- factor(ifelse(prob > runif(N), "Yes", "No"))
	
	data.frame(age, carcinogens, cancer)
}


d1 <- sim_cancer(N)

fit1 <- glm(cancer ~ I(carcinogens - mean(carcinogens)) + I(age - mean(age)) + 1, 
		data=d1, family="binomial")

coef(fit1)

plot(d1$cancer, predict(fit1, type="response"), notch=T)

compute_sensitivity <- function(actual, predicted)
    sum(predicted==TRUE & actual==TRUE) / sum(actual==TRUE)

compute_specificity <- function(actual, predicted)
    sum(predicted==FALSE & actual==FALSE) / sum(actual==FALSE)

d2 <- sim_cancer(N)
actual <- d2$cancer=="Yes"
predicted <- predict(fit1, newdata=d2, type="link")

cutoff <- seq(-10,10, length=N)
roc_df <- as.data.frame(do.call("rbind", lapply(cutoff, function(threshold){
  c(
      threshold=threshold, 
      sensitivity=compute_sensitivity(actual, predicted > threshold), 
      specificity=compute_specificity(actual, predicted > threshold)
  )
})))

with(roc_df, {
  # approximate AUC by numerical integration
  auc <- sum(roc_df$sensitivity[-1] * diff(roc_df$specificity))
  plot(1 - specificity, sensitivity, 
        xlim=c(0,1), ylim=c(0,1), 
        main=sprintf("AUC = %0.2f%%", 100 * auc),
        type="s")
})


library(ROCR)

pred <- prediction(predicted, ifelse(d2$cancer=="Yes", 1, 0))
pred <- prediction(predicted, d2$cancer=="Yes")
perf <- performance(pred,"tpr","fpr")
plot(perf)

auc <- performance(pred,"auc")@y.values[[1]][1]
auc
