costFunctionReg  <- function(X, y, lambda) {
  #COSTFUNCTIONREG Compute cost for logistic regression with regularization
  #   J <- COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
  #   theta as the parameter for regularized logistic regression
  function(theta)  {
    # Initialize some useful values
    m <- length(y); # number of training examples
    
    # You need to return the following variables correctly
    J <- 0
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the cost of a particular choice of theta.
    #               You should set J to the cost.
    
    
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
    
    
    grad
    # ----------------------------------------------------
  }
}
