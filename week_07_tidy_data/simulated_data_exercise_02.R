# Blood pressure simulation.
# We made the basic simulation in class; I have added a series of plots to visualize how
# the variables are distributed. Based on these plots, I adjusted parameters and added noise
# until I got the sorts of patterns I want. 


generate_dataset <- function(N){
	HEIGHT_MEAN <- c( F = 1.6, M = 1.8 )
	HEIGHT_SD <- 0.15
	WEIGHT_MEAN <- c( F = 54, M = 70 )
	WEIGHT_SD <- 20
	
	bmi <- function(height, weight) weight/height^2

	sbp <- function(sex, salt, bmi, etoh){
		ifelse (sex == "M",
			90 + 0.005 * salt + 1.0 * bmi - 0.01 * etoh,
			80 + 0.005 * salt + 1.5 * bmi - 0.01 * etoh)
	}

	sex <- sample(c("M", "F"), N, replace=TRUE)
	salt <- rnorm(N, mean=2200, sd=50)
	height <- rnorm(N, mean=HEIGHT_MEAN[sex], sd=HEIGHT_SD)
	weight <-  1.2 * ( height - HEIGHT_MEAN[sex] ) + WEIGHT_MEAN[sex] + rnorm(N, sd=WEIGHT_SD)
	etoh <- 50 * rpois(N, lambda=6)

	systolic <- sbp(sex, salt, bmi(height, weight), etoh) + rnorm(N, sd=5)
	
	# add some distractors
	car_makes <- unique(sapply( strsplit(row.names(mtcars), " "), "[", 1))
	car <- sample( car_makes, N, replace=TRUE)
	
	zodiac <- c("Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo",
	 "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces") 
	sign <- sample(zodiac, N, replace=TRUE)
	
	data.frame( sex, salt, height, weight, etoh, car, sign, systolic)
}

bpdata <- generate_dataset(200)


plot( systolic ~ height, col=sex, data=bpdata)

library(ggplot2)
g <- ggplot( data=bpdata, aes(x=height, y=systolic, col=sex)) + geom_point()
plot(g)

# height distribution: I fiddled with HEIGHT_SD until this looked ok
ggplot(bpdata, aes(x=height, col=sex)) + geom_density()

plot( systolic ~ weight, col=sex, data=bpdata)

bpdata <- transform(bpdata, bmi = weight/(height^2))
plot( systolic ~ bmi, col=sex, data=bpdata)

plot( systolic ~ weight:I(height^2), col=sex, data=bpdata)


xtabs( ~ sign + car, bpdata)

plot( systolic ~ sex, data=bpdata )

plot( bmi ~ sex, data=bpdata )
plot( weight ~ height, col=sex, data=bpdata )


xtabs( ~ sign + car, bpdata)

