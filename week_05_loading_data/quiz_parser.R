# Code to parse markdown question files

library(RCurl)
library(magrittr)

parse_quiz_text <- function(quiz_text, NL="\n") quiz_text %>%
	strsplit("## *") %>% .[[1]] %>% .[-1] %>% 
	strsplit(paste0(NL,NL)) %>%
	lapply(function(q){
		lecture <- sub("^Lecture *(\\d[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
		question <- q[2]
		answers <- strsplit(q[3],NL)[[1]] %>% sub("^[*] *", "", .)
		list(lecture=lecture, question=question, answers=answers)
	})


# quizFile <- "../../hs616/questions.md"
# qlist_local <- quizFile %>% 
# 				readLines() %>% 
# 				paste(collapse="\n") %>% 
# 				parse_quiz_text()
# 
# 
# quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/questions.md"
# qlist_github <- quizUrl %>% getURL() %>% parse_quiz_text()

# parse_quiz_text(getURL(quizUrl))