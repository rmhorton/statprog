DATA_DIR <- "~/GitHub"
library("RCurl")
library("magrittr")

quiz_parser_url <- "https://raw.githubusercontent.com/rmhorton/statprog/master/week_05_loading_data/quiz_parser.R"
source(textConnection(getURL(quiz_parser_url)))

# get class_data.txt from Canvas
class_data <- read.delim(file.path(DATA_DIR, "class_data.txt"), sep=";", stringsAsFactors=F)

raw_url <- github_raw_url(class_data$github_questions[1])  # 1 is Bob; try your own row number
parse_quiz_text(getURL(raw_url))

class_data$num_questions <- 
    sapply(class_data$github_questions, function(gh_url){
        gh_url %>% github_raw_url %>% getURL %>% parse_quiz_text %>% length()
    })

class_data[c("name","num_questions")]
