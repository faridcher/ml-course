visualizeFit <- function (X, mu, sigma2) {
  #VISUALIZEFIT Visualize the dataset and its estimated distribution.
  #   VISUALIZEFIT(X, p, mu, sigma2) This visualization shows you the
  #   probability density function of the Gaussian distribution. Each example
  #   has a location (x1, x2) that depends on its feature values.
  #
  
  XY <- seq(0,35,.5)
  
  mg <- meshgrid(XY, XY)
  X1 <- mg$X
  X2 <- mg$Y
  
  X1 <- matrix(X1, length(X1), 1)
  X2 <- matrix(X2, length(X2), 1)
  
  Z <- multivariateGaussian(cbind(X1,X2),mu,sigma2)
  Z <- matrix(Z,length(XY),length(XY))
  
  
  plot(
    X[,1], X[,2], xlim = c(0,30),ylim = c(0,30), pch = 4, col = "blue",
    xlab = 'Latency (ms)', ylab = 'Throughput (mb/s)'
  )
  
  # Do not plot if there are infinities
  if (sum(is.infinite(Z)) == 0)
    contour(
      XY, XY, Z, levels = 10 ^ t(seq(-20,0,3)) ,add = TRUE, drawlabels = FALSE
    )
  
}