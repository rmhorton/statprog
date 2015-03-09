Lecture 06b: Interfacing to databases
========================================================
author: Bob Horton
date: 3/4/2015

Doctors and Patients: many-to-many
========================================================


<h2>patient</h2>

| id|name |sex |
|--:|:----|:---|
|  1|Alt  |F   |
|  2|Box  |M   |
|  3|Cox  |M   |
|  4|Dew  |F   |
|  5|Ely  |F   |

<h2>doctor</h2>

| id|md   |dept |
|--:|:----|:----|
|  1|Kane |GI   |
|  2|Lake |ID   |
|  3|Mayo |AI   |
|  4|Nash |OB   |

***

<h2>patient-doctor</h2>

| pt| dr|
|--:|--:|
|  1|  2|
|  1|  4|
|  2|  1|
|  3|  1|
|  4|  4|
|  4|  3|

Projection: SQL
========================================================

```
SELECT name FROM patient
```

```
  name
1  Alt
2  Box
3  Cox
4  Dew
5  Ely
```

Projection: R
========================================================

```r
patient['name']
```

```
  name
1  Alt
2  Box
3  Cox
4  Dew
5  Ely
```

```r
patient$name  # patient[['name']]; patient[,'name']
```

```
[1] Alt Box Cox Dew Ely
Levels: Alt Box Cox Dew Ely
```

Selection: SQL
========================================================

```
SELECT * FROM patient WHERE sex = 'F'
```

```
  id name sex
1  1  Alt   F
2  4  Dew   F
3  5  Ely   F
```

Selection: R
========================================================

```r
patient[patient$sex=='F',]
```

```
  id name sex
1  1  Alt   F
4  4  Dew   F
5  5  Ely   F
```

Left Outer Join: SQL
========================================================

```
SELECT p.id as pt, dr, md, dept, name, sex 
FROM patient p 
LEFT OUTER JOIN patient_doctor pd ON p.id=pd.pt
LEFT OUTER JOIN doctor d ON pd.dr=d.id
```

```
  pt dr   md dept name sex
1  1  2 Lake   ID  Alt   F
2  1  4 Nash   OB  Alt   F
3  2  1 Kane   GI  Box   M
4  3  1 Kane   GI  Cox   M
5  4  3 Mayo   AI  Dew   F
6  4  4 Nash   OB  Dew   F
7  5 NA <NA> <NA>  Ely   F
```

One-sided Outer Join: R
========================================================

```r
merge(
    merge(patient_doctor, doctor,
          by.x='dr', by.y='id', all.x=TRUE),
    patient, by.x='pt', by.y='id', all.y=TRUE)
```

```
  pt dr   md dept name sex
1  1  2 Lake   ID  Alt   F
2  1  4 Nash   OB  Alt   F
3  2  1 Kane   GI  Box   M
4  3  1 Kane   GI  Cox   M
5  4  3 Mayo   AI  Dew   F
6  4  4 Nash   OB  Dew   F
7  5 NA <NA> <NA>  Ely   F
```

Aggregation: SQL
========================================================

```r
sql <- "SELECT dr, count(*) as num_pt FROM patient_doctor GROUP BY dr"
sqldf(sql)
```

```
  dr num_pt
1  1      2
2  2      1
3  3      1
4  4      2
```

Aggregation: dplyr
========================================================

```r
library('dplyr')
patient_doctor %>% group_by(dr) %>% summarize(num_pt=n()) %>% as.data.frame()
```

```
  dr num_pt
1  1      2
2  2      1
3  3      1
4  4      2
```

Aggregation: R
========================================================

```r
aggregate(patient_doctor['pt'], by=list(dr=patient_doctor$dr), length)
```

```
  dr pt
1  1  2
2  2  1
3  3  1
4  4  2
```

```r
table(patient_doctor$dr)
```

```

1 2 3 4 
2 1 1 2 
```
