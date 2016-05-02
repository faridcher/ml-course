plotProgresskMeans <- function (X, centroids, previous, idx, K, i) {
  #PLOTPROGRESSKMEANS is a helper function that displays the progress of
  #k-Means as it is running. It is intended for use only with 2D data.
  #   PLOTPROGRESSKMEANS(X, centroids, previous, idx, K, i) plots the data
  #   points with colors assigned to each centroid. With the previous
  #   centroids, it also plots a line between the previous locations and
  #   current locations of the centroids.
  #
  
  # Setup the plot
  plot(X,type = "n")
  title(main = sprintf('Iteration number %d',i))
  
  # Plot the examples
  plotDataPoints(X, idx, K)
  
  # Plot the centroids as black x's
  points(centroids,pch = 4,lwd = 2)
  
  # Plot the history of the centroids with lines
  for (q in 2:dim(previous)[3]) #num of centriods so far
  {
    if (all(previous[,,q] == 0))
      break
    else
      for (j in 1:dim(centroids)[1])
        #num of centroids 3
        lines(rbind(previous[j,,q - 1], previous[j,,q]),lwd = 1.3)
  }
}
