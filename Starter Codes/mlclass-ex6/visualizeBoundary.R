visualizeBoundary <- function (X, y, model, varargin) {
  #VISUALIZEBOUNDARY plots a non-linear decision boundary learned by the SVM
  #   VISUALIZEBOUNDARYLINEAR(X, y, model) plots a non-linear decision
  #   boundary learned by the SVM and overlays the data on it
  
  # Plot the training data on top of the boundary
  plotData(X, y)
  
  # Make classification predictions over a grid of values
  x1plot <- t(seq(min(X[,1]) , max(X[,1]), length.out = 100))
  x2plot <- t(seq(min(X[,2]) , max(X[,2]), length.out = 100))
  
  mg <- meshgrid(x1plot, x2plot)
  X1 <- mg$X
  X2 <- mg$Y
  vals <- matrix(0,length(x1plot),length(x2plot))
  
  for (i in 1:dim(X1)[2]) {
    this_X <- cbind(X1[,i], X2[,i])
    vals[,i] <- svmPredict(model, this_X)
  }
  
  # Plot the SVM boundary
  contour(
    x1plot,x2plot, t(vals),
    levels = 1, col = "blue",add = TRUE
  )
  
}
