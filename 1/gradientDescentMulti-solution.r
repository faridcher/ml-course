gradientDescentMulti <- function(X, y, theta, alpha, num_iters) {
  #GRADIENTDESCENTMULTI Performs gradient descent to learn theta
  #   theta <- GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
  #   taking num_iters gradient steps with learning rate alpha
  
  # Initialize some useful values
  m <- length(y) # number of training examples
  J_history <- rep(0,num_iters)
  
  for (iter in 1:num_iters) {
    # ---------------------- YOUR CODE HERE ----------------------
    # Instructions: Perform a single gradient step on the parameter vector
    #               theta.
    #
    # Hint: While debugging, it can be useful to print out the values
    #       of the cost function (computeCostMulti) and gradient here.
    #
    
    # create a copy of theta for simultaneous update.
    theta_prev <- theta
    
    # number of features.
    p <- dim(X)[2]
    
    for (j in 1:p) {
      # calculate dJ/d(theta_j)
      deriv <- (t(X %*% theta_prev - y) %*% X[,j]) / m
      
      # # update theta_j
      theta[j] <- theta_prev[j] - (alpha * deriv)
    }
    
    # ------------------------------------------------------------
    
    # Save the cost J in every iteration
    J_history[iter] <- computeCostMulti(X, y, theta)
    
  }
  list(theta = theta, J_history = J_history)
}
