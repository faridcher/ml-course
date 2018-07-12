plotDecisionBoundary <-
  function (theta, X, y, axLables = c("Exam 1 score","Exam 2 score"), legLabels =
              c('Admitted', 'Not admitted')) {
    #   PLOTDECISIONBOUNDARY Plots the data points X and y into a new figure with
    #   the decision boundary defined by theta
    #   PLOTDECISIONBOUNDARY(theta, X,y) plots the data points with + for the
    #   positive examples and o for the negative examples. X is assumed to be
    #   a either
    #   1) Mx3 matrix, where the first column is an all-ones column for the
    #      intercept.
    #   2) MxN, N>3 matrix, where the first column is all-ones
    
    # Plot Data
    plotData(X[,2:3], y,axLables,legLabels)
    
    if (dim(X)[2] <= 3)
    {
      # Only need 2 points to define a line, so choose two end points
      plot_x <- cbind(min(X[,2] - 2), max(X[,2] + 2))
      # Calculate the decision boundary line
      plot_y <- -1 / theta[3] * (theta[2] * plot_x + theta[1])
      
      # Plot, and adjust axes for better viewing
      lines(plot_x, plot_y, col = "blue")
      
    }
    else
    {
      # Here is the grid range
      u <- seq(-1,1.5, length.out = 50)
      v <- seq(-1,1.5, length.out = 50)
      
      z <- matrix(0, length(u), length(v))
      # Evaluate z <- theta*x over the grid
      for (i in 1:length(u))
        for (j in 1:length(v))
          z[i,j] <- mapFeature(u[i], v[j]) %*% theta
      
      # Notice you need to specify the range [0, 0]
      contour(
        u, v, z, xlab = 'Microchip Test 1', ylab = 'Microchip Test 2',
        levels = 0, lwd = 2, add = TRUE, drawlabels = FALSE, col = "green"
      )
      mtext(paste("lambda = ",lambda), 3)
    }
  }
