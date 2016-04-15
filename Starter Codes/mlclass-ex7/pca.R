pca <- function(X) {
  #PCA Run principal component analysis on the dataset X
  #   [U, S, X] <- pca(X) computes eigenvectors of the covariance matrix of X
  #   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
  #
  
  # Useful values
  m <- dim(X)[1]
  n <- dim(X)[2]
  
  # You need to return the following variables correctly.
  U <- rep(0,n)
  S <- rep(0,n)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: You should first compute the covariance matrix. Then, you
  #               should use the "svd" function to compute the eigenvectors
  #               and eigenvalues of the covariance matrix.
  #
  # Note: When computing the covariance matrix, remember to divide by m (the
  #       number of examples).
  #
  
  USV
  # -------------------------------------------------------------------------
  
}
