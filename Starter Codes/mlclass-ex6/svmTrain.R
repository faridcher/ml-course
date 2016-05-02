svmTrain  <-
  function(X, Y, C, kernelFunction, tol = 1e-3, max_passes = 5) {
    #SVMTRAIN Trains an SVM classifier using a simplified version of the SMO
    #algorithm.
    #   model <- SVMTRAIN(X, Y, C, kernelFunction, tol, max_passes) trains an
    #   SVM classifier and returns trained model. X is the matrix of training
    #   examples.  Each row is a training example, and the jth column holds the
    #   jth feature.  Y is a column matrix containing 1 for positive examples
    #   and 0 for negative examples.  C is the standard SVM regularization
    #   parameter.  tol is a tolerance value used for determining equality of
    #   floating point numbers. max_passes controls the number of iterations
    #   over the dataset (without changes to alpha) before the algorithm quits.
    #
    # Note: This is a simplified version of the SMO algorithm for training
    #       SVMs. In practice, if you want to train an SVM classifier, we
    #       recommend using an optimized package such as:
    #
    #           LIBSVM   (http://www.csie.ntu.edu.tw/~cjlin/libsvm/)
    #           SVMLight (http://svmlight.joachims.org/)
    #
    #
    
    # Data parameters
    m <- dim(X)[1]
    n <- dim(X)[2]
    
    # Map 0 to -1
    Y[Y == 0] <- -1
    
    # Variables
    alphas <- rep(0,m)
    b <- 0
    E <- rep(0,m)
    passes <- 0
    eta <- 0
    L <- 0
    H <- 0
    
    # Pre-compute the Kernel Matrix since our dataset is small
    # (in practice, optimized SVM packages that handle large datasets
    #  gracefully will _not_ do this)
    #
    # We have implemented optimized vectorized version of the Kernels here so
    # that the svm training will run faster.
    if (deparse(substitute(kernelFunction)) == 'linearKernel')
      # Vectorized computation for the Linear Kernel
      # This is equivalent to computing the kernel on every pair of examples
      K <- X %*% t(X)
    else if (grepl('gaussianKernel' , deparse(substitute(kernelFunction)))) {
      # Vectorized RBF Kernel
      # This is equivalent to computing the kernel on every pair of examples
      X2 <- apply(X ^ 2,1,sum) #row sum
      K <- bsxfun("+", X2, bsxfun("+", t(X2),-2 * (X %*% t(X))))
      K <- kernelFunction(1, 0) ^ K
    }
    else {
      # Pre-compute the Kernel Matrix
      # The following can be slow due to the lack of vectorization
      K <- zeros(m)
      for (i in 1:m) {
        for (i in i:m) {
          k[i,j] <- kernelFunction(t(X[i,]), t(x[j,]))
          k[j,i] <- k[i,j] #the matrix is symmetric
        }
      }
    }
    # Train
    cat(sprintf('\nTraining ...'))
    dots <- 12
    while (passes < max_passes)
    {
      num_changed_alphas <- 0
      for (i in 1:m) {
        # Calculate Ei <- f(x[i]) - Y[i] using (2).
        # E[i] <- b + sum (X(i, :) * (repmat(alphas.*Y,1,n).*X)') - Y[i]
        E[i] <- b + sum (alphas * Y * K[,i]) - Y[i]
        
        if ((Y[i] * E[i] < -tol &&
             alphas[i] < C) || (Y[i] * E[i] > tol && alphas[i] > 0))
        {
          # In practice, there are many heuristics one can use to select
          # the i and j. In this simplified code, we select them randomly.
          j <- ceiling(m * runif(1))
          while (j == i)
            # Make sure i \neq j
            j <- ceiling(m * runif(1))
          
          
          # Calculate Ej <- f(x[j]) - Y[j] using (2).
          E[j] <- b + sum(alphas * Y * K[,j]) - Y[j]
          
          # Save old alphas
          alpha_i_old <- alphas[i]
          alpha_j_old <- alphas[j]
          
          # Compute L and H by (10) or (11).
          if (Y[i] == Y[j])
          {
            L <- max(0, alphas[j] + alphas[i] - C)
            H <- min(C, alphas[j] + alphas[i])
          }
          else
          {
            L <- max(0, alphas[j] - alphas[i])
            H <- min(C, C + alphas[j] - alphas[i])
          }
          
          if (L == H)
            # continue to next i.
            next
          
          # Compute eta by (14).
          eta <- 2 * K[i,j] - K[i,i] - K[j,j]
          if (eta >= 0)
            # continue to next i.
            next
          
          
          # Compute and clip new value for alpha j using (12) and (15).
          alphas[j] <- alphas[j] - (Y[j] * (E[i] - E[j])) / eta
          
          # Clip
          alphas[j] <- min (H, alphas[j])
          alphas[j] <- max (L, alphas[j])
          
          # Check if change in alpha is significant
          if (abs(alphas[j] - alpha_j_old) < tol)
          {
            # continue to next i.
            # replace anyway
            alphas[j] <- alpha_j_old
            next
          }
          
          # Determine value for alpha i using (16).
          alphas[i] <-
            alphas[i] + Y[i] * Y[j] * (alpha_j_old - alphas[j])
          
          # Compute b1 and b2 using (17) and (18) respectively.
          b1 <- b - E[i]
          - Y[i] * (alphas[i] - alpha_i_old) *  t(K[i,j])
          - Y[j] * (alphas[j] - alpha_j_old) *  t(K[i,j])
          b2 <- b - E[j]
          - Y[i] * (alphas[i] - alpha_i_old) *  t(K[i,j])
          - Y[j] * (alphas[j] - alpha_j_old) *  t(K[j,j])
          
          # Compute b by (19).
          if (0 < alphas[i] && alphas[i] < C)
            b <- b1
          else if (0 < alphas[j] && alphas[j] < C)
            b <- b2
          else
            b <- (b1 + b2) / 2
          
          num_changed_alphas <- num_changed_alphas + 1
        }
      }
      
      if (num_changed_alphas == 0)
        passes <- passes + 1
      else
        passes <- 0
      
      cat(sprintf('.'))
      dots <- dots + 1
      if (dots > 78)
      {
        dots <- 0
        cat(sprintf('\n'))
      }
      
    }
    cat(sprintf(' Done! \n\n'))
    
    # Save the model
    idx <- alphas > 0
    model <- list()
    model$X <- X[idx,]
    model$y <- Y[idx]
    model$kernelFunction <- kernelFunction
    model$kernelFunctionName <- deparse(substitute(kernelFunction))
    model$b <- b
    model$alphas <- alphas[idx]
    model$w <- t(t(alphas * Y) %*% X)
    model
    
  }
