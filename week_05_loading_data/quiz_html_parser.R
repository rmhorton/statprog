# This is a work in progress;it doesn't really work yet.
# file:///Users/bhorton/GitHub/hs616/questions.html

library(magrittr)
library(rvest)
qpage <- html("file:///Users/bhorton/GitHub/hs616/questions.html")


parsed_html_quiz <- qpage %>% html_nodes(".level2") %>% lapply(function(qa){
	lecture <- qa %>% html_nodes("h2") %>% html_text() %>% gsub("^Lecture +","",.)
	question <- qa %>% html_nodes("p,pre")
	answers <- qa %>% html_nodes("ul") %>% html_nodes("li")
	list(lecture=lecture, 
		question=question, 
		answers=answers)
})

# Scraps:
# qpage %>% html_nodes("ul") %>% html_nodes("li") %>% html_text()
# qpage %>% html_nodes(".level2") %>% html_nodes("h2") %>% html_text()
# qpage %>% html_nodes(":not(h2)") %>% html_nodes(":not(ul)") %>% html_nodes(":not(li)") %>% html_text()