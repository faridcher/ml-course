## Machine Learning Online Class
#  Exercise 7 | Principle Component Analysis and K-Means Clustering
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     pca.R
#     projectData.R
#     recoverData.R
#     computeCentroids.R
#     findClosestCentroids.R
#     kMeansInitCentroids.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("computeCentroids.R",
             "findClosestCentroids.R","kMeansInitCentroids.R",
             "plotDataPoints.R","plotProgresskMeans.R","runkMeans.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## ------------------- Part 1: Find Closest Centroids ----------------------
#  To help you implement K-Means, we have divided the learning algorithm
#  into two functions -- findClosestCentroids and computeCentroids. In this
#  part, you should complete the code in the findClosestCentroids function.
#
cat(sprintf('Finding closest centroids.\n\n'))

# Load an example dataset that we will be using
load('ex7data2.Rda')
list2env(data,.GlobalEnv)
rm(data)

# Select an initial set of centroids
K <- 3; # 3 Centroids
initial_centroids <- matrix(c(3, 3, 6, 2, 8, 5),3,2,byrow = TRUE)

# Find the closest centroids for the examples using the
# initial_centroids
idx <- findClosestCentroids(X, initial_centroids)

cat(sprintf('Closest centroids for the first 3 examples: \n'))
cat(sprintf(' %d', idx[1:3]))
cat(sprintf('\n(the closest centroids should be 1, 3, 2 respectively)\n'))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------------- Part 2: Compute Means --------------------------
#  After implementing the closest centroids function, you should now
#  complete the computeCentroids function.
#
cat(sprintf('\nComputing centroids means.\n\n'))

#  Compute means based on the closest centroids found in the previous part.
centroids <- computeCentroids(X, idx, K)

cat(sprintf('Centroids computed after initial finding of closest centroids: \n'))
cat(sprintf(' %f %f \n' , centroids[,1],centroids[,2]))
cat(sprintf('\n(the centroids should be\n'))
cat(sprintf('   [ 2.428301 3.157924 ]\n'))
cat(sprintf('   [ 5.813503 2.633656 ]\n'))
cat(sprintf('   [ 7.119387 3.616684 ]\n\n'))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------------------- Part 3: K-Means Clustering -----------------------
#  After you have completed the two functions computeCentroids and
#  findClosestCentroids, you have all the necessary pieces to run the
#  kMeans algorithm. In this part, you will run the K-Means algorithm on
#  the example dataset we have provided.
#
cat(sprintf('\nRunning K-Means clustering on example dataset.\n\n'))

# Load an example dataset
load("ex7data2.Rda")
list2env(data,.GlobalEnv)
rm(data)

# Settings for running K-Means
K <- 3
max_iters <- 10

# For consistency, here we set centroids to specific values
# but in practice you want to generate them automatically, such as by
# settings them to be random examples (as can be seen in
# kMeansInitCentroids).
initial_centroids <- matrix(c(3, 3, 6, 2, 8, 5),3,2,byrow = TRUE)

# Run K-Means algorithm. The 'true' at the end tells our function to plot
# the progress of K-Means
kMean <- runkMeans(X, initial_centroids, max_iters, TRUE)
centroids <- kMean$centriods
idx <- kMean$idx

cat(sprintf('\nK-Means Done.\n\n'))
cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## -------------- Part 4: K-Means Clustering on Pixels ---------------
#  In this exercise, you will use K-Means to compress an image. To do this,
#  you will first run K-Means on the colors of the pixels in the image and
#  then you will map each pixel on to it's closest centroid.
#
#  You should now complete the code in kMeansInitCentroids.R
#

cat(sprintf('\nRunning K-Means clustering on pixels from an image.\n\n'))

#  Load an image of a bird
# library(png)
# A <- readPNG('bird_small.png')
#Instead load from Rda
load('bird_small.Rda')
list2env(data,.GlobalEnv)
rm(data)

A <- A / 255 # Divide by 255 so that all values are in the range 0 - 1

# Size of the image
img_size <- dim(A)

# Reshape the image into an Nx3 matrix where N <- number of pixels.
# Each row will contain the Red, Green and Blue pixel values
# This gives us our dataset matrix X that we will use K-Means on.
X <- matrix(A, img_size[1] * img_size[2], 3)

# Run your K-Means algorithm on this data
# You should try different values of K and max_iters here
K <- 16
max_iters <- 10

# When using K-Means, it is important the initialize the centroids
# randomly.
# You should complete the code in kMeansInitCentroids.R before proceeding
initial_centroids <- kMeansInitCentroids(X, K)

# Run K-Means
kMean <- runkMeans(X, initial_centroids, max_iters)
centroids <- kMean$centroids
idx <- kMean$idx

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------------- Part 5: Image Compression -----------------------
#  In this part of the exercise, you will use the clusters of K-Means to
#  compress an image. To do this, we first find the closest clusters for
#  each example. After that, we

cat(sprintf('\nApplying K-Means to compress an image.\n\n'))

# Find closest cluster members
idx <- findClosestCentroids(X, centroids)

# Essentially, now we have represented the image X as in terms of the
# indices in idx.

# We can now recover the image from the indices (idx) by mapping each pixel
# (specified by it's index in idx) to the centroid value
X_recovered <- centroids[idx,]

# Reshape the recovered image into proper dimensions
X_recovered <- array(X_recovered, img_size)

# Display the original image
op <- par(mfrow=c(1,2),mar=c(5, 4, 4, 2) + .1)

library(raster)
b <- brick(A)
plotRGB(b,stretch='lin',asp=2,axes=TRUE,
        main="Original")

# Display compressed image side by side
b <- brick(X_recovered)
plotRGB(b,stretch='lin',asp=2,axes=TRUE, 
        main=sprintf('Compressed,\n with %d colors.', K))

par(op)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)
