# It should be possible to load the sqlite database directly from the zip file, but this did not work on my mac.

zip2sqlite <- function(zip_file, table_details, sqlite_filename){
	library("RSQLite")
	con <- dbConnect(SQLite(), sqlite_filename)

	for (tbl_name in names(table_details)){
		file_name <- paste0(tbl_name, ".txt")
		tbl <- read.table(
			unz(zip_file, file_name),
			sep="^",
			quote="~",
			stringsAsFactors=FALSE)
		tbl <- tbl[1:(length(tbl)-1)]  # drop last (empty) column
		names(tbl) <- names(table_details[[tbl_name]][["column_types"]])
		dbWriteTable(con, tbl_name, tbl, row.names = FALSE)
	}
	
	dbDisconnect(con)
}
# zip2sqlite("FNDDS_2011.zip", fndds_tables, "fndds.sqlite")

