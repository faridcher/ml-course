recoverData <- function(Z, U, K) {
  #RECOVERDATA Recovers an approximation of the original data when using the
  #projected data
  #   X_rec <- RECOVERDATA(Z, U, K) recovers an approximation the
  #   original data that has been reduced to K dimensions. It returns the
  #   approximate reconstruction in X_rec.
  #
  
  # You need to return the following variables correctly.
  X_rec <- matrix(0,dim(Z)[1],dim(U)[1])
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Compute the approximation of the data by projecting back
  #               onto the original space using the top K eigenvectors in U.
  #
  #               For the i-th example Z[i,], the (approximate)
  #               recovered data for dimension j is given as follows:
  #                    v <- t(Z[i,])
  #                    recovered_j <- t(v) %*% t(U[j, 1:K])
  #
  #               Notice that U[j, 1:K] is a row vector.
  #
  
  
  X_rec
  
  # --------------------------------------------------------------
  
}
