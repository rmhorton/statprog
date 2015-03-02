attach(mtcars)
head(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)
matrix(c(1,1,2,3), 2, 2, byrow = TRUE)
attach(mtcars)
mtcars
disp
hist(disp)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
hist(disp)
plot(mpg ~ wt)
pie(disp)

dev.new()
layout(matrix(c(1,2,1,3),2,2,byrow=T))
matrix(c(1,2,1,3),2,2,byrow=T)
hist(disp)
plot(mpg ~ wt)
pie(table(cyl))
plot(mpg ~ wt)
matrix(c(1,2,1,3),2,2,byrow=T)
plot(mpg ~ wt)
pie(table(cyl))
matrix(c(1,2,1,3),2,byrow=T)
matrix(c(1,2,1,3),2,6,byrow=T)
L <- matrix(c(1,1,2,1,1,3,4,5,6), nrow=3, byrow=T)
L
layout(L)
plot(mpg ~ wt)
pie(table(cyl))
plot(wt , mpg)
mtcars
hist(disp, main="displacement")
pie(table(gears))
pie(table(gear))
pie(table(disp), main="displacement")
gear
table(gear)
pie(table(gear))
pie(gear)
layout()
layout(matrix(1,1,1))
pie(gear)
gear
table(gear)
pie(table(gear))
matrix(1,1,1)
c(1)
1
?layout
x <- runif(100, min=0, max=100)
y <- 6 + 1.2*x + rnorm(100, sd=5)
plot(x,y)
fit <- lm(y ~ x)
abline(fit, col"red")
abline(fit, col="red")
abline(v=10*(0:10), h=seq(20,120,by=10), lty=3, col="lightblue")
10*(0:10)
seq(20,120,by=10)
fit
coef(fit)
y0 <- coef(fit)[1]
y0
slope <- coef(fit)[2]
slope
abline(y0, slope, lty=2, lwd=3, col="yellow")
abline(y0+10, slope, lty=2, lwd=1, col="orange")
abline(y0-10, slope, lty=2, lwd=1, col="orange")
class(coef(fit))
?transform
?within
detach(mtcars)
cyl
attach(mtcars)
cyl
detach(mtcars)
with(mtcars, plot(cyl, disp))
plot(cyl, disp)
with(mtcars, barplot(cyl, disp))
with(mtcars, plot(cyl, disp))
head(mtcars)
foo <- within(mtcars, mpgw <- mpg / wt)
head(foo)
?transform
head(airquality)
transform(airquality, Ozone = -Ozone)
head( transform(airquality, new = -Ozone, Temp = (Temp-32)/1.8) )
head(airquality)
19.44444 * 1.8 + 32
head( within(airquality, new = -Ozone, Temp = (Temp-32)/1.8) )
head( within(airquality, {new = -Ozone; Temp = (Temp-32)/1.8)} )
head( within(airquality, {new = -Ozone; Temp = (Temp-32)/1.8}) )
?within
within(airquality, new = -Ozone)
within(airquality, new = -Ozone)
transform(airquality, new = -Ozone)
within(airquality, new = -Ozone)
within(airquality, new <- -Ozone)
within(airquality, new = -Ozone)
within(airquality, new <- -Ozone)
transform(airquality, new = -Ozone)
?transform
Student <- c("John Davis", "Angela Williams", "Bullwinkle Moose", "David Jones", "Janice Markhammer", "Cheryl Cushing", "Reuven Ytzrhak", "Greg Knox", "Joel England", "Mary Rayburn")
roster <- data.frame(Student)
name <- strsplit((roster$Student), " ")
name <- strsplit((roster$Student), " ")
name <- strsplit(roster$Student, " ")
?strsplit
roster$Student
roster <- data.frame(Student, stringsAsFactors=FALSE)
name <- strsplit(roster$Student, " ")
name
name <- strsplit(Student, " ")
name
roster <- data.frame(Student)
Student
roster$Student
myData <- data.frame(gender=sample(c("M","F"), 100), height=rnorm(100))
myData <- data.frame(gender=sample(c("M","F"), 100, replace=TRUE), height=rnorm(100))
myData
plot(gender)
plot(myData)
sapply(myData, class)
myData <- data.frame(gender=sample(c("M","F"), 100, replace=TRUE), height=rnorm(100), stringsAsFactors=F)
sapply(myData, class)
myData <- data.frame(gender=sample(c("M","F"), 100, replace=TRUE), height=rnorm(100))
sapply(myData, class)
dev.new()
myData <- data.frame(gender=sample(c("M","F"), 100, replace=TRUE), height=rnorm(100), stringsAsFactors=F)
plot(myData)
head(myData)
myData <- transform(myData, gender = factor(gender))
head(myData)
plot(myData)
myData <- transform(myData, gender = as.character(gender))
head(myData)
plot(myData)
df2 <- data.frame(gender=sample(c("M","F"), 100, replace=TRUE), grade=LETTERS[1:5])
head(df2)
head(df2)
plot(df2)
df3 <- transform(df2, color=sample(c("R","G","B"), 100, replace=TRUE))
head(df3)
plot(df3)
x <- runif(100, min=0, max=10)
y <- 6 + 3*x + rnorm(100, sd=4)
z <- 65 + 12*x + rnorm(100, sd=3)
df4 <- data.frame(x,y,z)
plot(df4)
minicars <- mtcars[c("cyl","mpg")]
head(minicars)
with(minicars, agregate(minicars, by=list(cyl), FUN=mean))
with(minicars, aggregate(minicars, by=list(cyl), FUN=mean))
with(minicars, aggregate(minicars, by=list(cyl), FUN=sd))
with(minicars, aggregate(minicars, by=list(cyl), FUN=sum))
with(minicars, aggregate(minicars, by=list(cyl), FUN=count))
with(minicars, aggregate(minicars, by=list(cyl), FUN=length))
aggregate(mtcars$mpg, by=list(mtcars$cyl), FUN=length)
aggregate(mtcars$mpg, by=list(mtcars$cyl), FUN=mean)
aggregate(mtcars, by=list(mtcars$cyl), FUN=mean)
x <- c(1, 5, 23, 24)
x <- c(1, 5, 23, 29)
dif(x)
diff(x)
?lag
lag(x)
?lag
pi
options(digits=12)
pi
options(digits=2)
pi
?options
x <- c(1000, 100, 10, 1, 0.3, 0.002)
x
x <- c(1000, 100, 10, 1, 1.3, 10.002)
x
options(digits=5)
x
L <- matrix(c(1,2,2,1),2)
L
layout(L)
attach(mtcars)
plot(mpg ~ wt)
pie(table(cyl))
plot(mpg ~ wt)
pie(table(cyl))
L <- matrix(c(1,2,1,2),2)
L
layout(L)
plot(mpg ~ wt)
pie(table(cyl))
title("My Fancy Layout", outer=T)
op <- par(oma=c(1,1,3,1))
layout(L)
plot(mpg ~ wt)
pie(table(cyl))
title("My Fancy Layout", outer=T)
history()
history()
?history
getwd()
savehistory(file="office_hours_20140214.R")
