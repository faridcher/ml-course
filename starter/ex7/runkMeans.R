runkMeans  <- function(X, initial_centroids,
                       max_iters, plot_progress = FALSE) {
  #RUNKMEANS runs the K-Means algorithm on data matrix X, where each row of X
  #is a single example
  #   centroids_idx <- RUNKMEANS(X, initial_centroids, max_iters, ...
  #   plot_progress) runs the K-Means algorithm on data matrix X, where each
  #   row of X is a single example. It uses initial_centroids used as the
  #   initial centroids. max_iters specifies the total number of interactions
  #   of K-Means to execute. plot_progress is a true/false flag that
  #   indicates if the function should also plot its progress as the
  #   learning happens. This is set to false by default. runkMeans returns
  #   centroids, a Kxn matrix of the computed centroids and idx, a m x 1
  #   vector of centroid assignments (i.e. each entry in range [1..K])
  #
  
  # Initialize values
  m <- dim(X)[1]
  n <- dim(X)[2]
  K <- dim(initial_centroids)[1]
  centroids <- initial_centroids
  previous_centroids <- array(0,dim = c(dim(centroids),max_iters + 1))
  previous_centroids[,,1] <- centroids
  idx <- rep(0,m)
  
  # Run K-Means
  for (i in 1:max_iters) {
    # Output progress
    cat(sprintf('K-Means iteration %d/%d...\n', i, max_iters))
    
    # For each example in X, assign it to the closest centroid
    idx <- findClosestCentroids(X, centroids)
    
    # Optionally, plot progress here
    if (plot_progress) {
      plotProgresskMeans(X, centroids, previous_centroids, idx, K, i)
      cat(sprintf('Press enter to continue.\n'))
      line <- readLines(con = stdin(),1)
      
    }
    
    # Given the memberships, compute new centroids
    centroids <- computeCentroids(X, idx, K)
    previous_centroids[,,i + 1] <- centroids
  }
  
  list(centroids = centroids, idx = idx)
  
}