oneVsAll <- function(X, y, num_labels, lambda) {
  #ONEVSALL trains multiple logistic regression classifiers and returns all
  #the classifiers in a matrix all_theta, where the i-th row of all_theta
  #corresponds to the classifier for label i
  #   all_theta <- ONEVSALL(X, y, num_labels, lambda) trains num_labels
  #   logisitc regression classifiers and returns each of these classifiers
  #   in a matrix all_theta, where the i-th row of all_theta corresponds
  #   to the classifier for label i
  
  # Some useful variables
  m <- dim(X)[1]
  n <- dim(X)[2]
  
  # You need to return the following variables correctly
  all_theta <- matrix(0,num_labels,n + 1)
  
  # Add ones to the X data matrix
  X <- cbind(rep(1,m),X)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: You should complete the following code to train num_labels
  #               logistic regression classifiers with regularization
  #               parameter lambda.
  #
  # Hint: c(theta) will return a column vector.
  #
  # Hint: You can use y == c to obtain a vector of 1's and 0's that tell use
  #       whether the ground truth is true/false for this class.
  #
  # Note: For this assignment, we recommend using optim to optimize the cost
  #       function. It is okay to use a for-loop (for i in 1:num_labels) to
  #       loop over the different classes.
  #
  #
  # Example Code for optim:
  #
  #     # Set Initial theta
  #     initial_theta <- rep(0,n + 1)
  #
  #     # Run optim to obtain the optimal theta
  #     # This function will return theta and the cost
  #     opt <- optim(
  #       initial_theta,lrCostFunction(X,y == i,lambda),
  #       gr = lrGradFunction(X,y == i,lambda),method = "BFGS"
  #       ,control = list(maxit = 50))
  #
  
  all_theta
  # --------------------------------------------------------------------------
  
}
