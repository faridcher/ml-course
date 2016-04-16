featureNormalize <- function(X) {
  #FEATURENORMALIZE Normalizes the features in X
  #   FEATURENORMALIZE(X) returns a normalized version of X where
  #   the mean value of each feature is 0 and the standard deviation
  #   is 1. This is often a good preprocessing step to do when
  #   working with learning algorithms.
  
  # You need to set these values correctly
  X_norm <- X
  mu <- rep(0,dim(X)[2])
  sigma <- rep(0,dim(X)[2])
  
  # ---------------------- YOUR CODE HERE ----------------------
  # Instructions: First, for each feature dimension, compute the mean
  #               of the feature and subtract it from the dataset,
  #               storing the mean value in mu. Next, compute the
  #               standard deviation of each feature and divide
  #               each feature by it's standard deviation, storing
  #               the standard deviation in sigma.
  #
  #               Note that X is a matrix where each column is a
  #               feature and each row is an example. You need
  #               to perform the normalization separately for
  #               each feature.
  #
  # Hint: You might find the 'mean' and 'sd' functions useful.
  #
  
  # mu
  for (p in 1:dim(X)[2]) {
    mu[p] <- mean(X[,p])
  }
  
  # sigma
  for (p in 1:dim(X)[2]) {
    sigma[p] <- sd(X[,p])
  }
  
  # X_norm
  for (p in 1:dim(X)[2]) {
    if (sigma[p] != 0)
      for (i in 1:dim(X)[1])
        X_norm[i, p] <- (X[i, p] - mu[p]) / sigma[p]
      else
        # sigma(p) == 0 <=> forall i, j,  X(i, p) == X(j, p) == mu(p)
        # In this case,  normalized values are all zero.
        # (mean is 0,  standard deviation is sigma(=0))
        X_norm[, p] <- t(rep(0,dim(X)[1]))
  }
  
  list(X_norm = X_norm, mu = mu, sigma = sigma)
  # ------------------------------------------------------------
  
}
