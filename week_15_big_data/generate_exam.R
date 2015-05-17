# lapply(student_repos, function(stu_repo) stu_repo %>% parse_student_questions %>% sapply(sapply,length) )
setwd("~/GitHub/statprog/week_15_big_data")

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

source("exam_generator.R")

qlist <- lapply(student_repos, function(stu_repo) stu_repo %>% parse_student_questions)
sapply(qlist, sapply, sapply, length)
save(qlist, file="student_questions.Rda")
by_lecture <- rearrange_student_questions_by_lecture(qlist)

# Study guide file
study_guide <- "HS616_final_exam_study_guide.Rmd"

generate_study_guide(qlist, "Final Exam", study_guide)

# Practice Exam
midterm <- generate_quiz(study_guide, num_questions=35, seed=123)
write_quiz_to_file(midterm, "Practice Midterm", "March 24, 2015", file="practice_final.Rmd")
write(get_answer_key(midterm), file="practice_final_answer_key.txt")

# Actual Midterm
midterm <- generate_quiz(study_guide, num_questions=35, seed=XXX)
write_quiz_to_file(midterm, "Midterm Exam", "March 26, 2015", file="../../final_exam.Rmd")
write(get_answer_key(midterm), file="../../final_exam_answer_key.txt")
