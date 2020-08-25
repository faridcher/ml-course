visualizeBoundaryLinear <- function (X, y, model) {
  #VISUALIZEBOUNDARYLINEAR plots a linear decision boundary learned by the
  #SVM
  #   VISUALIZEBOUNDARYLINEAR(X, y, model) plots a linear decision boundary
  #   learned by the SVM and overlays the data on it
  
  w <- model$w
  b <- model$b
  xp <- seq(min(X[,1]),max(X[,1]),length.out = 100)
  
  yp <- -(w[1] * xp + b) / w[2]
  plotData(X, y)
  
  lines(xp, yp, col = "blue")
  
}
