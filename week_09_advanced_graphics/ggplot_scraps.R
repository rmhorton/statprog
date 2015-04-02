### flu simulation ###


# http://en.wikipedia.org/wiki/Flu_season
# http://www.cdc.gov/flu/about/season/flu-season.htm
N <- 365 * 4
x <- 1:N

season_breaks <- c(spring_equinox = "2015-03-20", 
	summer_solstice = "2015-06-21", 
	fall_equinox = "2015-09-23", 
	winter_solstice = "2015-12-22")

# actually dates of equinox vary by year; pretty close though
season_breaks_doy <- format(as.Date(season_breaks), "%j")

flu <- data.frame( 
	date = as.Date("1990-10-01") + x, 
	rate = 7 + sin(2 * pi * x/365.25) + rnorm(N)
)

doy <- as.integer(format(flu$date, "%j"))

flu$season = cut(doy, breaks=c(0, season_breaks_doy, 367))
levels(flu$season) <- list(winter=c("(0,79]", "(356,367]"), spring="(79,172]", summer="(172,266]", fall="(266,356]")

### group interactions ###
N <- 200
sex <- sample(c("F", "M"), N, replace=T)
race <- sample(c("white", "black", "AIAN", "asian", "NHPI"), N, replace=T)

# http://www.census.gov/prod/2003pubs/c2kbr-25.pdf
occupation <- sample(c("professional", "service", "sales", "agriculture", "construction", "production"), N, replace=T)

risk <- ifelse( sex == "F", 0.05, ifelse( race=="asian", 0.01, ifelse(occupation=="agriculture", 0.1, 0.02)))

# rnorm(N, mean=risk, sd=risk/4)

grp <- data.frame(
	sex = sex,
	race = race,
	occupation = occupation, 
	disease = rnorm(N) < risk
)


grp$disease <- as.factor(ifelse(grp$disease, "YES", "NO"))


##########################


p0 + theme(legend.position = "bottom") + ggtitle("Bottom")
p0 + theme(legend.position = "left") + ggtitle("Left")
p0 + theme(legend.position = "none") + ggtitle("None")
p0 + theme(legend.position = c(0.15, 0.8)) + ggtitle("Inside")
p0 + ggtitle("Default")


p + theme(
  panel.background = element_rect(fill = "lightblue"),
  panel.grid.minor = element_line(linetype = "dotted"),
  legend.position = "none"
)

p + theme(
  panel.grid.major = element_line(color = "gray60", size = 0.8),
  panel.grid.major.x = element_blank(),
  legend.position = "none"
)

q0 + theme(
  plot.background = element_rect(
    fill = "lightblue",
    colour = "black",
    size = 2,
    linetype = "longdash")
  )
  
Built-in themes
theme_grey()
theme_bw()

ggthemes: https://github.com/jrnold/ggthemes

# stable version
install.packages('ggthemes', dependencies = TRUE)

library(devtools)
install_github("jrnold/ggthemes")

ggtheme_list <- list(
	theme_calc,
	theme_economist,
	theme_excel,
	theme_few,
	theme_fivethirtyeight,
	theme_gdocs,
	theme_hc,
	theme_pander,
	theme_solarized,
	theme_stata,
	theme_tufte,
	theme_wsj
)

# http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/


g + ggtitle("This is a long title\nthat could say a lot of stuff") +
	theme(plot.title = element_text(size=20, face="bold", vjust=1, lineheight=0.8))

g + theme(axis.text.x=element_text(angle=50, size=20, vjust=0.5))

g + scale_x_continuous(limits=c(0,35))  # removes data points outside the range
g + coord_cartesian(xlim=c(0,35))       # adjusts the visible area

ggplot(nmmaps, aes(temp, temp+rnorm(nrow(nmmaps), sd=20))) + geom_point() +
  xlim(c(0,150)) + ylim(c(0,150)) +
  coord_equal()

g + theme(legend.title=element_blank())


g + theme(legend.title = element_text(colour="chocolate", size=16, face="bold"))+
  scale_color_discrete(name="This color is\ncalled chocolate!?")
  
g + guides(colour = guide_legend(override.aes = list(size=4)))



library(ggthemes)
ggplot(nmmaps, aes(date, temp, color=factor(season)))+
  geom_point()+ggtitle("This plot looks a lot different from the default")+
  theme_economist()+scale_colour_economist()
  
# Alternatives to box plot

## box plot
g <- ggplot(nmmaps, aes(x=season, y=o3))
g + geom_boxplot(fill="darkseagreen4")

## Jittered points
g + geom_jitter(alpha=0.5, aes(color=season),position = position_jitter(width = .2))

## Violin Plot
g + geom_violin(alpha=0.5, color="gray")


# Smoothing

ggplot(nmmaps, aes(date, temp))+geom_point(color="firebrick") + 
  stat_smooth()


ggplot(nmmaps, aes(date, temp))+
  geom_point(color="grey")+
  stat_smooth(method="gam", formula=y~s(x,k=10), col="darkolivegreen2", se=FALSE, size=1)+
  stat_smooth(method="gam", formula=y~s(x,k=30), col="red", se=FALSE, size=1)+
  stat_smooth(method="gam", formula=y~s(x,k=500), col="dodgerblue4", se=FALSE, size=1)
  
ggplot(nmmaps, aes(temp, death))+geom_point(color="firebrick")+
  stat_smooth(method="lm", se=FALSE)
  
library(dplyr)
library(lubridate)

### Chapter 11


## 2d density

# show densely overplotted scattergram

with(flu, smoothScatter(date, flu))
with(flu, smoothScatter(date, flu, transformation=exp))


        
library(vcd)
mosaic(~Class+Sex+Age+Survived, data=Titanic, shade=TRUE, legend=TRUE)

library(corrgram)
corrgram(df2, order=TRUE, lower.panel=panel.shade,
            upper.panel=panel.pts, text.panel=panel.txt,
            main="Corrgram")


ggplot cheatsheet
http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/