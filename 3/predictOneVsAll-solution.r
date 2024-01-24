predictOneVsAll  <- function(all_theta, X) {
  #PREDICT Predict whether the label is 0 or 1 using learned logistic
  #regression parameters all_theta
  #   p <- PREDICT(all_theta, X) computes the predictions for X using a
  #   threshold at 0.5 (i.e., if sigmoid(t(all_theta) %*% x) >= 0.5, predict 1)
  
  m <- dim(X)[1]
  num_labels <- dim(all_theta)[1]
  
  # You need to return the following variables correctly
  p <- rep(0,dim(X)[1])
  
  # Add ones to the X data matrix
  X <- cbind(rep(1,m), X)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Complete the following code to make predictions using
  #               your learned logistic regression parameters (one-vs-all).
  #               You should set p to a vector of predictions (from 1 to
  #               num_labels).
  #
  # Hint: This code can be done all vectorized using the which.max function.
  #       In particular, the which.max function can return the index of the
  #       max element, for more information see '?which.max'. If your examples
  #       are in rows, then, you can use apply(A, 1, max) to obtain the max
  #       for each row.
  #
  
  ps <- sigmoid(X %*% t(all_theta))
  
  i_max <- apply(ps,1, which.max)
  p <- i_max
  
  p  
  # --------------------------------------------------------------------------
}
