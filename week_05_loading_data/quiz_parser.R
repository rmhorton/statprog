# Code to parse markdown question files

library(RCurl)
library(magrittr)

quizFile <- "questions.md"

NL <- "\n"

qlist_local <- quizFile %>% readLines() %>% paste(collapse=NL) %>% 
	strsplit("## *") %>% .[[1]] %>% .[-1] %>% 
	strsplit(paste0(NL,NL)) %>%
	lapply(function(q){
		lecture <- sub("^Lecture *(\\d[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
		question <- q[2]
		answers <- strsplit(q[3],NL)[[1]] %>% sub("^[*] *", "", .)
		list(lecture=lecture, question=question, answers=answers)
	})

quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/questions.md"
qlist_github <- quizUrl %>% getURL() %>%
	strsplit("## *") %>% .[[1]] %>% .[-1] %>% 
	strsplit(paste0(NL,NL)) %>%
	lapply(function(q){
		lecture <- sub("^Lecture *(\\d[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
		question <- q[2]
		answers <- strsplit(q[3],NL)[[1]] %>% sub("^[*] *", "", .)
		list(lecture=lecture, question=question, answers=answers)
	})
