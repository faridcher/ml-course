## Machine Learning Online Class
#  Exercise 6 | Support Vector Machines
#
#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     gaussianKernel.R
#     dataset3Params.R
#     processEmail.R
#     emailFeatures.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("gaussianKernel.R","dataset3Params.R", "plotData.R",
             "svmPredict.R","visualizeBoundary.R","bsxfun.R",
             "linearKernel.R","visualizeBoundaryLinear.R","svmTrain.R","meshgrid.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## --------------- Part 1: Loading and Visualizing Data -----------------
#  We start the exercise by first loading and visualizing the dataset. 
#  The following code will load the dataset into your environment and plot
#  the data.
#
cat(sprintf('Loading and Visualizing Data ...\n'))

# Load from ex6data1: 
# You will have X, y in your environment


load("ex6data1.Rda")
list2env(data, env = .GlobalEnv)
rm(data)
# Plot training data
plotData(X, y)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ---------------------- Part 2: Training Linear SVM ----------------------
#  The following code will train a linear SVM on the dataset and plot the
#  decision boundary learned.
#

cat(sprintf('\nTraining Linear SVM ...\n'))

# You should try to change the C value below and see how the decision
# boundary varies (e.g., try C <- 1000)
C <- 1
Rprof()
model <- svmTrain(X, y, C, linearKernel, 1e-3, 20)
visualizeBoundaryLinear(X, y, model)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------- Part 3: Implementing Gaussian Kernel ---------------
#  You will now implement the Gaussian kernel to use
#  with the SVM. You should complete the code in gaussianKernel.R
#
cat(sprintf('\nEvaluating the Gaussian Kernel ...\n'))

x1 <- c(1, 2, 1)
x2 <- c(0, 4, -1)
sigma <- 2
sim <- gaussianKernel(sigma)(x1, x2)

cat(sprintf('Gaussian Kernel between x1 = [1; 2; 1], x2 = [0; 4; -1], sigma = 0.5 :\n
\t%f\n(this value should be about 0.324652)\n', sim))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------- Part 4: Visualizing Dataset 2 -----------------
#  The following code will load the next dataset into your environment and 
#  plot the data.
#

cat(sprintf('Loading and Visualizing Data ...\n'))

# Load from ex6data2: 
# You will have X, y in your environment


load("ex6data2.Rda")
list2env(data,.GlobalEnv)
rm(data)
# Plot training data
plotData(X, y)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ----------- Part 5: Training SVM with RBF Kernel (Dataset 2) -----------
#  After you have implemented the kernel, we can now use it to train the 
#  SVM classifier.
# 
cat(sprintf('\nTraining SVM with RBF Kernel (this may take 1 to 2 minutes) ...\n'))

# Load from ex6data2: 
# You will have X, y in your environment
load("ex6data2.Rda")
list2env(data,.GlobalEnv)
rm(data)
# SVM Parameters
C <- 1; sigma <- 0.1

# We set the tolerance and max_passes lower here so that the code will run
# faster. However, in practice, you will want to run the training to
# convergence.
model<- svmTrain(X, y, C, gaussianKernel(sigma))
q <- visualizeBoundary(X, y, model)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------- Part 6: Visualizing Dataset 3 -----------------
#  The following code will load the next dataset into your environment and 
#  plot the data. 
#

cat(sprintf('Loading and Visualizing Data ...\n'))

# Load from ex6data3: 
# You will have X, y in your environment
load("ex6data3.Rda")
list2env(data,.GlobalEnv)
rm(data)
# Plot training data
plotData(X, y)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ----------- Part 7: Training SVM with RBF Kernel (Dataset 3) -----------

#  This is a different dataset that you can use to experiment with. Try
#  different values of C and sigma here.
# 

# Load from ex6data3: 
# You will have X, y in your environment
load("ex6data3.Rda")
list2env(data,.GlobalEnv)
rm(data)

# Try different SVM Parameters here. take about 2 min
d3P <- dataset3Params(X, y, Xval, yval)
C <- d3P$C #1
sigma <- d3P$sigma #0.1
rm(d3P)

# Train the SVM
model<- svmTrain(X, y, C, gaussianKernel(sigma))
visualizeBoundary(X, y, model)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

