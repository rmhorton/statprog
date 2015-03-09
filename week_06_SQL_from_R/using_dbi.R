# TO DO
# put questions in SQLite db
# nutrition tables

# SQLite command line shell: https://www.sqlite.org/cli.html

# sqlite3 ex1
# 
# create table tbl1(one varchar(10), two smallint);
# insert into tbl1 values('hello!',10);
# insert into tbl1 values('goodbye', 20);
# select * from tbl1;
# -- Ctrl-D to quit


library(DBI)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(con, "mtcars", mtcars, row.names = FALSE)
dbListTables(con)


# all data frames in the datasets package are bundled with RSQLite; use connection datasetsDb()


library(RSQLite)
dsets <- datasetsDb()
dbListTables(dsets)

dbGetQuery(dsets, "select * from iris limit 10")


res <- dbSendQuery(dsets, "select * from iris limit 10")
dbGetRowCount(res)
dbFetch(res, n = 02)
dbGetRowCount(res)
dbHasCompleted(res)


# res <- dbGetPreparedQuery(dsets, "SELECT * FROM USArrests WHERE Murder < ?", data.frame(x = 3))
# dbColumnInfo(res)

res <- dbSendQuery(dsets, "SELECT * FROM mtcars WHERE cyl = 4")
while(!dbHasCompleted(res)){
	chunk <- dbFetch(res, n = 10)
	print(nrow(chunk))
}

dbDisconnect(dsets)

sqliteCopyDatabase(dsets, "datasets.sqlite")

# http://en.wikipedia.org/wiki/Join_%28SQL%29
#
# sqlite3 datasets.sqlite
# .tables

CREATE TABLE department
(
 DepartmentID INT,
 DepartmentName VARCHAR(20)
);
 
CREATE TABLE employee
(
 LastName VARCHAR(20),
 DepartmentID INT
);
 
INSERT INTO department VALUES(31, 'Sales');
INSERT INTO department VALUES(33, 'Engineering');
INSERT INTO department VALUES(34, 'Clerical');
INSERT INTO department VALUES(35, 'Marketing');
 
INSERT INTO employee VALUES('Rafferty', 31);
INSERT INTO employee VALUES('Jones', 33);
INSERT INTO employee VALUES('Heisenberg', 33);
INSERT INTO employee VALUES('Robinson', 34);
INSERT INTO employee VALUES('Smith', 34);
INSERT INTO employee VALUES('Williams', NULL);


SELECT * FROM employee CROSS JOIN department;
SELECT * FROM employee, department;
SELECT * FROM employee Natural JOIN department;

SELECT *
FROM employee JOIN department
  ON employee.DepartmentID = department.DepartmentID;

SELECT *
FROM employee, department
WHERE employee.DepartmentID = department.DepartmentID;

SELECT *
FROM employee 
INNER JOIN department ON employee.DepartmentID = department.DepartmentID;

SELECT *
FROM employee 
LEFT OUTER JOIN department ON employee.DepartmentID = department.DepartmentID;


###

# http://stackoverflow.com/questions/38549/difference-between-inner-and-outer-joins
library(RSQLite)
con <- dbConnect(SQLite(), "inner_outer.sqlite")

a <- data.frame(A=1:4)
b <- data.frame(B=3:6)

dbWriteTable(con, "a", a, row.names = FALSE)
dbWriteTable(con, "b", b)
dbGetQuery(con, "select * from a INNER JOIN b on a.a = b.b;")
dbGetQuery(con, "select a.*,b.*  from a,b where a.a = b.b;")
dbGetQuery(con, "select * from a LEFT OUTER JOIN b on a.a = b.b;")
dbDisconnect(con)


###

library("RMySQL")
con <- dbConnect(MySQL(), dbname = "hg19")
dbConnect(drv, dbname = "hg19", username = "genome",
password = NULL, host = "genome-mysql.cse.ucsc.edu", unix.socket = NULL, port = 0,
client.flag = 0, groups = "rs-dbi", default.file = NULL, ...)


library("RMySQL")

con <- dbConnect(MySQL(), dbname = "hg19", username = "genome", password = NULL, 
	host = "genome-mysql.cse.ucsc.edu")
mysql --user=genome --host=genome-mysql.cse.ucsc.edu -A -e "SELECT * FROM refGene" hg19 >
hg19_refgene.txt

###

library("RMySQL")
con <- dbConnect(MySQL(), dbname = "midterm.sqlite")
source("../week_05_loading_data/quiz_parser.R")

quizUrl <- "https://raw.githubusercontent.com/rmhorton/hs616/master/questions.md"
qlist <- quizUrl %>% getURL() %>% parse_quiz_text()

for (q in qlist){
	question_entry <- data.frame(lecture=q[[1]], question=q[[2]])
	dbWriteTable(con, "question", q, append=TRUE)
	question_id <- last_insert_rowid()
	is_correct <- TRUE
	for (answer in q[[3]]){
		answer <- data.frame(question_id, answer, is_correct)
		is_correct <- FALSE
		dbWriteTable(con, "answer", answer, append=TRUE)
	}
}

