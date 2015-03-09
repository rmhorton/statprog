#' Parse markdown-formatted quiz question files into in-memory data structure.
#' @param quiz_text a block of text to be parsed (not a connection or file, but it can be the output of getUrl).
#' @NL (default "\n") character or string marking the end of each line of input text.
#' @example # Read from raw github content
#' 	library(RCurl)
#' 	quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/questions.md"
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
parse_quiz_text <- function(quiz_text, NL="\n"){
	library(magrittr)
	
	quiz_text %>%
	strsplit("## *") %>% .[[1]] %>% .[-1] %>% 
	strsplit(paste0(NL,NL)) %>%
	lapply(function(q){
		lecture <- sub("^Lecture *(\\d[ab]).*", "\\1", q[1], ignore.case=T, perl=T)
		question <- q[2]
		answers <- strsplit(q[3],NL)[[1]] %>% sub("^[*] *", "", .)
		list(lecture=lecture, question=question, answers=answers)
	})
}

<<<<<<< HEAD
# transform the input URL into a raw file URL
# @param blob_url the github URL for the normal web interface to the file (must include "/blob/" after repo name)
# https://github.com/sneha-krishna/hs616/blob/working-doc/lecturequestions.txt
# https://raw.githubusercontent.com/sneha-krishna/hs616/working-doc/lecturequestions.txt
github_raw_url <- function(blob_url){
    blob_url <- gsub("^https://github.com/", "", blob_url)
    user_doc <- strsplit(blob_url, "/blob/")[[1]] 
    sprintf("https://raw.githubusercontent.com/%s/%s", user_doc[1], user_doc[2])
}
=======

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
>>>>>>> 446abbd947df84ee0a7013d1e0ca03f42fab76e8
