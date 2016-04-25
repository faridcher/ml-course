plotData <- function (x, y) {
  #PLOTDATA Plots the data points x and y into a new figure
  #   PLOTDATA(x,y) plots the data points and gives the figure axes labels of
  #   population and profit.
  
  # ---------------------- YOUR CODE HERE ----------------------
  # Instructions: Plot the training data into a figure using the
  #               "figure" and "plot" commands. Set the axes labels using
  #               the "xlabel" and "ylabel" commands. Assume the
  #               population and revenue data have been passed in
  #               as the x and y arguments of this function.
  #
  # Hint: You can use the 'rx' option with plot to have the markers
  #       appear as red crosses. Furthermore, you can make the
  #       markers larger by using plot(..., 'rx', 'MarkerSize', 10)
  
  plot(
    x, y, col = "red", pch = 4,cex = 1.1,lwd = 2,
    xlab = 'Profit in $10,000s',
    ylab = 'Population of City in 10,000s'
  )
  
  # ------------------------------------------------------------
  
}
