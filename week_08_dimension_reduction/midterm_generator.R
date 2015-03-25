library(dplyr)

process_question <- function(qtxt){
	q_a <- strsplit(qtxt, "\n\n+")[[1]]
	question <- q_a[1]
	answers <- q_a[2] %>% gsub("\n$", "", .) %>% # gsub(" *(\n|$)", "\\1", .)  %>%
			strsplit("(^|\n)[*] +") %>% .[[1]] %>% .[-1]
	num_answers <- length(answers)
	answer_numbers <- 1:num_answers
	new_order <- sample(answer_numbers)
	answer_str <- paste("* ", LETTERS[1:num_answers], ": ", answers[new_order], collapse="\n")
	correct <- LETTERS[which(new_order == 1)]
	c(question = question, answer_str = answer_str, correct = correct)
}

write_quiz_to_file <- function(qlist, title, date, file_name, show_correct=FALSE){
	title <- sprintf(gsub("\\t", "", '---
		title: "%s"
		author: "HS616"
		date: "%s"
		output: pdf_document
		---
		'), title, date)
	
	q_to_Rmd <- function(q){
		if (!show_correct) q <- q[c('question', 'answer_str')]
		paste(q, collapse="\n\n")
	}
	qfile <- file(file_name, open="wt")
	cat(title, file=qfile)
	for (qnum in seq_along(qlist)){
		cat(paste("\n## Question", qnum,"\n"), file=qfile)
		cat(q_to_Rmd(qlist[[qnum]]), file=qfile)
		cat("\n", file=qfile)
	}
	close(qfile)
}

get_answer_key <- function(qlist)
	sapply(seq_along(qlist), function(i){
		paste(i, qlist[[i]]['correct'], sep=":")
	})

generate_quiz <- function(quiz_file, num_questions, seed){
	set.seed(seed)
	quiz_file %>% readLines %>% paste(collapse="\n") %>%
		strsplit("\n+## Lecture ([^\n]+)") %>% .[[1]] %>% .[-1] %>% 
		strsplit("\n___([^_\n]+)___") %>% lapply(function(v) v[-1]) %>% unlist %>%
		lapply(process_question) %>% sample(num_questions)
}

# Practice Exam
midterm <- generate_quiz("HS616_midterm_study_guide.Rmd", num_questions=35, seed=123)
write_quiz_to_file(midterm, "Practice Midterm", "March 24, 2015", file="practice_midterm.Rmd")
write(get_answer_key(midterm), file="practice_midterm_answer_key.txt")

# Actual Midterm
midterm <- generate_quiz("HS616_midterm_study_guide.Rmd", num_questions=35, seed=XXX)
write_quiz_to_file(midterm, "Midterm Exam", "March 26, 2015", file="../../midterm.Rmd")
write(get_answer_key(midterm), file="../../midterm_answer_key.txt")
