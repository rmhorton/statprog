Vectors and Matrices
========================================================
author: Bob Horton
date: 1/4/2015

Dot Product of two Vectors: Food Cost
========================================================

```r
price <- c( rice=2.16/20, oil=12.00/67, 
            fish=12.10/12, beans=2.02/12)
servings <- c( rice=7, oil=2, 
               fish=2, beans=4)

sum(price * servings)
```

```
[1] 3.804
```

```r
price %*% servings
```

```
      [,1]
[1,] 3.804
```

Nutrition Information
========================================================
A matrix can hold nutrition information for various foods.



```
           rice      oil   fish    beans
carb     35.000   0.0000  0.000  23.0000
fat       0.000  14.0000  1.000   0.0000
protein   3.000   0.0000 16.000   9.0000
kCal    155.800 123.2000 74.400 131.2000
cost      0.108   0.1791  1.008   0.1683
```

Dot Product of two Vectors
===
Find the calorie content of the given diet.

```r
N["kCal",] %*% servings
```

```
     [,1]
[1,] 2011
```

Multiplying a Matrix by a Vector
========================================================
Calculate the nutrition information for a given diet

```r
servings
```

```
 rice   oil  fish beans 
    7     2     2     4 
```

```r
N %*% servings
```

```
            [,1]
carb     337.000
fat       30.000
protein   89.000
kCal    2010.600
cost       3.804
```

Multiplying a Matrix by a Vector
========================================================


```r
diets
```

```
     [,1] [,2] [,3]
[1,]    7    4    4
[2,]    2    5    3
[3,]    2    7    0
[4,]    4    2    8
```

```r
N %*% diets
```

```
            [,1]     [,2]     [,3]
carb     337.000  186.000  324.000
fat       30.000   77.000   42.000
protein   89.000  142.000   84.000
kCal    2010.600 2022.400 2042.400
cost       3.804    8.723    2.316
```

Behavior of `diag()` depends on input type
========================================================
- matrix -> extracts the diagonal
- missing, but `nrow` is specified -> identity matrix
- length-one vector -> identity matrix
- numeric vector -> a matrix with the given diagonal and zeros elsewhere


Behavior of diag() depends on input type
========================================================

```r
M <- matrix(1:25, 
        nrow=5)
diag(M)
```

```
[1]  1  7 13 19 25
```

```r
diag(nrow=2)
```

```
     [,1] [,2]
[1,]    1    0
[2,]    0    1
```

***


```r
diag(2)
```

```
     [,1] [,2]
[1,]    1    0
[2,]    0    1
```

```r
diag(1:2)
```

```
     [,1] [,2]
[1,]    1    0
[2,]    0    2
```
