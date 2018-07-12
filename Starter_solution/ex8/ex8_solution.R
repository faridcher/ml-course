## Machine Learning Online Class
#  Exercise 8 | Anomaly Detection and Collaborative Filtering
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     estimateGaussian.R
#     selectThreshold.R
#     cofiCostFunc.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("bsxfun.R","estimateGaussian.R","meshgrid.R",
             "multivariateGaussian.R","pinv.R","selectThreshold.R",
             "visualizeFit.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## ------------------ Part 1: Load Example Dataset  --------------------
#  We start this exercise by using a small dataset that is easy to
#  visualize.
#
#  Our example case consists of 2 network server statistics across
#  several machines: the latency and throughput of each machine.
#  This exercise will help us find possibly faulty (or very fast) machines.
#

cat(sprintf('Visualizing example dataset for outlier detection.\n\n'))

#  The following command loads the dataset. You should now have the
#  variables X, Xval, yval in your environment
load("ex8data1.Rda")
list2env(data,.GlobalEnv)
rm(data)

#  Visualize the example dataset
plot(X[,1], X[,2], xlim=c(0,30),ylim=c(0,30), pch=4, col="blue",
     xlab='Latency (ms)', ylab='Throughput (mb/s)')

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------------ Part 2: Estimate the dataset statistics --------------------
#  For this exercise, we assume a Gaussian distribution for the dataset.
#
#  We first estimate the parameters of our assumed Gaussian distribution, 
#  then compute the probabilities for each of the points and then visualize 
#  both the overall distribution and where each of the points falls in 
#  terms of that distribution.
#
cat(sprintf('Visualizing Gaussian fit.\n\n'))

#  Estimate mu and sigma2
eG <- estimateGaussian(X)
mu <- eG$mu
sigma2 <- eG$sigma2

#  Returns the density of the multivariate normal at each data point (row) 
#  of X
p <- multivariateGaussian(X, mu, sigma2)

#  Visualize the fit
visualizeFit(X,  mu, sigma2)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------------ Part 3: Find Outliers --------------------
#  Now you will find a good epsilon threshold using a cross-validation set
#  probabilities given the estimated Gaussian distribution
# 

pval <- multivariateGaussian(Xval, mu, sigma2)

sT <- selectThreshold(yval, pval)
epsilon <- sT$bestEpsilon
F1 <- sT$bestF1

cat(sprintf('Best epsilon found using cross-validation: %e\n', epsilon))
cat(sprintf('Best F1 on Cross Validation Set:  %f\n', F1))
cat(sprintf('(you should see a value epsilon of about 8.99e-05)\n\n'))

#  Find the outliers in the training set and plot the
outliers <- which(p < epsilon)

#  Draw a red circle around those outliers
points(X[outliers, 1], X[outliers, 2], col="red", lwd=2, cex=2 )

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------------ Part 4: Multidimensional Outliers --------------------
#  We will now use the code from the previous part and apply it to a 
#  harder problem in which more features describe each datapoint and only 
#  some features indicate whether a point is an outlier.
#

#  Loads the second dataset. You should now have the
#  variables X, Xval, yval in your environment
load("ex8data2.Rda")
list2env(data,.GlobalEnv)
rm(data)

#  Apply the same steps to the larger dataset
eG <- estimateGaussian(X)
mu <- eG$mu
sigma2 <- eG$sigma2
rm(eG)

#  Training set 
p <- multivariateGaussian(X, mu, sigma2)

#  Cross-validation set
pval <- multivariateGaussian(Xval, mu, sigma2)

#  Find the best threshold
sT <- selectThreshold(yval, pval)
epsilon <- sT$bestEpsilon
F1 <- sT$bestF1

cat(sprintf('Best epsilon found using cross-validation: %e\n', epsilon))
cat(sprintf('Best F1 on Cross Validation Set:  %f\n', F1))
cat(sprintf('# Outliers found: %d\n', sum(p < epsilon)))
cat(sprintf('   (you should see a value epsilon of about 1.38e-18)\n\n'))
line <- readLines(con = stdin(),1)
