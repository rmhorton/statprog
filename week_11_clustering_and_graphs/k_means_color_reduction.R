# http://openclassroom.stanford.edu/MainFolder/DocumentPage.php?course=MachineLearning&doc=exercises/ex9/ex9.html

library(RCurl)
library(jpeg)

parrot <- readJPEG( getBinaryURL("https://simerg.files.wordpress.com/2009/05/a-parrots-freedom.jpg") )

image(parrot[,,1])

# random initialization
k <- 16
row <- sample(1:dim(parrot)[1], k)
col <- sample(1:dim(parrot)[2], k)
# centroids <- parrot[row, col, 1:3]
centroids <- sapply(1:k, function(i) parrot[row[i], col[i],])


find_nearest <- function(point, centroids){
  
}

update_centroids <- function(centroid_groups){
  
}
MAX_ITERATIONS <- 30

for (i=1:MAX_ITERATIONS){
  for (row in 1:dim(parrot)[1]){
    for (col in  1:dim(parrot)[2]){
      for (i in 1:k){
        
      }
    }
  }
}

writePNG(parrot_265, "parrot_256.png")