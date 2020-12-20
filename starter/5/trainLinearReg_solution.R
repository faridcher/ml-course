trainLinearReg <- function(X, y, lambda) {
  #TRAINLINEARREG Trains linear regression given a dataset (X, y) and a
  #regularization parameter lambda
  #   theta <- TRAINLINEARREG (X, y, lambda) trains linear regression using
  #   the dataset (X, y) and regularization parameter lambda. Returns the
  #   trained parameters theta.
  #
  
  # Initialize Theta
  if (class(X) == "numeric")
    X <- t(X)
  
  initial_theta <- rep(0,dim(X)[2])
  
  # pars <- lbfgsb3_(initial_theta, fn= linearRegCostFunction(X,y,lambda), gr=linearRegGradFunction(X,y,lambda),
  #          control = list(trace=1,maxit=200))$prm
  
  optimRes <-
    optim(
      par = initial_theta, fn = linearRegCostFunction(X,y,lambda), gr = linearRegGradFunction(X,y,lambda),
      method = "BFGS"
    )

  optimRes$par
}
