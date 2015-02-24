Web Scraping
========================================================
author: Bob Horton
date: 2015-02-23

Read HTML Table
========================================================

```r
site <- "http://en.wikipedia.org/wiki/List_of_countries_by_life_expectancy"
mydf <- XML::readHTMLTable(site, which=3, stringsAsFactors=F)
kable(head(mydf))
```



|Rank |state/territory    |Overall |Male  |Female |
|:----|:------------------|:-------|:-----|:------|
|1    |Japan              |82.73   |79.29 |86.96  |
|2    |Switzerland        |81.81   |79.31 |84.12  |
|3    |Hong Kong ( China) |81.61   |79.04 |84.30  |
|4    |Australia          |81.44   |79.12 |84     |
|5    |Italy              |81.37   |78.58 |83.98  |
|6    |Iceland            |81.28   |79.49 |83.05  |

rvest
========================================================

magrittr
========================================================

<table>
<tr><td>
!["Ceci n'est pas un pipe](http://upload.wikimedia.org/wikipedia/en/b/b9/MagrittePipe.jpg)
</td><td>
[%>%](http://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)

</td></tr>
</table>

selectorGadget
========================================================

Allows you to interactively click on parts of a web page and use a process of positive nad negative seletcion to generate CSS selectors for targeted information.

rvest
===


```r
devtools::install_github("hadley/rvest")
library(magrittr)
library(rvest)
cigcancerpage <- html("http://lib.stat.cmu.edu/DASL/Datafiles/cigcancerdat.html")
txt_con <- cigcancerpage %>% 
  html_nodes("pre") %>% .[2] %>% 
  html_text() %>% textConnection()
headers <- readLines(txt_con,2) %>% .[2] %>% 
  gsub("^\\s+", "", .) %>%
  strsplit("\\s+") %>% .[[1]]
cigcancer <- read.delim(txt_con, header=F)
colnames(cigcancer) <- headers
```

Interesting Tables in Wikipedia
===

http://en.wikipedia.org/wiki/List_of_cancer_mortality_rates_in_the_United_States
http://en.wikipedia.org/wiki/List_of_countries_by_cancer_rate
http://en.wikipedia.org/wiki/Prevalence_of_tobacco_consumption
http://stats.wikimedia.org/EN/TablesWikipediaEN.htm
