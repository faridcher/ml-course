plotDataPoints <- function (X, idx, K, addto = TRUE) {
  #PLOTDATAPOINTS plots data points in X, coloring them so that those with the same
  #index assignments in idx have the same color
  #   PLOTDATAPOINTS(X, idx, K) plots data points in X, coloring them so that those
  #   with the same index assignments in idx have the same color
  #
  
  if (addto)
    points(X, col = rainbow(K + 1)[idx], lwd = 1.3)
  else{
    par(mar=c(3,3,2,1), mgp=c(1.5,.5,0))
    plot(X, col = rainbow(K + 1)[idx], lwd = 1.3)
  }
  
}
