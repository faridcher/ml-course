predict <- function(Theta1, Theta2, X) {
  #PREDICT Predict the label of an input given a trained neural network
  #   p <- PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
  #   trained weights of a neural network (Theta1, Theta2)
  
  # Useful values
  if (is.vector(X))
    X <- t(X)
  
  m <- dim(X)[1]
  num_labels <- dim(Theta2)[1]
  
  # You need to return the following variables correctly
  p <- rep(0,m)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Complete the following code to make predictions using
  #               your learned neural network. You should set p to a
  #               vector containing labels between 1 to num_labels.
  #
  # Hint: The max function might come in useful. In particular, the which.max
  #       function can return the index of the max element, for more
  #       information see '?which.max'. If your examples are in rows, then, you
  #       can use apply(A, 1, max) to obtain the max for each row.
  #
  
  a1 <- cbind(rep(1,m), X)
  z2 <- a1 %*% t(Theta1)
  a2 <- cbind(rep(1,dim(z2)[1]) ,sigmoid(z2))
  z3 <- a2 %*% t(Theta2)
  a3 <- sigmoid(z3)
  
  p <- apply(a3,1,which.max)
  p
  # --------------------------------------------------------------------------
}
