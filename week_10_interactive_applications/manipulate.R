library("manipulate")
library("ggplot2")

load("body_dat.rda")

body_dat$wrist_group <- cut(body_dat$wrist_diameter, 
                            quantile(body_dat$wrist_diameter, probs=0:5/5), 
                            include.lowest=TRUE)

body_dat$age_group <- cut(body_dat$age, 
                            quantile(body_dat$age, probs=0:5/5), 
                            include.lowest=TRUE)
manipulate(
  ggplot(data=body_dat, aes_string(x=x_col, y=y_col, col=color)) + geom_point() + geom_smooth(),
  x_col = picker("weight", "knee_diameter"), 
  y_col = picker("wrist_group", "height"), 
  color=picker("gender", "age_group"))
