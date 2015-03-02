# Factors as keys
# When a factor is used as a lookup key, it is converted to integer.scores <- c(C=75, B=85, A=95)
scores <- c(C=75, B=85, A=95)	# position 1 is 'C'
grades <- sample(LETTERS[1:3], 12, replace=T)
grades_factor <- factor(grades)
scores[grades]
scores[grades_factor]  # 'A' is 3
scores[as.character(grades_factor)]  # this is what we want
