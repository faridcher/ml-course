findClosestCentroids  <- function(X, centroids) {
  #FINDCLOSESTCENTROIDS computes the centroid memberships for every example
  #   idx <- FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
  #   in idx for a dataset X where each row is a single example. idx = m x 1
  #   vector of centroid assignments (i.e. each entry in range [1..K])
  #
  
  # Set K
  K <- dim(centroids)[1]
  
  # You need to return the following variables correctly.
  idx <- rep(0,dim(X)[1])
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Go over every example, find its closest centroid, and store
  #               the index inside idx at the appropriate location.
  #               Concretely, idx[i] should contain the index of the centroid
  #               closest to example i. Hence, it should be a value in the
  #               range 1..K
  #
  # Note: You can use a for-loop over the examples to compute this.
  #
  N <- dim(X)[2]
  m <- dim(X)[1]
  
  dist <- rep(0,K)
  a <- rep(0,N)
  
  for (i in 1:m) {
    for (k in 1:K) {
      for (n in 1:N)	{
        a[n] <- (X[i,n] - centroids[k,n]) ^ 2	# Calc distance from X to centroids (sum to N, not just 2)
      }
      dist[k] <- sum(a);		# Distance from point X to centroids
    }
    c <- which.min(dist)		# Find the index of the min distance btw X and centroids
    idx[i] <- c;				# Assign for each X which centroid it belongs to
  }
  idx
  
  # --------------------------------------------------------------
}
