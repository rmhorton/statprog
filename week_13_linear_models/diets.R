load("../week_06_SQL_from_R/food_nutrient_mat.Rdata")

scaled_food_nutrients_mat <- scale(food_nutrient_mat)
dm <- dist(scaled_food_nutrients_mat)
hc <- hclust(dm)
pdf("food_clusters.pdf")
plot(hc, cex=0.25)
dev.off()

km <- kmeans(scaled_food_nutrients_mat, 5)$cluster

# This food-nutrient matrix was simplified by a simple but brutal filtering approach (see FNDDS.R from week 6). It might be interesting to experiment with other approaches to reduce the number of foods to a representative subset (e.g., medoid clustering with the "pam" package; a medoid is a representative object of a cluster.)


library("RSQLite")
con <- dbConnect(SQLite(), "fndds.sqlite")
dbListTables(con)
