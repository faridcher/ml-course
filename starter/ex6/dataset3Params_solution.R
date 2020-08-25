dataset3Params <- function(X, y, Xval, yval) {
  #EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
  #where you select the optimal (C, sigma) learning parameters to use for SVM
  #with RBF kernel
  #   C_sigma <- EX6PARAMS(X, y, Xval, yval) returns your choice of C and
  #   sigma. You should complete this function to return the optimal C and
  #   sigma based on a cross-validation set.
  #
  
  # You need to return the following variables correctly.
  C <- 1
  sigma <- 0.3
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Fill in this function to return the optimal C and sigma
  #               learning parameters found using the cross validation set.
  #               You can use svmPredict to predict the labels on the cross
  #               validation set. For example,
  #                   predictions <- svmPredict(model, Xval)
  #               will return the predictions on the cross validation set.
  #
  #  Note: You can compute the prediction error using
  #        mean(predictions != yval)
  #
  C_try <-    c(0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30)
  sigma_try <- c(0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30)
  error <- rep(0,length(sigma_try))
  
  for (i in 1:length(C_try)) {
    C <- C_try[i]
    for (j in 1:length(sigma_try))
    {
      sigma <- sigma_try[j]
      model <- svmTrain(X, y, C, gaussianKernel(sigma))
      predictions <- svmPredict(model,Xval)
      
      error[j] <- mean(predictions != yval)
      
      # Accumulating error from i <- 1:m
      if (j == 1)
        error_j <- error[j]
      else
        error_j <- rbind(error_j, error[j])
    }
    
    if (i == 1)
      error_i <- error_j
    else
      error_i <- cbind(error_i, error_j)
  }
  
  # Display the error_i in matrix
  print(error_i)
  
  # Locate the index of the minimum value in matrix error_i
  rowcol <- which(error_i == min(error_i),arr.ind = TRUE)
  # Optimum C and sigma are identified from the matrix above
  C <- C_try[rowcol[2]]
  sigma <- sigma_try[rowcol[1]]
  
  list(C=C, sigma = sigma)
  # --------------------------------------------------------------------------
  
}
