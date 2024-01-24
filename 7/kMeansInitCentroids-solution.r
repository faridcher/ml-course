kMeansInitCentroids  <- function(X, K) {
  #KMEANSINITCENTROIDS This function initializes K centroids that are to be
  #used in K-Means on the dataset X
  #   centroids <- KMEANSINITCENTROIDS(X, K) returns K initial centroids to be
  #   used with the K-Means on the dataset X
  #
  
  # You should return these values correctly
  centroids <- matrix(0,K,dim(X)[2])
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: You should set centroids to randomly chosen examples from
  #               the dataset X
  #
  
  # Randomly reorder the indices of examples
  randidx <- sample(dim(X)[1])
  # Take the first K examples as centroids
  centroids <- X[randidx[1:K],]
  centroids
  # --------------------------------------------------------------
  
}
