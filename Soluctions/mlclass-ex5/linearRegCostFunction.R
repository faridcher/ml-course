linearRegCostFunction <- function(X, y, lambda) {
  #LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear
  #regression with multiple variables
  #   [J, grad] <- LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the
  #   cost of using theta as the parameter for linear regression to fit the
  #   data points in X and y. Returns the cost in J and the gradient in grad
  
  function(theta) {
    # Initialize some useful values
    m <- length(y) # number of training examples
    
    # You need to return the following variables correctly
    J <- 0
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the cost and gradient of regularized linear
    #               regression for a particular choice of theta.
    #
    #               You should set J to the cost and grad to the gradient.
    #
    h = X %*% theta
    thetas <- theta[-1]
    J <-
      1 / (2 * m) * sum((h - y) ^ 2) + (lambda / (2 * m)) * sum(theta ^ 2)
    J
    # --------------------------------------------------------------
  }
}

linearRegGradFunction <- function(X, y, lambda) {
  #LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear
  #regression with multiple variables
  #   [J, grad] <- LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the
  #   cost of using theta as the parameter for linear regression to fit the
  #   data points in X and y. Returns the cost in J and the gradient in grad
  
  function(theta) {
    # Initialize some useful values
    m <- length(y) # number of training examples
    
    # You need to return the following variables correctly
    grad <- rep(0,length(theta))
    # ---------------------- YOUR CODE HERE ----------------------
    # Instructions: Compute the cost and gradient of regularized linear
    #               regression for a particular choice of theta.
    #
    #               You should set J to the cost and grad to the gradient.
    #
    h = X %*% theta
    
    # Calculate gradient
    temp <- theta
    temp[1] <- 0
    grad <- (1 / m) * (t(X) %*% (h - y) + lambda * temp)
    # --------------------------------------------------------------
  }
}
