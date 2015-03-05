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

Left Outer Join: SQL
========================================================


```
SELECT p.id, p.name, sex, dr, md, dept 
    FROM patient p 
    LEFT OUTER JOIN patient_doctor pd 
        ON p.id=pd.pt
    LEFT OUTER JOIN doctor d 
        ON pd.dr=d.id
```

```
  id name sex dr   md dept
1  1  Alt   F  2 Lake   ID
2  1  Alt   F  4 Nash   OB
3  2  Box   M  1 Kane   GI
4  3  Cox   M  1 Kane   GI
5  4  Dew   F  3 Mayo   AI
6  4  Dew   F  4 Nash   OB
7  5  Ely   F NA <NA> <NA>
```

Left Outer Join: R
========================================================

```r
merge(
    merge(patient, patient_doctor, 
          by.x='id', by.y='pt', all.x=TRUE),
    doctor, by.x='id', by.y='id', all.x=TRUE)
```

```
  id name sex dr   md dept
1  1  Alt   F  2 Kane   GI
2  1  Alt   F  4 Kane   GI
3  2  Box   M  1 Lake   ID
4  3  Cox   M  1 Mayo   AI
5  4  Dew   F  4 Nash   OB
6  4  Dew   F  3 Nash   OB
7  5  Ely   F NA <NA> <NA>
```

Aggregation: SQL
========================================================


```r
sql <- "SELECT dr, count(*) as num_patients FROM patient_doctor GROUP BY dr"
sqldf(sql)
```

```
  dr num_patients
1  1            2
2  2            1
3  3            1
4  4            2
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

Aggregation: dplyr
========================================================

```r
library('dplyr')
patient_doctor %>% group_by(dr) %>% summarize(num_patients=n())
```

```
Source: local data frame [4 x 2]

  dr num_patients
1  1            2
2  2            1
3  3            1
4  4            2
```
