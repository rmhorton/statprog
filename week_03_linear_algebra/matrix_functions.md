Matrix Functions
========================================================
author: Bob
date: 2/10/2015

Identity Matrix
========================================================

```r
I <- diag(5)
I
```

```
     [,1] [,2] [,3] [,4] [,5]
[1,]    1    0    0    0    0
[2,]    0    1    0    0    0
[3,]    0    0    1    0    0
[4,]    0    0    0    1    0
[5,]    0    0    0    0    1
```

Trace
========================================================

```r
A <- matrix(sample(1:16), nrow=4)
A
```

```
     [,1] [,2] [,3] [,4]
[1,]    5    3   14   13
[2,]    6   10    1    8
[3,]    9   11    2    4
[4,]   12   15    7   16
```

```r
# trace of (A)
sum(diag(A))
```

```
[1] 33
```

Determinant
========================================================

```r
library(Matrix)
elu <- expand(lu(A))
prod(diag(elu$U))
```

```
[1] 1215
```

```r
det(A)
```

```
[1] -1215
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
