checkCostFunction <- function (lambda = 0) {
  #CHECKCOSTFUNCTION Creates a collaborative filering problem
  #to check your cost function and gradients
  #   CHECKCOSTFUNCTION(lambda) Creates a collaborative filtering problem
  #   to check your cost function and gradients, it will output the
  #   analytical gradients produced by your code and the numerical gradients
  #   (computed using computeNumericalGradient). These two gradient
  #   computations should result in very similar values.
  
  
  ## Create small problem
  X_t <- matrix(runif(12),4,3)
  Theta_t <- matrix(runif(15),5,3)
  
  dY <- dim(Y)
  
  # Zap out most entries
  Y <- X_t %*% t(Theta_t)
  Y[matrix(runif(dY[1] * dY[2]),dY[1],dY[2]) > 0.5] <- 0
  
  dY <- dim(Y)
  R <- matrix(0,dY[1],dY[2])
  R[Y != 0] <- 1
  
  ## Run Gradient Checking
  
  X <- matrix(rnorm(dim(X_t)[1] * dim(X_t)[2]),dim(X_t)[1],dim(X_t)[2])
  Theta <- matrix(rnorm(dim(Theta_t)[1] * dim(Theta_t)[2]),
                  dim(Theta_t)[1],dim(Theta_t)[2])
  num_users <- dim(Y)[2]
  num_movies <- dim(Y)[1]
  num_features <- dim(Theta_t)[2]
  
  cF <- cofiCostFunc(Y, R, num_users, num_movies, num_features,lambda)
  
  numgrad <-
    computeNumericalGradient(cF , c(c(X),c(Theta)))
  
  cost <- cofiCostFunc(Y, R, num_users,
                       num_movies, num_features, lambda)(c(c(X),c(Theta)))
  
  grad <- cofiGradFunc(Y, R, num_users,
                              num_movies, num_features, lambda)(c(c(X),c(Theta)))
  
  
  print(cbind(numgrad, grad))
  cat(sprintf((
    'The above two columns you get should be very similar.
    (Left-Your Numerical Gradient, Right-Analytical Gradient)\n\n'
  )
  ))
  
  diff <- norm(numgrad - grad,"2") / norm(numgrad + grad,"2")
  
  cat(
    sprintf(
      'If your backpropagation implementation is correct, then
      the relative difference will be small (less than 1e-9). \n
      Relative Difference: %g\n', diff
    )
    )
  
}
