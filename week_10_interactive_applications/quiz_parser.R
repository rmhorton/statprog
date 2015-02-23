# TODO: Parse HTML? Or use knitr to turn markdown into HTML?

setwd("/Users/bhorton/GitHub/hs616")
quizFile <- "quiz_questions.md"

NL <- '<br/>'

qtext <- paste(readLines(quizFile), collapse=NL)

qlist <- strsplit(qtext, "## ?")[[1]][-1]

qlist <- strsplit(qlist, paste0(NL,NL))

lapply(qlist, function(q){
	list(lecture=q[1], question=q[2], answers=strsplit(q[3],NL)[[1]])
})


library(RCurl)
library(magrittr)

quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/quiz_questions.md"
qlist <- getURL(quizUrl) %>%
	paste(collapse=NL) %>%
	(function(txt) strsplit(txt, "## *")[[1]][-1]) %>% 
	strsplit(paste0(NL,NL)) %>%
	lapply(function(q){
		lecture <- sub("^Lecture *(\\d[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
		question <- q[2]
		answers <- strsplit(q[3],NL)[[1]] %>% sub("^[*] *", "", .)
		list(lecture=lecture, question=question, answers=answers)
	})


QUIZ_BANK <- list()
for (qq in qlist){
	QUIZ_BANK[qq$lecture] <- append(QUIZ_BANK[qq$lecture], qq)
}