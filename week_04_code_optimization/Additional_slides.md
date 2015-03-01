Characteristics of R
========================================================
* Scripting language
    - many internals are written in C/C++ or Fortran
* Built-in data structures
    - vectors, matrixes, lists, data frames, environments
    - every variable is at least a vector
        + the columns of a data frame are vectors
        + a matrix is a 2D vector
* Functional
    - functions can take other functions as parameters
    - minimize side-effects and mutable data

Idioms in R
========================================================
* Process data by batch, not by item
    - Use vector (or matrix) operations if possible
    - Avoid growing data structures in memory
    - Be declarative rather than imperative
    - Use functional approaches when appropriate
        + *map*: `*apply` family of functions
        + *filter*: subsetting operators, `grep`, etc.
        + *reduce*: `sum`, `do.call`, etc.
* R has a large vocabulary. Use it.
    - Use available functions / packages
    - Use appropriate data structures



Vectorizing
========================================================
_Question_ - What is the fastest way to run this function on a vector of inputs?


```r
g <- function(n) n^2 + rnorm(1, sd=10)
```

Vectorizing
========================================================
_Answer_ - Fix the function so it works on vector input











```
Error in eval(expr, envir, enclos) : could not find function "qplot"
```
