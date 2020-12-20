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
sources <- c("computeCentroids.R","featureNormalize.R","findClosestCentroids.R",
             "kMeansInitCentroids.R","plotDataPoints.R","plotProgresskMeans.R",
             "runkMeans.R","projectData.R","recoverData.R","displayData.R",
             "pca.R","bsxfun.R","computeCentroids.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## ------------------ Part 1: Load Example Dataset  --------------------
#  We start this exercise by using a small dataset that is easily to
#  visualize
#
cat(sprintf('Visualizing example dataset for PCA.\n\n'))

#  The following command loads the dataset. You should now have the
#  variable X in your environment
# library(R.matlab)
load('ex7data1.Rda')
list2env(data,.GlobalEnv)
rm(data)

#  Visualize the example dataset
plot(X[,1],X[,2],col='blue',
     xlim=c(.5,6.5),ylim=c(2,8))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## --------------- Part 2: Principal Component Analysis ---------------
#  You should now implement PCA, a dimension reduction technique. You
#  should complete the code in pca.R
#
cat(sprintf('\nRunning PCA on example dataset.\n\n'))

#  Before running PCA, it is important to first normalize X
fN <- featureNormalize(X)
X_norm <- fN$X_norm
mu <- fN$mu
sigma <- fN$sigma

#  Run PCA
USV <- pca(X_norm)
U <- USV$u
S <- diag(USV$d)

#  Compute mu, the mean of the each feature

#  Draw the eigenvectors centered at mean of data. These lines show the
#  directions of maximum variations in the dataset.
#hold on

lines(rbind(t(mu),mu+1.5*S[1,1]*t(U[,1])),lwd=2)

lines(rbind(t(mu),mu+1.5*S[2,2]*t(U[,2])), lwd=2)
#hold off

cat(sprintf('Top eigenvector: \n'))
cat(sprintf(' U[,1] = %f %f \n', U[1,1],U[2,2]))
cat(sprintf('\n(you should expect to see -0.707107 -0.707107)\n'))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------------------- Part 3: Dimension Reduction --------------------
#  You should now implement the projection step to map the data onto the
#  first k eigenvectors. The code will then plot the data in this reduced
#  dimensional space.  This will show you what the data looks like when
#  using only the corresponding eigenvectors to reconstruct it.
#
#  You should complete the code in projectData.R
#
cat(sprintf('\nDimension reduction on example dataset.\n\n'))

#  Plot the normalized dataset (returned from pca)
plot(X_norm[, 1], X_norm[, 2], col='blue',xlim=c(-4,3),ylim=c(-4,3))


#  Project the data onto K = 1 dimension
K <- 1
Z <- projectData(X_norm, U, K)
cat(sprintf('Projection of the first example: %f\n', Z[1]))
cat(sprintf('\n(this value should be about 1.481274)\n\n'))

X_rec  <- recoverData(Z, U, K)
cat(sprintf('Approximation of the first example: %f %f\n', X_rec[1,1], X_rec[1,2]))
cat(sprintf('\n(this value should be about  -1.047419 -1.047419)\n\n'))

#  Draw lines connecting the projected points to the original points
points(X_rec[,1], X_rec[,2],col='red')

for (i in 1:dim(X_norm)[1])
    lines(rbind(X_norm[i,], X_rec[i,]))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------- Part 4: Loading and Visualizing Face Data --------------
#  We start the exercise by first loading and visualizing the dataset.
#  The following code will load the dataset into your environment
#
cat(sprintf('\nLoading face dataset.\n\n'))

#  Load Face dataset
load('ex7faces.Rda')
list2env(data,.GlobalEnv)
rm(data)

#  Display the first 100 faces in the dataset
displayData(X[1:100,] )

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 5: PCA on Face Data: Eigenfaces  --------------------
#  Run PCA and visualize the eigenvectors which are in this case eigenfaces
#  We display the first 36 eigenfaces.
#
cat(sprintf('\nRunning PCA on face dataset.\n (this mght take a minute or two ...)\n\n'))

#  Before running PCA, it is important to first normalize X by subtracting
#  the mean value from each feature
fN <- featureNormalize(X)
X_norm <- fN$X_norm
mu <- fN$mu
sigma <- fN$sigma

#  Run PCA
USV <- pca(X_norm)
U <- USV$u
S <- diag(USV$d)

#  Visualize the top 36 eigenvectors found
displayData(t(U[, 1:36]))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------------- Part 6: Dimension Reduction for Faces -------------------
#  Project images to the eigen space using the top k eigenvectors
#  If you are applying a machine learning algorithm
cat(sprintf('\nDimension reduction for face dataset.\n\n'))

K <- 100
Z <- projectData(X_norm, U, K)

cat(sprintf('The projected data Z has a size of: '))
cat(sprintf('%d ', dim(Z)))

cat(sprintf('\n\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ----- Part 7: Visualization of Faces after PCA Dimension Reduction -----
#  Project images to the eigen space using the top K eigen vectors and
#  visualize only using those K dimensions
#  Compare to the original input, which is also displayed

cat(sprintf('\nVisualizing the projected (reduced dimension) faces.\n\n'))

K <- 100
X_rec  <- recoverData(Z, U, K)

op <- par(mfrow=c(1,2))
# Display normalized data
displayData(X_norm[1:100,])
title('Original faces')


# Display reconstructed data from only k eigenfaces
displayData(X_rec[1:100,])
title(main='Recovered faces')

par(op)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## --- Part 8(a): Optional (ungraded) Exercise: PCA for Visualization ---
#  One useful application of PCA is to use it to visualize high-dimensional
#  data. In the last K-Means exercise you ran K-Means on 3-dimensional
#  pixel colors of an image. We first visualize this output in 3D, and then
#  apply PCA to obtain a visualization in 2D.


# Re-load the image from the previous exercise and run K-Means on it
# For this to work, you need to complete the K-Means assignment first
# library(png); A <- readPNG('bird_small.png')

# If readPNG does not work for you, you can try instead
load('bird_small.Rda')
list2env(data, .GlobalEnv)
rm(data)

A <- A / 255
img_size <- dim(A)
X <- matrix(A, img_size[1] * img_size[2], 3)
K <- 16
max_iters <- 10
initial_centroids <- kMeansInitCentroids(X, K)
kMean <- runkMeans(X, initial_centroids, max_iters)
centroids <- kMean$centroids
idx <- kMean$idx
#  Sample 1000 random indexes (since working with all the data is
#  too expensive. If you have a fast computer, you may increase this.
sel <- floor(runif(1000) * dim(X)[1]) + 1

#  Setup Color Palette
colors <- rainbow(K)[idx[sel]]

#  Visualize the data and centroid memberships in 3D
library(rgl)
open3d()
plot3d(X[sel,1],X[sel,2],X[sel,3]
       ,col=colors, xlab='',ylab='',zlab=''
       ,type="s",size = 1)

title3d(main='Pixel dataset plotted in 3D. Color shows centroid memberships')

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --- Part 8(b): Optional (ungraded) Exercise: PCA for Visualization ---
# Use PCA to project this cloud to 2D for visualization

# Subtract the mean to use PCA
fN <- featureNormalize(X)
X_norm <-fN$X_norm
mu <- fN$mu
sigma <- fN$sigma

# PCA and project the data to 2D
USV <- pca(X_norm)
U <- USV$u
S <- diag(USV$d)

Z <- projectData(X_norm, U, 2)

# Plot in 2D
plotDataPoints(Z[sel, ], idx[sel], K, FALSE)
title(main='Pixel dataset plotted in 2D, \nusing PCA for dimensionality reduction')

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)
