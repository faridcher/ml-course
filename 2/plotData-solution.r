plotData <- function (X, y, axLables = c("Exam 1 score","Exam 2 score"), 
                      legLabels = c('Admitted', 'Not admitted')) {
    #PLOTDATA Plots the data points X and y into a new device
    #   PLOTDATA(x,y) plots the data points with + for the positive examples
    #   and o for the negative examples. X is assumed to be a Mx2 matrix.
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Plot the positive and negative examples on a
    #               2D plot, using the option pch=3 for the positive (plus)
    #               examples and pch=21 for the negative (circle) examples.
    #
    # plus and empty circle character codes

    symbolss <- c(3,21) 
    yfac <- factor(y)
    plot(X[,1], X[,2], pch = symbolss[yfac], bg = "yellow", lwd = 1.3,
      xlab = axLables[1], ylab = axLables[2])
    
    legend("topright", legLabels, pch = rev(symbolss), pt.bg = "yellow")
    # ----------------------------------------------------
}
