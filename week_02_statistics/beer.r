# https://www.youtube.com/watch?v=5Dnw46eC-0o

# Beer consumption increases human attractiveness to malaria mosquitoes
# http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0009546
# http://dx.plos.org/10.1371/journal.pone.0009546
# http://www.ncbi.nlm.nih.gov/pmc/articles/pmid/20209056/

# Lefèvre T, Gouagna L-C, Dabiré KR, et al. Beer Consumption Increases Human Attractiveness to Malaria Mosquitoes. Tregenza T, ed. PLoS ONE 2010;5(3):e9546. doi:10.1371/journal.pone.0009546.


beer <- c( 27, 20, 21, 26, 27, 31, 24, 21, 20, 19, 23, 24, 28, 19, 24, 29, 18, 20, 17, 31, 20, 25, 28, 21, 27 )

water <- c( 21, 22, 15, 12, 21, 16, 19, 15, 22, 24, 19, 23, 13, 22, 20, 24, 18, 20 )

library("ggplot2")

results <- data.frame(
	mosquitoes = c(beer, water),
	group = c(rep("B", length(beer)), rep("W", length(water)))
)

g <- ggplot(results, aes(x=group, y=mosquitoes, fill=group))
g + geom_boxplot() + geom_jitter(position=position_jitter(w=0.1))

g <- ggplot(results, aes(x=mosquitoes, fill=group))
g + geom_histogram(position="dodge", binwidth=1)

g <- ggplot(results, aes(x=mosquitoes, col=group))
g + geom_density()

observed <- with(results, mean(mosquitoes[group=="B"]) - mean(mosquitoes[group=="W"]))

mean_diff <- function(measurements, group_labels, base_label){
	mean(measurements[group_labels == base_label]) - mean(measurements[group_labels != base_label])
}

mean_diff(results$mosquitoes, results$group, "B")

set.seed(123)
N <- 100000
resampled <- vapply( 1:N, function(i){
	mean_diff(results$mosquitoes, sample(results$group), "B")
}, numeric(1))

hist(resampled)
abline(v=observed, col="red")

p <- sum(resampled > observed)/N	# 4e-04
t.test(beer, water, alternative="greater")$p.value	#0.0003737

