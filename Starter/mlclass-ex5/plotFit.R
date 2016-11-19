plotFit <- function (min_x, max_x, mu, sigma, theta, p) {
  #PLOTFIT Plots a learned polynomial regression fit over an existing figure.
  #Also works with linear regression.
  #   PLOTFIT(min_x, max_x, mu, sigma, theta, p) plots the learned polynomial
  #   fit with power p and feature normalization (mu, sigma).
  
  # We plot a range slightly bigger than the min and max values to get
  # an idea of how the fit will vary outside the range of the data points
  x <- seq(min_x - 15, max_x + 25, 0.05)
  
  # Map the X values
  X_poly <- polyFeatures(x, p)
  X_poly <- matrix(mapply(`-`,t(X_poly),mu),dim(X_poly) ,byrow = TRUE)
  X_poly <-
    matrix(mapply(`/`,t(X_poly),sigma),dim(X_poly) ,byrow = TRUE)
  
  
  # Add ones
  X_poly <-  cbind(rep(1,dim(X_poly)[1]), X_poly)
  
  # Plot
  plot(
    x, X_poly %*% theta, lwd = 2,type = 'l', lty = 2, col = "blue",
    xlab = "change in water level (x)", ylab = "water flowing out of the dam (y)",
    main = sprintf('Polynomial Regression Fit\n (lambda = %f)', lambda)
  )
  
}
