# TO DO: be sure that student idneifier strings are on their own line (e.g., ___rmhorton___)

DATA_DIR <- "~/GitHub"
library("RCurl")
library("magrittr")

quiz_parser_url <- "https://raw.githubusercontent.com/rmhorton/statprog/master/week_05_loading_data/quiz_parser.R"
# source(textConnection(getURL(quiz_parser_url)))
source("../week_05_loading_data/quiz_parser.R")

# get class_data.txt from Canvas
class_data <- read.delim(file.path(DATA_DIR, "class_data.txt"), sep=";", stringsAsFactors=F)

raw_url <- github_raw_url(class_data$github_questions[1])  # 1 is Bob; try your own row number
parse_quiz_text(getURL(raw_url))

class_data$num_questions <- 
    sapply(class_data$github_questions, function(gh_url){
        gh_url %>% github_raw_url %>% getURL %>% parse_quiz_text %>% length()
    })

class_data[c("name","num_questions")]

# This is the part I ran at midnight Sunday March 15th, 2015.
git_user <- function(github_url){
	github_url <- gsub("^https://github.com/", "", github_url)
	github_url <- gsub("https://raw.githubusercontent.com/", "", github_url)
	strsplit(github_url, "/") %>% do.call(rbind, .) %>% .[,1]
}

github_urls <- class_data$github_questions
names(github_urls) <- git_user(class_data$github_questions)

midterm_question_bank <- github_urls %>% lapply(function(gh_url){
        gh_url %>% github_raw_url %>% getURL %>% parse_quiz_text
    })

save(midterm_question_bank, file="../week_08_dimension_reduction/midterm_question_bank2.Rdata")

unparse_question <- function(q) paste(q[[2]], paste0("* ", q[[3]], collapse="\n"), sep="\n\n")

standardize_lecture_id <- function(lecID){
	lec_vec <- lecID %>% gsub("lecture *", "", ., ignore.case=TRUE) %>%
				tolower %>% gsub("(\\d+)([ab])", "\\1:\\2", .) %>% strsplit(":") %>% .[[1]]
	sprintf("%02d%s", as.integer(lec_vec[1]), lec_vec[2])
}

questions_by_lecture <- list()
for (student in names(midterm_question_bank)){
	student_questions <- midterm_question_bank[[student]]
	for (q in student_questions){
		lecture <- standardize_lecture_id(q[[1]])
		questions_by_lecture[[lecture]] <- append(questions_by_lecture[[lecture]], 
			paste0("___", student, "___ ", unparse_question(q)))
	}
}

study_guide_FH <- file("HS616_midterm_study_guide.Rmd", open="wt")

'---
title: \"Midterm Study Guide\"
author: \"The HS616 Class of 2015\"
date: \"March 15, 2015\"
output: html_document
---' %>% writeLines(study_guide_FH)


for (lecture_id in names(questions_by_lecture)){
	sprintf("## Lecture %s\n", lecture_id) %>% writeLines(study_guide_FH)
	questions_by_lecture[[lecture_id]] %>% paste0("\n\n") %>% writeLines(study_guide_FH)
	"\n\n" %>% writeLines(study_guide_FH)
}
close(study_guide_FH)

###
source("../week_05_loading_data/quiz_parser.R")

quiz_FH <- file("midterm_question_textdump2.txt", open="wt")

for (gh_url in github_urls){
	gh_url %>% github_raw_url %>% getURL %>% 
		fix_miscellaneous_formatting_errors %>% write(quiz_FH)
}
close(quizFile)
