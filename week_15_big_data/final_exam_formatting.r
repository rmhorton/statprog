midterm <- generate_quiz("final_exam_questions.Rmd", num_questions=5, seed=123)
write_quiz_to_file(midterm, "Practice Midterm", "March 24, 2015", file="practice_midterm.Rmd")
write(get_answer_key(midterm), file="practice_midterm_answer_key.txt")




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


# parse questions from file
qfile <- "final_exam_questions.Rmd"

qlist_local <- qfile %>% readLines %>% paste(collapse="\n") %>% parse_quiz_text
sapply(qlist_local, sapply, length)


parse_student_questions <- function(student_repo){
	library(dplyr)
	q1 <- sprintf("https://github.com/%s", student_repo)
	q1 %>% github_raw_url %>% getURL %>% parse_quiz_text
}

get_question_lengths <- function(qlist){
	sapply(qlist, sapply, length)
}

"catterbu/hs616" %>% parse_student_questions %>% get_question_lengths


# class_data <- read.delim("../../class_data.txt", sep=";", stringsAsFactors=FALSE)
# student_repos <- sapply(strsplit(class_data$github_questions, "/"), function(v) paste(v[1:2], collapse="/"))
# names(student_repos) <- sapply(strsplit(student_repos, "/"), function(v) v[1])

student_repos <- c(
	catterbu = "catterbu/hs616/blob/master/final_exam_questions.Rmd",
	cpkaur = "cpkaur/hs616/blob/master/final_exam_questions.Rmd",
	vchaudhuri = "vchaudhuri/hs-616/blob/master/MCQ_Week_8-16.Rmd",
	tdenatale = "tdenatale/hs616/blob/master/final_exam_questions.Rmd",
	johnedwardgreer = "johnedwardgreer/hs616/blob/master/final_exam_questions.Rmd",
	nsh87 = "nsh87/hs616/blob/master/final_exam_questions.Rmd",
	lakarbatti = "lakarbatti/hs-616/blob/master/final_exam_questions.Rmd",
	xxu26 = "xxu26/hs616/blob/master/final_exam_questions.rmd",
	`sneha-krishna` = "sneha-krishna/hs616/blob/working-doc/final_exam_questions.Rmd"
)

lapply(student_repos, function(stu_repo) stu_repo %>% parse_student_questions %>% get_question_lengths)


write_quiz <- function(qlist, file){
	out <- file(file, open="wt")
	cat("---\noutput: pdf_document\n---\n", file=out)
	for (q in qlist){
		cat(sprintf("\n## Lecture %s\n", q$lecture), file=out)
		cat(q$question, "\n\n", file=out)
		cat(paste0("* ", q$answers, "\n"), file=out)
	}
}

write_quiz(qlist_local, "test_test3.Rmd")

