validationCurve <- function(X, y, Xval, yval) {
  #VALIDATIONCURVE Generate the train and validation errors needed to
  #plot a validation curve that we can use to select lambda
  #   [lambda_vec, error_train, error_val] <- ...
  #       VALIDATIONCURVE(X, y, Xval, yval) returns the train
  #       and validation errors (in error_train, error_val)
  #       for different values of lambda. You are given the training set (X,
  #       y) and validation set (Xval, yval).
  #
  
  # Selected values of lambda (you should not change this)
  lambda_vec <- c(0, 0.001, 0.003, 0.01, 0.03, 0.1, 0.3, 1, 3, 10)
  
  # You need to return these variables correctly.
  error_train <- rep(0, length(lambda_vec))
  error_val <- rep(0,length(lambda_vec))
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Fill in this function to return training errors in
  #               error_train and the validation errors in error_val. The
  #               vector lambda_vec contains the different lambda parameters
  #               to use for each calculation of the errors, i.e,
  #               error_train[i], and error_val[i] should give
  #               you the errors obtained after training with
  #               lambda <- lambda_vec[i]
  #
  # Note: You can loop over lambda_vec with the following:
  #
  #       for (i in 1:length(lambda_vec)) {
  #           lambda <- lambda_vec[i]
  #           # Compute train / val errors when training linear
  #           # regression with regularization parameter lambda
  #           # You should store the result in error_train[i]
  #           # and error_val[i]
  #           ....
  #
  #       }
  #
  #
  
  for (i in 1:length(lambda_vec)) {
    lambda <- lambda_vec[i]
    theta <- trainLinearReg(X, y, lambda)
    
    # Set to zero when calculating error since already been trained
    lambda <- 0
    # We are calc J as error not as cost. So, lambda should not be included when
    # calculating error for thetas that have been trained, else it will be biased
    # Refer to 2.1 of Exercise 5, error is computed without lambda
    e_train <- linearRegCostFunction(X, y, lambda)(theta)
    e_val <- linearRegCostFunction(Xval, yval, lambda)(theta)	# J over all CV set for new set of theta
    
    # Accumulating error from i=1:m
    if (i == 1)
    {
      error_train <- e_train
      error_val <- e_val
    }
    else
    {
      error_train <- rbind(error_train, e_train)
      error_val <- rbind(error_val, e_val)
    }
  }
  
  list(lambda_vec = lambda_vec, error_train = error_train, error_val = error_val)
  # ----------------------------------------------------------------------------
}
