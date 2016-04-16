plotData <-
  function (X, y, axLables = c("Exam 1 score","Exam 2 score"), legLabels =
              c('Admitted', 'Not admitted')) {
    #PLOTDATA Plots the data points X and y into a new figure
    #   PLOTDATA(x,y) plots the data points with + for the positive examples
    #   and o for the negative examples. X is assumed to be a Mx2 matrix.
    
    # Create New Figure
    #figure; #hold on
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Plot the positive and negative examples on a
    #               2D plot, using the option 'k+' for the positive
    #               examples and 'ko' for the negative examples.
    #
    
    symbolss <- c(21,3) #plus and fillded circle
    #?points
    yfac <- factor(y)
    
    plot(X[,1],X[,2],type = "n", xaxt = "n", yaxt = "n")
    
    leg <- legend(
      "topright",legLabels, pch = rev(symbolss),
      pt.bg = "yellow", plot = FALSE
    )
    
    #custom ylim. Add the height of legend to upper bound of the range
    yrange <- range(X[,2])
    yrange[2] <- 1.04 * (yrange[2] + leg$rect$h)
    
    
    plot(
      X[,1],X[,2], pch = symbolss[yfac] ,bg = "yellow", lwd = 1.3,
      xlab = axLables[1], ylab = axLables[2],
      ylim = yrange
    )
    
    legend("topright",legLabels,pch = rev(symbolss),
           pt.bg = "yellow")
    # ----------------------------------------------------
}