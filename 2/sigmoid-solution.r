sigmoid <- function(z) {
  #SIGMOID Compute sigmoid functoon
  #   J <- SIGMOID(z) computes the sigmoid of z.
  
  # You need to return the following variables correctly
  g <- matrix(0,dim(as.matrix(z)))
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Compute the sigmoid of each value of z (z can be a matrix,
  #               vector or scalar).
  
  g <- 1 / (1 + exp(-1 * z))
  g
  # ----------------------------------------------------
}
