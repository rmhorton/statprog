N <- 10000

x <- runif(N, min=-100, max=100)
xcat <- cut(x, breaks=quantile(x, probs=0:10/10), include.lowest=T, labels=LETTERS[1:10])
y <- 0.001 * x^2 + rnorm(N)

plot(x,y)

plot(xcat, y)
sse <- function(actual, predicted) sum((actual - predicted)^2)

library(dplyr)
df <- data.frame(x, xcat, y)

cat_means <- df %>% group_by(xcat) %>% summarize(mean=mean(y))
# aggregate(y, by=list(xcat), mean)

df$pred1 <- mean(y)
df$pred2 <- cat_means[df$xcat,]$mean

sse1 <- with(df, sse(y, pred1))
sse2 <- with(df, sse(y, pred2))

1 - sse2/sse1

fit_cat <- lm(y ~ xcat)
summary(fit_cat)

df$pred3 <- df$x^2 * 0.001
sse3 <- with(df, sse(y, pred3))
1 - sse3/sse1

fit_num <- lm(y ~ I(x^2), data=df)
summary(fit_num)
