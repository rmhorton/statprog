DATA_DIR <- "/Volumes/data/Courses/USF_stats_programming/"
library("RCurl")
library("magrittr")

class_data <- read.delim(file.path(DATA_DIR, "class_data.txt"), sep=";", stringsAsFactors=F)
source("/Volumes/data/Courses/USF_stats_programming/statprog/week_05_loading_data/quiz_parser.R")

raw_url <- github_raw_url(class_data$github_questions[1])
parse_quiz_text(getURL(raw_url))

class_data$num_questions <- 
    sapply(class_data$github_questions, function(gh_url){
        gh_url %>% github_raw_url %>% getURL %>% parse_quiz_text %>% length()
    })

class_data[c("name","num_questions")]
