## Machine Learning Online Class - Exercise 2: Logistic Regression
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the second part
#  of the exercise which covers regularization with logistic regression.
#
#  You will need to complete the following functions in this exericse:
#
#     sigmoid.R
#     costFunction.R
#     predict.R
#     costFunctionReg.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("costFunctionReg.R","sigmoid.R",
             "plotData.R","plotDecisionBoundary.R",
             "mapFeature.R","predict.R")
for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}
## Load Data
#  The first two columns contains the exam scores and the third column
#  contains the label.
data <- read.table('ex2data2.txt', sep = ',')
X <- data[,c(1,2)]; y <- data[,3]
X <- as.matrix(X)

plotData(X, y,axLables = c('Microchip Test 1','Microchip Test 2'),
         legLabels = c("y = 1","y = 0"))


## ------------- Part 1: Regularized Logistic Regression ------------
#  In this part, you are given a dataset with data points that are not
#  linearly separable. However, you would still like to use logistic
#  regression to classify the data points.
#
#  To do so, you introduce more features to use, in particular, you add
#  polynomial features to our data matrix (similar to polynomial
#  regression).
#

# Add Polynomial Features

# Note that mapFeature also adds a column of ones for us, so the intercept
# term is handled
X <- mapFeature(X[,1], X[,2])

# Initialize fitting parameters
initial_theta <- rep(0,dim(X)[2])

# Set regularization parameter lambda to 1
lambda <- 1

# Compute and display initial cost and gradient for regularized logistic
# regression
cost <- costFunctionReg(X, y, lambda)(initial_theta)
grd <- gradReg(X,y, lambda)(initial_theta)
cat(sprintf('Cost at initial theta (zeros): %f\n', cost))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## -------------- Part 2: Regularization and Accuracies --------------
#  Optional Exercise:
#  In this part, you will get to try different values of lambda and
#  see how regularization affects the decision coundart
#
#  Try the following values of lambda (0, 1, 10, 100).
#
#  How does the decision boundary change when you vary lambda? How does
#  the training set accuracy vary?
#

# Initialize fitting parameters
initial_theta <- rep(0,dim(X)[2])

# Set regularization parameter lambda to 1 (you should vary this)
lambda <- 0
#try with lambda in (1,0,100,155)
# Optimize
optimRes <- optim(par = initial_theta, 
                  fn = costFunctionReg(X,y,lambda), 
                  gr = gradReg(X,y,lambda), 
                  method="BFGS", 
                  control = list(maxit = 400))

theta <- optimRes$par
J <- optimRes$value

# Plot Boundary
plotDecisionBoundary(theta, X, y, axLables = c('Microchip Test 1','Microchip Test 2'),
                     legLabels = c("y = 1","y = 0"))
 
# Compute accuracy on our training set
p <- predict(theta, X)

cat(sprintf('Train Accuracy: %f\n', mean(p == y) * 100))
