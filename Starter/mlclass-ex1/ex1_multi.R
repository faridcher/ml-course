## Machine Learning Online Class
#  Exercise 1: Linear regression with multiple variables
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  linear regression exercise.
#
#  You will need to complete the following functions in this
#  exericse:
#
#     warmUpExercise.R
#     plotData.R
#     gradientDescent.R
#     computeCost.R
#     gradientDescentMulti.R
#     computeCostMulti.R
#     featureNormalize.R
#     normalEqn.R
#
#  For this part of the exercise, you will need to change some
#  parts of the code below for various experiments (e.g., changing
#  learning rates).
#

## Initialization
rm(list=ls())

sources <- c("featureNormalize.R", "computeCostMulti.R",
	"gradientDescentMulti.R","normalEqn.R","pinv.R")
for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## ---------------- Part 1: Feature Normalization ----------------
cat('Loading data ...\n')

## Load Data
data <- read.table('ex1data2.txt',sep = ',')
X <- data[,1:2]
y <- data[,3]
m <- length(y)

# Print out some data points
cat('First 10 examples from the dataset: \n')
temp <- cbind("X = [",X[1:10,], "], y =", y[1:10])
names(temp) <- NULL
print(temp)

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

# Scale features and set them to zero mean
cat('Normalizing Features ...\n')

fN <- featureNormalize(X)
X <- fN$X_norm
mu <- fN$mu
sigma <- fN$sigma

# Add intercept term to X
X <- cbind(rep(1,m),X)
X <- as.matrix(X)

## ---------------- Part 2: Gradient Descent ----------------
# Instructions: We have provided you with the following starter
#               code that runs gradient descent with a particular
#               learning rate (alpha).
#
#               Your task is to first make sure that your functions -
#               computeCost and gradientDescent already work with
#               this starter code and support multiple variables.
#
#               After that, try running gradient descent with
#               different values of alpha and see which one gives
#               you the best result.
#
#               Finally, you should complete the code at the end
#               to predict the price of a 1650 sq-ft, 3 br house.
#
#
# Hint: At prediction, make sure you do the same feature normalization.
#

cat('Running gradient descent ...\n')

# Choose some alpha value
alpha <- 1 # modified from 0.01 because 3.2.1
num_iters <- 50 #modified from 100 because 3.2.1

# Init Theta and Run Gradient Descent
theta <- rep(0,3)
# Here we can test different learning parameter alpha
gDM <- gradientDescentMulti(X, y, theta, alpha , num_iters)
theta <- gDM$theta
J_history <- gDM$J_history
rm(gDM)

# Plot the convergence graph
plot(1:length(J_history), J_history, type="l", col="blue", lwd=2, cex=.1,
     xlab="Number of Iterations", ylab="Cost J")

# Display gradient descent's result
cat('Theta computed from gradient descent: \n')
print(theta)

# Estimate the price of a 1650 sq-ft, 3 br house
# ---------------------- YOUR CODE HERE ----------------------
# Recall that the first column of X is all-ones. Thus, it does
# not need to be normalized.


# ------------------------------------------------------------

cat(sprintf('Predicted price of a 1650 sq-ft, 3 br house (using gradient descent):\n $%f\n', price))
cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

# Plotting Training and regressioned data.
cat('Plotting Training and regressioned results by gradient descent.\n')

X <- cbind(rep(1,m), data[, 1:2])
X <- as.matrix(X)
library(rgl)

open3d()
plot3d(X[,2],X[,3],y, 
       xlab= "sq-ft of room", ylab="#bedroom", zlab="price", col="blue",  
       type="s",size=1.5, main="Result of Gradient Descent")

xx <- seq(0,5000,length.out=25)
yy <- seq(1,5,length.out = 25)
zz <- matrix(0,length(xx),length(yy))

for (i in 1:length(xx))
  for (j in 1:length(yy))
    zz[i,j] <- cbind(1, (xx[i]-mu[1])/sigma[1],(yy[j]-mu[2])/sigma[2]) %*% theta

#MATLAB Like plane
nbcol = 100
color = rev(rainbow(nbcol, start = 0/6, end = 4/6))
zcol  = cut(zz, nbcol)

persp3d(xx,yy,zz, add = TRUE, col=color[zcol],alpha=.6)

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

## ---------------- Part 3: Normal Equations ----------------
# Instructions: The following code computes the closed form
#               solution for linear regression using the normal
#               equations. You should complete the code in
#               normalEqn.R
#
#               After doing so, you should complete this code
#               to predict the price of a 1650 sq-ft, 3 br house.
#

cat('Solving with normal equations...\n')
## Load Data
data <- read.table('ex1data2.txt',sep =',')
X <- data[, 1:2]
y <- data[, 3]
m <- length(y)

# Add intercept term to X
X <- cbind(rep(1,m),X)
X <- as.matrix(X)
# Calculate the parameters from the normal equation
theta <- normalEqn(X, y)

# Display normal equation's result
cat('Theta computed from the normal equations: \n')
print(theta)


# Estimate the price of a 1650 sq-ft, 3 br house
# ---------------------- YOUR CODE HERE ----------------------


# ------------------------------------------------------------

cat(sprintf('Predicted price of a 1650 sq-ft, 3 br house (using normal equations):\n $%f\n', price))
