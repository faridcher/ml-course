svmPredict <- function(model, X) {
  #SVMPREDICT returns a vector of predictions using a trained SVM model
  #(svmTrain).
  #   pred <- SVMPREDICT(model, X) returns a vector of predictions using a
  #   trained SVM model (svmTrain). X is a mxn matrix where there each
  #   example is a row. model is a svm model returned from svmTrain.
  #   predictions pred is a m x 1 column of predictions of {0, 1} values.
  #
  
  # Check if we are getting a column vector, if so, then assume that we only
  # need to do prediction for a single example
  if (is.vector(X))
    X <- as.matrix(X)
  
  if (dim(X)[2] == 1)
    # Examples should be in rows
    X <- t(X)
  
  
  # Dataset
  m <- dim(X)[1]
  p <- rep(0,m)
  pred <- rep(0,m)
  
  if (grepl('linearKernel' , model$kernelFunctionName))
    # We can use the weights and bias directly if working with the
    # linear kernel
    p <- X %*% model$w + model$b
  else if (grepl('gaussianKernel' , model$kernelFunctionName)) {
    # Vectorized RBF Kernel
    # This is equivalent to computing the kernel on every pair of examples
    X1 <- apply(X ^ 2,1,sum) #row sum
    X2 <- t(apply(model$X ^ 2,1,sum))
    K <- bsxfun("+", X1, bsxfun("+", X2,-2 * X %*% t(model$X)))
    K <- model$kernelFunction(1, 0) ^ K
    K <- bsxfun("*", t(model$y), K)
    K <- bsxfun("*", t(model$alphas), K)
    p <- apply(K,1,sum) #row sum
  }
  else
  {
    # Other Non-linear kernel
    for (i in 1:m) {
      prediction <- 0
      for (j in 1:dim(model$X)[1]) {
        prediction <- prediction + model$alphas[j] * model.y[j] *
          model$kernelFunction(t(X[i,]), t(model$X[j,]))
      }
      p[i] <- prediction + model$b
    }
  }
  
  # Convert predictions into 0 / 1
  pred[p >= 0] <- 1
  pred[p < 0] <- 0
  
  pred
}
