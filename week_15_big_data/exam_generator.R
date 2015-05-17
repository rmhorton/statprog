library(dplyr)
library(RCurl)

# Study guide generating functions


#' Add leading zeros to lecture numbers
pad_zeros <- function(lecture_num){
  match_positions <- regexec("(\\d+) ?([abc])", lecture_num)
  matches <- regmatches(lecture_num, match_positions)[[1]]
  sprintf("%02d%s", as.integer(matches[2]), matches[3])
}

#' Handle certain formatting issues that became apparent after the midterm questions were submitted.
#' @param quiz_text a block of text to be prepared for parsing
fix_miscellaneous_formatting_errors <- function(quiz_text){
  quiz_text %>% gsub("\\r\\n", "\n", .) %>%	# handle Windows LF/CR??
    gsub("[”]", '\"', .) %>%
    gsub("Lecutre", "Lecture", .) %>%
    gsub("Lecture *(\\d+) ?([abc])\\n+", "Lecture \\1\\2\n\n", .) # [^\\n]*
  # gsub("Lecture *(\\d+) ?([ab]?)\\n", paste0(sprintf("Lecture %02d", as.integer("\\1")), "\\2", "\n\n"), .)
}

#' Parse markdown-formatted quiz question files into in-memory data structure.
#' @param quiz_text a block of text to be parsed (not a connection or file, but it can be the output of getUrl).
#' @NL (default "\n") character or string marking the end of each line of input text.
#' @example Read from raw github content
#'   library(RCurl)
#'   quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/questions.md"
#' 	parse_quiz_text(getURL(quizUrl))
#' 	# piped version
#'	qlist_github <- quizUrl %>% getURL() %>% parse_quiz_text()
#' 
#' 	# Read from a local file
# 'quizFile <- "../../hs616/questions.md"
#' qlist_local <- quizFile %>% 
#' 				readLines() %>% 
#' 				paste(collapse="\n") %>% 
#' 				parse_quiz_text()
parse_quiz_text <- function(quiz_text){
  library(magrittr)
  
  quiz_text %>% fix_miscellaneous_formatting_errors %>%
    strsplit("## *") %>% .[[1]] %>% .[-1] %>% 
    strsplit("\\n[\\n\\s]*\\n") %>%	# split on one or more blank lines
    lapply(function(q){
      lecture <- sub("^Lecture *(\\d+ ?[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
      lecture <- pad_zeros(lecture)
      question <- q[2]
      answers <- strsplit(q[3],paste0("\n",'[*]'))[[1]] %>% sub("^[*] *", "", .)
      list(lecture=lecture, question=question, answers=answers)
    })
}

#' transform the input URL into a raw file URL, now vectorized and pipelined!
#' @param blob_url the github URL for the normal web interface to the file (must include "/blob/" after repo name)
#' @note input: https://github.com/sneha-krishna/hs616/blob/working-doc/lecturequestions.txt
#' 		output: https://raw.githubusercontent.com/sneha-krishna/hs616/working-doc/lecturequestions.txt
github_raw_url <- function(blob_url){
  library("magrittr")
  url_parts <- blob_url %>% gsub("^https://github.com/", "", .) %>% 
    strsplit("/blob/") %>% do.call(rbind, .)
  paste("https://raw.githubusercontent.com", url_parts[,1], url_parts[,2], sep="/")
}

parse_student_questions <- function(student_repo){
  library(dplyr)
  q1 <- sprintf("https://github.com/%s", student_repo)
  q1 %>% github_raw_url %>% getURL %>% parse_quiz_text
}

rearrange_student_questions_by_lecture <- function(student_questions_list){
  lectures <- list()
  for (student in names(student_questions_list)){
    student_questions <- student_questions_list[[student]]
    for (q in student_questions){
      q$student <- student
      if (is.null(lectures[[q$lecture]])) lectures[[q$lecture]] <- list()
      if (is.null(lectures[[q$lecture]][[student]])) lectures[[q$lecture]][[student]] <- list()
      lectures[[q$lecture]][[student]] <- append(lectures[[q$lecture]][[student]], q)
                                                # q[c("question", "answers")])
    }
  }
  lectures
}

generate_study_guide <- function(student_questions_list, title, file_name){
  questions_by_lecture <- rearrange_student_questions_by_lecture(student_questions_list)
  title <- sprintf(gsub("\\t", "", '---
    title: "%s Study Guide"
    author: "Robert Horton"
    date: "%s"
    output: pdf_document
		---
    
		'), title, format(Sys.time(), "%b %d, %Y"))
  
  q_to_Rmd <- function(q){
    paste(q$question, paste("*", q$answers, collapse="\n"), sep="\n\n" )
  }
  qfile <- file(file_name, open="wt")
  cat(title, file=qfile)
  for (lecture_name in names(questions_by_lecture)){
    cat( paste("## Lecture", lecture_name, "\n\n"), file=qfile )
    qlist <- questions_by_lecture[[lecture_name]]
    for (q in qlist){
      cat(sprintf("__%s__\n", q$student), q_to_Rmd(q), "\n\n", file=qfile)
    }
  }
  close(qfile)
}

# Quiz generating functions

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
###
