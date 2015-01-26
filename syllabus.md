---
title: "HS616 Syllabus"
author: "Robert Horton"
date: "January 25, 2015"
output: pdf_document
---

# Statistical Computing for Biomedical Data Analytics

## Description
This is an intensive introduction to statistical computing with R. Programming assignments will draw from a wide range of computational and applied mathematical concepts required for biomedical data analytics, including probability, statistics, linear algebra, optimization, data manipulation, visualization, linear modeling and model diagnostics.

## Overview
This course is designed to develop core computing skills, to complement traditional coursework in mathematical statistics, and to lay the groundwork for further study of data analytics. Students will learn to use the R statistical programming language and environment by solving structured problems in a wide range of application areas relevant to biomedical data analysis.

The programming exercises will emphasize interaction between R and other computational resources, particularly SQL databases, networked resources, the Linux environment, and Python. Special emphasis will be placed on approaches that scale to large data sets.


## Objectives
On completing this course, students will be able to:

* take advantage of the large number of software modules available from the R language
* clean, merge, filter, and arrange data into formats suitable for regression or machine learning analysis
* create sophisticated graphs of functions or data
* use linear algebra approaches to find optimal solutions for systems of equations
* be able to run advanced SQL queries (including GIS extensions, stored procedures, and in-database analytics) from the R environment
* develop and deploy interactive visualizations and simple data products
* use scripting and literate analysis tools to create fully documented and reproducible data analysis workflows

## Recommended texts
* [R in Action (2nd edition)](http://www.manning.com/kabacoff2/?a_aid=RiA2ed&a_bid=5c2b1e1d): *This is the primary text* for the course. It presents a broad and readable introduction to using the R environment for data analysis, but it does not focus on programming. Note that the second edition is officially coming out this spring, but you can purchase an "early access" subscription that lets you read the latest revisions as they are ready. You can often find discount codes for books from this publisher (look on the [Quick R](http://www.statmethods.net) site, for example)
* [Introductory Statistics with R](http://www.academia.dk/BiologiskAntropologi/Epidemiologi/PDF/Introductory_Statistics_with_R__2nd_ed.pdf): I'm looking at this as an alternative; the first chapter is recommended by Hadley Wickham before you dive into ggplot.
* [An Introduction to R](http://cran.r-project.org/doc/manuals/R-intro.pdf): The "sample session" in Appendix A is a useful tutorial; otherwise, this book is pretty technical, and mostly good for reference.
* [Advanced R](http://www.amazon.com/dp/1466586966/ref=cm_sw_su_dp?tag=devtools-20): also available [online](http://adv-r.had.co.nz/). This is a new text written by Hadley Wickham, the author of many of the packages we will focus on (ggplot2, tidyr, dplyr, etc). It is not an introductory book, but we will use selected sections.

## Websites
* Interactive Tutorials
    * [swirl](http://swirlstats.com/students.html): This is an R package that walks you through various tutorials that you run within R.
* Questions
    * [RSeek](http://rseek.org/): interface to the Google search engine that focuses on R; this can be useful since the letter "R" is used for other things.
    * [StackOverflow](http://stackoverflow.com/questions/tagged/r)
* Reference
    * [Reference Card](http://cran.r-project.org/doc/contrib/Short-refcard.pdf)
    * [Quick R](http://www.statmethods.net/)
    * [Cookbook for R](http://www.cookbook-r.com/)
    * [About R](http://stackoverflow.com/tags/r/info) on StackOverflow
* Code
    * [CRAN](http://cran.r-project.org/) The Comprehensive R Archive Network is the main repository for R packages.
    * [Bioconductor](http://www.bioconductor.org/) is a separate repository for bioinformatics packages
    * [GitHub](https://github.com), especially the [course repository](https://github.com/rmhorton/statprog) and [Hadley Wickham's site](https://github.com/hadley)
    
## Syllabus

R is both a programming language and an environment for statistical analysis. It has well-developed facilities for software development, data manipulation, data visualization, and (of course) statistics; the power of the system is the ability to bring all of these capabilites together. Unfortunately, students can face a daunting challenge if they need to learn all of these aspects before they can reap the benefits of R. The answer, of course, is to break the learning task into small iterations; learn something about programming, something about data management, some graphical technique, and some statistcal approach, then use them to address a problem. Repeat until you have learned all the aspects  (this may take a while). The textbook is structured around several such iterations. This course, on the other hand, is laid out in one big iteration, with four sections emphasizing programming, data manipulation, graphics, and analysis. The division is not crisp, however, since most interesting results require a combination of these things. We will cover a variety of interesting and important ideas, applications and examples in class, but you will need to take the initiative to develop basic R skills on your own. 

### Section 1: R Programming

* Week 1: Teach yourself R: ___We cannot cover everything you need to know in class___
	* Lecture 1a: R Learning Resources
		- R == programming + data + graphics + statistics
			+ synergy: the different fields complement each other
			+ iterate: you can't learn it all at once
		- Resources
			+ Textbook: _R in Action_
			+ tutorials (swirl)
			+ help system and reference sites
			+ code repositories and installing packages
			+ Coursera
	* Lecture 1b: Literate Calculation
		- Literate calculation
			+ Introduction to RStudio and "Literate Analysis"
			+ R as a calculator
			+ typesetting mathematical equations in LaTeX
			+ Exercise: Documenting calculations in RStudio
		- Course projects and deliverables
        - Set up github accounts
* Week 2: Statistics
	* Lecture 2a: Probability
		- Pseudorandom numbers
			+ deterministic "randomness"
			+ the _Randumb_ package: installing from a zip file
		- Rolling dice
			+ simulating the Binomial distribution
		- Curve fitting
			+ using lm and formulas to fit a polynomial to a set of points
			+ parameter scanning to fit bell curve to Binomial simulation results
		- Sensitivity and specificity exercise
			+ structuring code with functions
			+ organizing data into dataframes
	* Lecture 2b: Hypothesis testing
		- Numerical integration
			+ area under (part of) a bell curve
		- Distributions under null and alternative hypotheses; alpha, beta
			+ Interactive graphs using "manipulate"
		- Multiple testing adjustments
			+ Bonferroni, Benjamini-Hochberg
		- Bootstrapping
			+ estimating probability distributions by sampling
			+ parallelization
			+ profiling with lineprof: installing from github
* Week 3: Linear algebra
	* Lecture 3a: Vectors and Matrices
		- Matrix manipulation
			+ dot product ("weighted combination") of two vectors
			+ multiplying a matrix by a vector
	* Lecture 3b: Inverses, Eigenvectors
			+ solving systems of equations
			+ Gauss-Jordan elimination
* Week 4: Code Optimizations
	* Lecture 4a: Idiomatic Optimization
	* Lecture 4b: Profiling and debugging
        - Idioms matter
			+ How to baffle R: the "loop that allocates memory" ploy
			+ Hello functional programming
			+ Simple performance metrics: plotting timing results
			+ vectorization


### Section 2: Loading and Munging Data

* Week 5: Loading data
	* Lecture 5a: Loading and cleaning data
		- Spreadsheets and data frames
		- data cleaning
			+ Regular expressions
			+ Un*x pipes
		- merging and aggregation
		- key-value lookups
			+ linear scanning, binary search, hash tables
	* Lecture 5b: Web scraping
* Week 6: Using SQL from R
	* Lecture 6a: SQL in R
		- sqldf: bidirectional promoters in a mammalian genome
			+ self-join on a table of transcription start sites.
	* Lecture 6b: Interfacing to databases
		- Direct database access
		- Sophisticated SQL with Postgres
* Week 7: Tidy Data:
	* Lecture 7a: Tidy Data
		- rows are examples (with outcome), columns are attributes
		- Classification example
	* Lecture 7b: aggregating and reshaping
		- dplyr & tidyr
			+ swirl exercise
* Week 8: Dimension reduction
	* Lecture 8a: PCA
		- Singular Value Decomposition
	* Lecture 8b: Midterm
		- **Midterm Exam**

### Section 3: Visualization and User Interaction

* Week 9: Advanced Graphics
	* Lecture 9a: BARUG Field Trip
		- Reading: graphics menagerie
			+ continuous / categorical
			+ univariate / multivariate
	* Lecture 9b: The Grammar of Graphics
		- RiA Ch 19
* Week 10: Interactive Applications
	* Lecture 10a: Manipluate and Shiny packages
		- Interactive ODE model
		- Interactive analysis
	* Lecture 10b: Shiny Demo (Nikil)
* Week 11: Clustering and Graphs
	* Lecture 11a: Clustering
		- Heat maps
	* Lecture 11b: Graphs
		- Graphing graphs
* Week 12: Visualizing Regression
	* Lecture 12a: Regression as Optimization
		- fitting the "best" line
		- interactive visualization of data, line, and cost function in parameter space.
		- gradient descent
	* Lecture 12b: Guest Lecture

### Section 4: Analytics

* Week 13: Linear models
	* Lecture 13a: Linear regression
		- Feature selection
			+ Transformation
			+ Dimension reduction
		- Interactions
			+ Simpson's paradox
			+ Categorical inputs
	* Lecture 13b: Logistic regression
		- Generalized linear models
		- Regularization
* Week 14: Diagnostics
	* Lecture 14a: Residuals, ROC curves
		- Model diagnostics
			+ ROC curves: sensitivity/specificity tradeoff
	* Lecture 14b: Learning curves
		- Overfitting
			+ Validation
			+ Learning curves: bias/variance tradeoff
* Week 15: Big Data
	* Lecture 15a: R and Hadoop
	* Lecture 15b: Revolution R Enterprise
* Week 16: Finals
    - **Final Exam**
	- Hypersonic Survey of Machine Learning algorithms
	