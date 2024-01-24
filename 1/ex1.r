## Machine Learning Online Class - Exercise 1: Linear Regression

#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  linear exercise. You will need to complete the following functions
#  in this exericse:
#
#     warmUpExercise.r
#     plotData.r
#     gradientDescent.r
#     computeCost.r
#     gradientDescentMulti.r
#     computeCostMulti.r
#     featureNormalize.r
#     normalEqn.r
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#
# x refers to the population size in 10,000s
# y refers to the profit in $10,000s
#

## Initialization
rm(list=ls())
sources <- c("computeCost.r","gradientDescent.r",
             "plotData.r","warmUpExercise.r")
# Run the following instead, if you want to execute the solution scripts.
sources <- paste0(substr(sources,1,nchar(sources)-2), '-solution.r')
for (i in 1:length(sources)) {
  paste("Loading ",sources[i],"\n")
  source(sources[i])
}

## -------------------- Part 1: Basic Function --------------------
# Complete warmUpExercise.r
cat('Running warmUpExercise ... \n')
cat('5x5 Identity Matrix: \n')
warmUpExercise()

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

## ----------------------- Part 2: Plotting -----------------------
cat('Plotting Data ...\n')
# read the data as a data.frame
data <- read.table("ex1data1.txt",sep=',')
X <- data[, 1]
y <- data[, 2]
m <- length(y) # number of training examples

# Plot Data
# Note: You have to complete the code in plotData.r
plotData(X, y)

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

## ------------------- Part 3: Gradient descent -------------------
cat('Running Gradient Descent ...\n')

X <- cbind(rep(1,m),X) # Add a column of ones to x
X <- as.matrix(X)
# initialize fitting parameters
theta <- c(8,3)

# Some gradient descent settings
iterations <- 1500
alpha <- 0.02

# compute and display initial cost
computeCost(X, y, theta)

# run gradient descent
gd <- gradientDescent(X, y, theta, alpha, iterations)
#Decompose list (gd) variables into global env variables
theta <- gd$theta
J_history <- gd$J_history
theta_history <- gd$theta_history
rm(gd)

# print theta to screen
cat('Theta found by gradient descent: ')
sprintf('%f %f \n', theta[1], theta[2])

# Plot the linear fit
# keep previous plot visible
lines(X[, 2], X  %*% theta, col="blue")
legend("bottomright", c('Training data', 'Linear regression'), pch=c(4,NA),col=c("red","blue"), lty=c(NA,1) )

# Predict values for population sizes of 35,000 and 70,000
predict1 <- c(1, 3.5) %*% theta
sprintf('For population = 35,000, we predict a profit of %f\n',predict1*10000)
predict2 <- c(1, 7) %*% theta
sprintf('For population = 70,000, we predict a profit of %f\n',predict2*10000)

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

## ------------- Part 4: Visualizing J(theta_0, theta_1) -------------
cat('Visualizing J(theta_0, theta_1) ...\n')

# Grid over which we will calculate J
theta0_vals <- seq(-10, 10, length.out=100)
theta1_vals <- seq(-2, 4, length.out=100)

# initialize J_vals to a matrix of 0's
J_vals <- matrix(0, length(theta0_vals), length(theta1_vals))

# Fill out J_vals
for (i in 1:length(theta0_vals)) {
    for (j in 1:length(theta1_vals)) {
      J_vals[i,j] <- computeCost(X, y, c(theta0_vals[i], theta1_vals[j]))
    }
}

nbcol = 100
color = rev(rainbow(nbcol, start = 0/6, end = 4/6))
J_vals_col = cut(J_vals, nbcol)
# Unlike rgl::persp3d, graphics::persp assigns colors to facets. We compute a facet's z as the sum of its vertices' z.
persp_zfacet <- function (z) {
  ncz <- ncol(z)
  nrz <- nrow(z)
  zfacet <- z[-1, -1] + z[-1, -ncz] + z[-nrz, -1] + z[-nrz, -ncz]
}
J_vals_col  = cut(persp_zfacet(J_vals), nbcol)
pmat <- persp(theta0_vals, theta1_vals, J_vals, col = color[J_vals_col],
        xlab="theta_0", ylab="theta_1",
        zlab="Cost", main = "(a) Gradient Descent", ticktype="detailed", phi=45, theta=45)
t <- trans3d(theta_history[, 1], theta_history[, 2], J_history+10, pmat)
points(t, col="red")
lines(t, col="red")

# # Alternatively, we may use rgl package for an interactive 3D plot. First install the package with install.packages("rgl"), and then uncomment and run these lines.
# library(rgl) 
# open3d()
# persp3d(theta0_vals, theta1_vals, J_vals, col = color[J_vals_col],
#         xlab=expression(theta_0), ylab=expression(theta_1),
#         zlab="Cost", main = "Gradient Descent")
# points3d(theta_history[, 1], theta_history[, 2], J_history+10, 
#          col="red",size=3.5)
# lines3d(theta_history[, 1], theta_history[, 2], J_history+10, col="red")

# Contour plot
# Plot J_vals as 20 contours spaced logarithmically between 0.01 and 100
# logarithmic contours are denser near the center
logspace <- function( d1, d2, n) 
            return(exp(log(10)*seq(d1, d2, length.out=n)))
            #or return(10^seq(d1, d2, length.out=n))

contour(theta0_vals, theta1_vals, J_vals, levels = logspace(-2, 3, 20), 
        xlab=expression(theta_0),
        ylab=expression(theta_1),
        drawlabels = FALSE)

points(theta[1], theta[2], pch=4, cex=2,col="red",lwd=2)
points(theta_history[, 1], theta_history[, 2], col="red",cex=.2,lwd=1,pch=19)
lines(theta_history[, 1], theta_history[, 2], col="red")
