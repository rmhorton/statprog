# We need to use RCurl to load code from an https site (otherwise we could have used "source")
library(RCurl)
quiz_parser_url <- "https://raw.githubusercontent.com/rmhorton/statprog/master/week_05_loading_data/quiz_parser.R"
eval(parse(text=getURL(quiz_parser_url)))

# Parse one set of questions:
q1 <- "https://github.com/catterbu/hs616/blob/master/final_exam_questions.Rmd"
library(dplyr)
qlist_github <- q1 %>% github_raw_url %>% getURL %>% parse_quiz_text

# How many components are there for each question?
sapply(qlist_github, sapply, length)