## Machine Learning Online Class
#  Exercise 5 | Regularized Linear Regression and Bias-Variance
#
#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     linearRegCostFunction.R
#     learningCurve.R
#     validationCurve.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("featureNormalize.R","learningCurve.R",
             "linearRegCostFunction.R","plotFit.R","polyFeatures.R",
             "trainLinearReg.R","validationCurve.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## ------------- Part 1: Loading and Visualizing Data --------------
#  We start the exercise by first loading and visualizing the dataset. 
#  The following code will load the dataset into your environment and plot
#  the data.
#

# Load Training Data
cat(sprintf('Loading and Visualizing Data ...\n'))

# Load from ex5data1: 
# You will have X, y, Xval, yval, Xtest, ytest in your environment


load(file="ex5data1.Rda") # load data var

list2env(data, env = .GlobalEnv)
rm(data)
# m <- Number of examples
m <- dim(X)[1]

# Plot training data
plot(X, y, pch=4, lwd=2, col=2, xlab="change in water level (X)", 
     ylab= "water flowing out of the dam (y)")

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 2: Regularized Linear Regression Cost --------------
#  You should now implement the cost function for regularized linear 
#  regression. 
#

theta <- c(1,1)
J <- linearRegCostFunction(cbind(1,X), y, 1)(theta)


cat(sprintf('Cost at theta = (1,1): %f \n(this value should be about 303.993192)\n', J))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 3: Regularized Linear Regression Gradient --------------
#  You should now implement the gradient for regularized linear 
#  regression.
#

theta <- c(1,1)
grad <- linearRegGradFunction(cbind(1,X), y, 1)(theta)

cat(sprintf('Gradient at theta = (1,1):  [%f; %f] \n
(this value should be about [-15.303016; 598.250744])\n',
            grad[1], grad[2]))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------- Part 4: Train Linear Regression --------------
#  Once you have implemented the cost and gradient correctly, the
#  trainLinearReg function will use your cost function to train 
#  regularized linear regression.
# 
#  Write Up Note: The data is non-linear, so this will not give a great 
#                 fit.
#

#  Train linear regression with lambda <- 0
lambda <- 0
theta <- trainLinearReg(cbind(1,X), y, lambda)

#  Plot fit over the data
plot(X, y, col="red", lwd=2, pch=4, 
     xlab="change in water level (x)",
     ylab="water flowing out of the dam (y)")

lines(X, cbind(1,X) %*% theta, lwd=2, col="blue")

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------- Part 5: Learning Curve for Linear Regression --------------
#  Next, you should implement the learningCurve function. 
#
#  Write Up Note: Since the model is underfitting the data, we expect to
#                 see a graph with "high bias" -- slide 8 in ML-advice.pdf 
#

lambda <- 0
lC <- learningCurve(cbind(1,X), y, cbind(1, Xval), yval, lambda)
error_train <- lC$error_train
error_val <- lC$error_val
rm(lC)

#setup plot
plot(c(1:m,1:m),c(error_train,error_val), type="n",
     main='Learning curve for linear regression',
     xlab="Number of training examples", ylab="Error")
lines(1:m, error_train, type="l",col="blue")
lines(1:m, error_val, type="l", col="green")
legend("topright",c("Train","Cross Validation"), 
       col=c("blue","green"), lty=1)

cat(sprintf('# Training Examples\tTrain Error\tCross Validation Error\n'))

for (i in 1:m)
    cat(sprintf('  \t%d\t\t%f\t%f\n', i, error_train[i], error_val[i]))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 6: Feature Mapping for Polynomial Regression --------------
#  One solution to this is to use polynomial regression. You should now
#  complete polyFeatures to map each example into its powers
#

p <- 8

# Map X onto Polynomial Features and Normalize
X_poly <- polyFeatures(X, p)
fN <- featureNormalize(X_poly)  # Normalize
X_poly <- fN$X_norm
mu <- fN$mu
sigma <- fN$sigma
rm(fN)

# Add Ones
X_poly <- cbind(rep(1,m), X_poly)

# Map X_poly_test and normalize (using mu and sigma)
X_poly_test <- polyFeatures(Xtest, p)
X_poly_test <- matrix(mapply(`-`,t(X_poly_test),mu),dim(X_poly_test) ,byrow = TRUE)
X_poly_test <- matrix(mapply(`/`,t(X_poly_test),sigma),dim(X_poly_test) ,byrow = TRUE)
X_poly_test <-  cbind(rep(1,dim(X_poly_test)[1]), X_poly_test)

# Map X_poly_val and normalize (using mu and sigma)
X_poly_val <- polyFeatures(Xval, p)
X_poly_val <- matrix(mapply(`-`,t(X_poly_val),mu),dim(X_poly_val) ,byrow = TRUE)
X_poly_val <- matrix(mapply(`/`,t(X_poly_val),sigma),dim(X_poly_val) ,byrow = TRUE)
X_poly_val <-  cbind(rep(1,dim(X_poly_val)[1]), X_poly_val)

cat(sprintf('Normalized Training Example 1:\n'))
cat(sprintf('  %f  \n', X_poly[1,]))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)



## ------------- Part 7: Learning Curve for Polynomial Regression --------------
#  Now, you will get to experiment with polynomial regression with multiple
#  values of lambda. The code below runs polynomial regression with 
#  lambda <- 0. You should try running the code with different values of
#  lambda to see how the fit and learning curve change.
#

lambda <- 0
theta <- trainLinearReg(X_poly, y, lambda)

# Plot training data and fit
plotFit(min(X), max(X), mu, sigma, theta, p)
points(X, y, col="red", lwd=2, pch=4)


lC <- learningCurve(X_poly, y, X_poly_val, yval, lambda)
error_train <- lC$error_train
error_val <- lC$error_val
rm(lC)


plot(c(1:m,1:m),c(error_train,error_val), type="n",
     main=sprintf('Polynomial Regression \nLearning Curve (lambda <- %f)', lambda),
     xlab='Number of training examples', ylab="Error")
lines(1:m, error_train, type="l",col="blue",lwd=2)
lines(1:m, error_val, type="l", col="green", lwd=2)
legend("topright",c("Train","Cross Validation"), 
       col=c("blue","green"), lty=1)


cat(sprintf('Polynomial Regression (lambda <- %f)\n\n', lambda))
cat(sprintf('# Training Examples\tTrain Error\tCross Validation Error\n'))
for (i in 1:m)
    cat(sprintf('  \t%d\t\t%f\t%f\n', i, error_train[i], error_val[i]))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 8: Validation for Selecting Lambda --------------
#  You will now implement validationCurve to test various values of 
#  lambda on a validation set. You will then use this to select the
#  "best" lambda value.
#

vC <- validationCurve(X_poly, y, X_poly_val, yval)
lambda_vec <- vC$lambda_vec
error_train <- vC$error_train
error_val <- vC$error_val
rm(vC)

plot(c(lambda_vec,lambda_vec),c(error_train,error_val), type="n",
     xlab='lambda', ylab="Error")
lines(lambda_vec, error_train, type="l",col="blue",lwd=2)
lines(lambda_vec, error_val, type="l", col="green", lwd=2)
legend("topleft",c("Train","Cross Validation"), 
       col=c("blue","green"), lty=1)

cat(sprintf('lambda\t\tTrain Error\tValidation Error\n'))
for (i in 1:length(lambda_vec))
	cat(sprintf(' %f\t%f\t%f\n',lambda_vec[i], error_train[i], error_val[i]))


cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)
