
# quiz questions status
# quiz review
# deadlines
# fake data projects

# data munging scraps

# Tabulation: table, xtabs

T_shirts <- data.frame(
	sex=sample(c("M","F"), 100, replace=T), 
	size=sample(c("L", "M", "S"), 100, replace=T)
)

table(T_shirts)
xtabs(~ sex + size, T_shirts)

# How would you make a dataset where men are more likely to wear larger sizes?

T_shirts2 <- data.frame(
	sex=sample(c("M","F"), 100, replace=T), 
	size=sample(c("L", "M", "S"), 100, replace=T),
	price=round(rnorm(100, mean=15, sd=3), 2)
)

table(T_shirts2)
xtabs(~ sex + size, T_shirts2)
xtabs(price ~ sex + size, T_shirts2)

DF <- as.data.frame(UCBAdmissions)
xtabs(Freq ~ Gender + Admit, DF)
library("sqldf")
sqldf("SELECT Admit, Gender, sum(Freq) as Freq FROM DF group by Admit, Gender")

# multinomial regression example
N <- 100
sex <- sample(c("M","F"), N, replace=TRUE)
height <- 
model.matrix %*% coeff
