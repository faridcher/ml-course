plotData <- function (X, y) {
  #PLOTDATA Plots the data points X and y into a new figure
  #   PLOTDATA(x,y) plots the data points with + for the positive examples
  #   and o for the negative examples. X is assumed to be a Mx2 matrix.
  #
  # Note: This was slightly modified such that it expects y <- 1 or y <- 0
  
  # Find Indices of Positive and Negative Examples
  symbolss <- c(21,3) #plus and fillded circle
  yfac <- factor(y)
  plot(X[,1],X[,2], pch = symbolss[yfac] ,bg = "yellow", lwd = 1.3)
  
}
