data_dir <- "FNDDS_2011"

fortification <- c(`0`="none", `1`="fortified_product", `2`="contains fortified ingredients")

fndds_tables <- list(
	AddFoodDesc = list(
			title="Additional Food Descriptions",
			column_types=c(
				food_code="integer", # foreign key
				seq_num="integer", 
				start_date="date", 
				end_date="date", 
				additional_food_description="text"),
			sep="^"
		),
	FNDDSNutVal = list(
			title="FNDDS Nutrient Values",
			column_types=c(
				food_code="integer",
				nutrient_code="integer",	# Nutrient Descriptions table
				start_date="date", 
				end_date="date", 
				nutrient_value="double"
				),
			sep="^"
		),
	FNDDSSRLinks = list(
			title="FNDDS-SR Links",	# see p34 of fndds_2011_2012_doc.pdf
			column_types=c(
				food_code="integer",
				start_date="date", 
				end_date="date", 
				seq_num="integer",
				sr_code="integer",
				sr_descripton="text",
				amount="double",
				measure="char[3]",	# lb, oz, g, mg, cup, Tsp, qt, fluid ounce, etc
				portion_code="integer",
				retention_code="integer",
				flag="integer",
				weight="double",
				change_type_to_sr_code="char[1]",	# D=data change; F=food change
				change_type_to_weight="char[1]",
				change_type_to_retn_code="char[1]"
				),
			sep="^"
		),
	FoodPortionDesc = list(
			title="Food Portion Descriptions",
			column_types=c(
				portion_code="integer", 	# foreign key
				start_date="date",
				end_date="date",
				portion_description="text",
				change_type="char[1]"
			),
			sep="^"
		),
	FoodSubcodeLinks = list(
			title="Food code-subcode links",
			column_types=c(
				food_code="integer",
				subcode="integer",
				start_date="date",
				end_date="date"
				),
			sep="^"
		),
	FoodWeights = list(
			title="Food Weights",
			column_types=c(
				food_code="integer",	# foreign key
				subcode="integer",
				seq_num="integer",
				portion_code="integer",	# food portion description id
				start_date="date",
				end_date="date",
				portion_weight="double",	# missing values = -9
				change_type="char[1]"	# D=data change, F=food change
				),
			sep="^"
		),
	MainFoodDesc = list(
			title="Main Food Descriptions",
			column_types=c(
				food_code="integer", 
				start_date="date", 
				end_date="date", 
				main_food_description="character", 
				fortification_id="integer"),
			sep="^"
		),
	ModDesc = list(
			title="Modifications Descriptons",
			column_types=c(
				modification_code="integer",
				start_date="date", 
				end_date="date", 
				modification_description="text",
				food_code="integer"
				
				),
			sep="^"
		),
	ModNutVal = list(
			title="Modifications Nutrient Values",
			column_types=c(
				modification_code="integer",
				nutrient_code="integer",
				start_date="date", 
				end_date="date", 
				nutrient_value="double"
				),
			sep="^"
		),
	MoistNFatAdjust = list(
			title="Moisture & Fat Adjustments",	# to account for changes during cooking
			column_types=c(
				food_code="integer",
				start_date="date", 
				end_date="date", 
				moisture_change="double",
				fat_change="double",
				type_of_fat="integer"	# SR code or food code				
				),
			sep="^"
		),
	NutDesc = list(
			title="Nutrient Descriptions",
			column_types=c(
				nutrient_code="integer",
				nutrient_description="text",
				tagname="text",
				unit="text",
				decimals="integer"	# decimal places
				),
			sep="^"
		),
	SubcodeDesc = list(
			title="Subcode Descriptions",
			column_types=c(
				subcode="integer",	# key; 0=use “default gram weights”
				start_date="date",
				end_date="date",
				subcode_description="text"
				),
			sep="^"
		)
)

assign_data_frame <- function(tbl_name){
	tbl <- read.table(
		file.path(data_dir, paste0(tbl_name, ".txt")), 
		sep="^",
		quote="~",
		stringsAsFactors=FALSE)
	# drop last (empty) column
	tbl <- tbl[1:(length(tbl)-1)]
	names(tbl) <- names(fndds_tables[[tbl_name]][["column_types"]])
	assign(tbl_name, tbl, envir = .GlobalEnv)
}

fndds2sqlite <- function(data_dir, table_details, sqlite_filename){

	library("RSQLite")
	con <- dbConnect(SQLite(), sqlite_filename)

	for (tbl_name in names(table_details)){
		file_name <- paste0(tbl_name, ".txt")
		assign_data_frame(tbl_name)
		tbl <- get(tbl_name)
		dbWriteTable(con, tbl_name, tbl, row.names = FALSE)
	}
	
	dbDisconnect(con)
}

# fndds2sqlite("FNDDS_2011", fndds_tables, "fndds.sqlite")

for (tbl in c("FNDDSNutVal", "MainFoodDesc", "NutDesc"))
	assign_data_frame(tbl)

library(dplyr)
library(tidyr)

foods <- MainFoodDesc %>% 
	filter( grepl(", NFS", main_food_description ) | grepl("^93", food_code)) %>%
	filter(!grepl("infant formula", main_food_description ) ) %>%
	select( food_code, main_food_description, fortification_id ) %>%
	mutate( main_food_description = gsub(", NFS", "", main_food_description) )


library(sqldf)
long_food_nutrients <- sqldf("SELECT f.main_food_description, nd.nutrient_description, nv.nutrient_value \
	FROM foods f \
	INNER JOIN FNDDSNutVal nv ON f.food_code = nv.food_code \
	INNER JOIN NutDesc nd ON nv.nutrient_code = nd.nutrient_code")


nutrient_food_df <- spread(long_food_nutrients, main_food_description, nutrient_value, fill=0)

food_nutrient_mat <- t(as.matrix(nutrient_food_df[-1]))
colnames(food_nutrient_mat) <- nutrient_food_df$nutrient_description
save(food_nutrient_mat, file="food_nutrient_mat.Rdata")
