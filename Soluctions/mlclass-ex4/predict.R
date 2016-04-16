predict <- function(Theta1, Theta2, X) {
  #PREDICT Predict the label of an input given a trained neural network
  #   p <- PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
  #   trained weights of a neural network (Theta1, Theta2)
  
  if (is.vector(X))
    X <- t(X)
  
  # Useful values
  m <- dim(X)[1]
  num_labels <- dim(Theta2)[1]
  
  # You need to return the following variables correctly
  p <- rep(0,dim(X)[1])
  
  h1 <- sigmoid(cbind(rep(1,m),X) %*% t(Theta1))
  h2 <- sigmoid(cbind(rep(1,m),h1) %*% t(Theta2))
  
  p <- apply(h2,1,which.max)
  p
  # --------------------------------------------------------------------------

}
