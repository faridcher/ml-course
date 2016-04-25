gradientDescent <- function(X, y, theta, alpha, num_iters) {
  #GRADIENTDESCENT Performs gradient descent to learn theta
  #   theta <- GRADIENTDESENT(X, y, theta, alpha, num_iters) updates theta by
  #   taking num_iters gradient steps with learning rate alpha
  
  # Initialize some useful values
  m <- length(y) # number of training examples
  J_history = rep(0,num_iters + 1)
  theta_history = matrix(0,num_iters + 1,length(theta))
  
  theta_history[1,] = t(theta)
  J_history[1] = computeCost(X, y, theta)
  
  for (iter in 2:(num_iters + 1)) {
    # ---------------------- YOUR CODE HERE ----------------------
    # Instructions: Perform a single gradient step on the parameter vector
    #               theta.
    #
    # Hint: While debugging, it can be useful to print out the values
    #       of the cost function (computeCost) and gradient here.
    #
    
    # create a copy of theta for simultaneous update.
    theta_prev = theta
    
    # number of features.
    p = dim(X)[2]
    
    # simultaneous update theta using theta_prev.
    for (j in 1:p) {
      # vectorized version
      # (exactly the same with multivariate version)
      deriv = (t(X %*% theta_prev - y) %*% X[, j]) / m
      
      # update theta_j
      theta[j] = theta_prev[j] - (alpha * deriv)
    }
    
    # Save the cost J in every iteration
    J_history[iter] = computeCost(X, y, theta)
    theta_history[iter,] = t(theta)
  }
  
  list(theta = theta, J_history = J_history, theta_history = theta_history)
  # ------------------------------------------------------------
}
