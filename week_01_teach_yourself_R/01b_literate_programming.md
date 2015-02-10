Literate Programming
========================================================
author: Bob Horton
date: 12/30/2-14


Homework Exercise Review
========================================================
Unit circle
$$ r = 1 $$
$$ A_{circle} = \pi r^2 == \pi $$
$$ A_{square} = (2 r) ^ 2 == 4 $$

![plot of chunk more_darts](01b_literate_programming-figure/more_darts-1.png) 

Homework Exercise Review
========================================================

```r
N <- 10000
x <- runif(N, min=-1.0, max=1.0)
y <- runif(N, min=-1.0, max=1.0)
plot(x, y, pch=16, col=ifelse(x^2 + y^2<1, "red", "blue"))
```

![plot of chunk throwing_darts](01b_literate_programming-figure/throwing_darts-1.png) 

Homework Exercise Review
========================================================

```r
N <- 10000
x <- runif(N)
y <- runif(N)
plot(x, y, pch=16, col=ifelse(x^2 + y^2<1, "red", "blue"))
```

![plot of chunk darts_one_quad](01b_literate_programming-figure/darts_one_quad-1.png) 


Homework Exercise Review
========================================================

```r
estimate_pi <- function(N) {
    x <- runif(N)
    y <- runif(N)
	4 * sum( (x^2 + y^2) < 1 )/N
}
estimate_pi(100000)
```

```
[1] 3.14708
```

Homework Exercise Review
========================================================


```r
estimated_pi <- sapply(1:10000, function(i) estimate_pi(1000))
```



```
Error in library(ggplot2) : there is no package called 'ggplot2'
```
