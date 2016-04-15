## Machine Learning Online Class - Exercise 2: Logistic Regression
#
#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the logistic
#  regression exercise. You will need to complete the following functions 
#  in this exericse:
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

## Load Data
#  The first two columns contains the exam scores and the third column
#  contains the label.
rm(list=ls())
sources <- c("costFunction.R","sigmoid.R","plotData.R",
             "plotDecisionBoundary.R","mapFeature.R",
             "predict.R")
for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

data <- read.table('ex2data1.txt',sep = ',')
X <- data[,c(1,2)]; y <- data[,3]
X <- as.matrix(X)
## ---------------------- Part 1: Plotting ----------------------
#  We start the exercise by first plotting the data to understand the 
#  the problem we are working with.

cat(sprintf('Plotting data with + indicating (y = 1) examples and o indicating (y = 0) examples.\n'))

plotData(X, y)

cat(sprintf('\nProgram paused. Press enter to continue.\n'))


## ------------ Part 2: Compute Cost and Gradient ------------
#  In this part of the exercise, you will implement the cost and gradient
#  for logistic regression. You neeed to complete the code in 
#  costFunction.R

#  Setup the data matrix appropriately, and add ones for the intercept term
m <- dim(X)[1]
n <- dim(X)[2]

# Add intercept term to x and X_test
X <- cbind(rep(1,m),X)
# Initialize fitting parameters
initial_theta <- rep(0,n+1)

# Compute and display initial cost and gradient
cF <- costFunction(X, y)(initial_theta)
cost <- costFunction(X, y)(initial_theta)
grd <- grad(X,y)(initial_theta)

cat(sprintf('Cost at initial theta (zeros): %f\n', cost))
cat(sprintf('Gradient at initial theta (zeros): \n'))
cat(sprintf(' %f \n', grd))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------------- Part 3: Optimizing using optim  --------------
#  In this exercise, you will use a built-in function (optim) to find the
#  optimal parameters theta.

#  Run optim to obtain the optimal theta
#  This function will return theta and the cost 
#  maxit is maximum iteration

optimRes <- optim(par = initial_theta, fn = costFunction(X,y), gr = grad(X,y), 
      method="BFGS", control = list(maxit = 400))
theta <- optimRes$par
cost <- optimRes$value

# Print theta to screen
cat(sprintf('Cost at theta found by optim: %f\n', cost))
cat(sprintf('theta: \n'))
cat(sprintf(' %f \n', theta))

# Plot Boundary
plotDecisionBoundary(theta, X, y)


cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ---------------- Part 4: Predict and Accuracies ----------------
#  After learning the parameters, you'll like to use it to predict the outcomes
#  on unseen data. In this part, you will use the logistic regression model
#  to predict the probability that a student with score 20 on exam 1 and 
#  score 80 on exam 2 will be admitted.
#
#  Furthermore, you will compute the training and test set accuracies of 
#  our model.
#
#  Your task is to complete the code in predict.R

#  Predict probability for a student with score 45 on exam 1 
#  and score 85 on exam 2 

prob <- sigmoid(t(c(1,45,85)) %*% theta)
cat(sprintf('For a student with scores 45 and 85, we predict an admission probability of\n %f\n', prob))

# Compute accuracy on our training set
p <- predict(theta, X)

cat(sprintf('Train Accuracy: %f\n', mean(p == y) * 100))

#pause

