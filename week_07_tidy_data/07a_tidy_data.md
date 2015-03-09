Tidy Data
========================================================
author: Bob Horton
date: 2015-03-08


Tidy Data
========================================================

Wickham, H. [Tidy Data](http://www.jstatsoft.org/v59/i10/paper). Journal of Statistical Software 59(10), August 2014. ([data](http://www.jstatsoft.org/v59/i10/supp/4))


```r
library("magrittr")
library("tidyr")
library("dplyr")
```


Tidy Data
========================================================
* variable == column
* observation == row
* One type of observational unit per table

Like 3NF, but focused on single table.
Good for vectorization.


Tidy Data
========================================================

```r
N <- 100
set.seed(1)
medical_bills <- data.frame(
    sex=sample(c("M", "F"), N, replace=T), 
	billed=round(runif(N, min=200, max=20000),2),
	pct_paid = round( 100 * runif(N), 1 )
)
head(medical_bills)
```

```
  sex   billed pct_paid
1   M 13163.53     26.8
2   M  7193.31     21.9
3   F  5551.15     51.7
4   F 19855.14     26.9
5   M 12743.17     18.1
6   F  4421.52     51.9
```


Relationships Between Variables
========================================================
It is easier to describe functional relationships between variables than between rows


```r
medical_bills <- medical_bills %>% mutate(amt_paid = (pct_paid / 100 ) * billed)
head(medical_bills)
```

```
  sex   billed pct_paid amt_paid
1   M 13163.53     26.8 3527.826
2   M  7193.31     21.9 1575.335
3   F  5551.15     51.7 2869.945
4   F 19855.14     26.9 5341.033
5   M 12743.17     18.1 2306.514
6   F  4421.52     51.9 2294.769
```


Comparing Subgroups
========================================================
It is easier to make comparisons between groups of observations than between groups of columns.


```r
summary_by_sex <- medical_bills %>% 
    group_by(sex) %>% 
    summarize( 
        avg=mean(amt_paid), 
        cnt=n(), tot=sum(amt_paid))

kable(summary_by_sex)
```



|sex |      avg| cnt|      tot|
|:---|--------:|---:|--------:|
|F   | 4829.277|  48| 231805.3|
|M   | 4307.659|  52| 223998.3|


Table 1
========================================================


|name         | treatmenta| treatmentb|
|:------------|----------:|----------:|
|John Smith   |         NA|          2|
|Jane Doe     |         16|         11|
|Mary Johnson |          3|          1|


Table 2
========================================================


|           | John Smith| Jane Doe| Mary Johnson|
|:----------|----------:|--------:|------------:|
|treatmenta |         NA|       16|            3|
|treatmentb |          2|       11|            1|


Table 3
========================================================


```r
table_3 <- table_1 %>% 
    gather(treatment, result, -name)
table_3
```

```
          name  treatment result
1   John Smith treatmenta     NA
2     Jane Doe treatmenta     16
3 Mary Johnson treatmenta      3
4   John Smith treatmentb      2
5     Jane Doe treatmentb     11
6 Mary Johnson treatmentb      1
```


Organizing for Human Readability
========================================================

* Fixed variables
    - reflect experimental design
    - are known in advance
* Measured Variables
    - measured during study

Sort rows by fixed variables.
Put columns for fixed variables first


Common problems in messy datasets
========================================================
* values stored in column headers
* multiple variables stored in a single column
* variables stored in both rows and columns
* multiple types of entities in the same table
* one entity in multiple tables

Gathering and Spreading
========================================================

```r
raw <- data.frame(
    row=LETTERS[1:3],
    a=1:3,
    b=4:6,
    c=7:9
)
raw
```

```
  row a b c
1   A 1 4 7
2   B 2 5 8
3   C 3 6 9
```

***


```r
gathered <- raw %>% gather(column, value, -row)
gathered
```

```
  row column value
1   A      a     1
2   B      a     2
3   C      a     3
4   A      b     4
5   B      b     5
6   C      b     6
7   A      c     7
8   B      c     8
9   C      c     9
```

```r
spread(gathered, column, value)
```

```
  row a b c
1   A 1 4 7
2   B 2 5 8
3   C 3 6 9
```


Fundamental Verbs of Data Manipulation:
========================================================
* Filter: subset based on conditions
* Transform: add or modify variables
    - single variable: `log()`
	- multiple variables: `density <- weight / volume`
* Aggregate:  `sum()`, `mean()`
* Sort: change the order of observations

Other tasks involved in data cleaning
========================================================
* parsing dates and numbers
* correcting character encodings
* identifying missing values
* filling in structural missing values
* matching similar values (e.g., from typos)
* verifying experimental design
* model-based data cleaning to identify suspicious values
