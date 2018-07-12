costFunctionReg  <- function(X, y, lambda) {
  #COSTFUNCTIONREG Compute cost for logistic regression with regularization
  #   J <- COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
  #   theta as the parameter for regularized logistic regression
  function(theta)  {
    # Initialize some useful values
    m <- length(y) # number of training examples
    
    # You need to return the following variables correctly
    J <- 0
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the cost of a particular choice of theta.
    #               You should set J to the cost.
    
    # calculate hypothesis function h(x)
    h <- sigmoid(X %*% theta)
    # excluded the first theta value
    theta1 <- c(0,theta[-1])
    p <- lambda * (t(theta1) %*% theta1) / (2 * m)
    J <- (t(-y) %*% log(h) - t(1 - y) %*% log(1 - h)) / m + p
    J
    # ----------------------------------------------------
  }
}

gradReg  <- function (X, y, lambda) {
  #COSTFUNCTIONREG Compute gradient for logistic regression with regularization
  #   J <- COSTFUNCTIONREG(theta, X, y, lambda) computes the
  #   gradient of the cost w.r.t. to the parameters.
  function(theta)  {
    # Initialize some useful values
    m <- length(y); # number of training examples
    
    # You need to return the following variables correctly
    grad <- rep(0,length(theta))
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the partial derivatives and set grad to the partial
    #               derivatives of the cost w.r.t. each parameter in theta
    
    # calculate hypothesis function
    h <- sigmoid(X %*% theta)
    # excluded the first theta value
    theta1 <- c(0,theta[-1])
    
    # calculate grads
    grad <- (t(X) %*% (h - y) + lambda * theta1) / m
    grad
    # ----------------------------------------------------
  }
}
