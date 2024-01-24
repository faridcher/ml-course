estimateGaussian <- function(X) {
  #ESTIMATEGAUSSIAN This function estimates the parameters of a
  #Gaussian distribution using the data in X
  #   mu_sigma2 <- estimateGaussian(X),
  #   The input X is the dataset with each n-dimensional data point in one row
  #   The output is an n-dimensional vector mu, the mean of the data set
  #   and the variances sigma^2, an n x 1 vector
  #
  
  # Useful variables
  m <- dim(X)[1]
  n <- dim(X)[2]
  
  # You should return these values correctly
  mu <- rep(0,n)
  sigma2 <- rep(0,n)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Compute the mean of the data and the variances
  #               In particular, mu[i] should contain the mean of
  #               the data for the i-th feature and sigma2[i]
  #               should contain variance of the i-th feature.
  #
  
  
  list(mu = mu, sigma2 = sigma2)
  # --------------------------------------------------------------
}
