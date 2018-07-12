plotDataPoints <- function (X, idx, K, addto = TRUE) {
  #PLOTDATAPOINTS plots data points in X, coloring them so that those with the same
  #index assignments in idx have the same color
  #   PLOTDATAPOINTS(X, idx, K) plots data points in X, coloring them so that those
  #   with the same index assignments in idx have the same color
  #
  
  if (addto)
    points(X, col = rainbow(K + 1)[idx], lwd = 1.3)
  else
    plot(
      X, col = rainbow(K + 1)[idx], lwd = 1.3, type = "p"
    )
  
}
