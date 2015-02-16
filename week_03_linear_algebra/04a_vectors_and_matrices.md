Vectors and Matrices
========================================================
author: Bob Horton
date: 1/4/2015



Counting Change
========================================================


```r
coin_values <- c(quarter=25, dime=10, nickle=5, penny=1)
coin_counts <- c(quarter=3, dime=3, nickle=1, penny=7)
sum(coin_counts * coin_values)
```

```
[1] 117
```

```r
coin_counts %*% coin_values
```

```
     [,1]
[1,]  117
```

Counting Change for the Whole Class
========================================================



```r
class_coins
```

```
      quarters dimes nickles pennies
Alice        5     2       0       3
Bob          3     3       1       7
Carol        8     2       2       1
```

```r
class_coins %*% coin_values
```

```
      [,1]
Alice  148
Bob    117
Carol  231
```

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
[1] 3.8
```

```r
price %*% servings
```

```
     [,1]
[1,]  3.8
```

Nutrition Information
========================================================
A matrix can hold nutrition information for various foods.



```
           rice     oil  fish   beans
carb     35.000   0.000  0.00  23.000
fat       0.000  14.000  1.00   0.000
protein   3.000   0.000 16.00   9.000
kCal    155.800 123.200 74.40 131.200
cost      0.108   0.179  1.01   0.168
```

Dot Product of Vectors: calories in a diet
===

```r
servings
```

```
 rice   oil  fish beans 
    7     2     2     4 
```

```r
N["kCal",]
```

```
 rice   oil  fish beans 
155.8 123.2  74.4 131.2 
```

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
carb     337.0
fat       30.0
protein   89.0
kCal    2010.6
cost       3.8
```

Multiplying Matrices
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
          [,1]    [,2]    [,3]
carb     337.0  186.00  324.00
fat       30.0   77.00   42.00
protein   89.0  142.00   84.00
kCal    2010.6 2022.40 2042.40
cost       3.8    8.72    2.32
```
