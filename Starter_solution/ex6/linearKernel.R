linearKernel  <- function(x1, x2) {
  #LINEARKERNEL returns a linear kernel between x1 and x2
  #   sim <- linearKernel(x1, x2) returns a linear kernel between x1 and x2
  #   and returns the value in sim
  
  # Ensure that x1 and x2 are column vectors
  x1 <- c(x1)
  x2 <- c(x2)
  
  # Compute the kernel
  sim <- t(x1) %*% x2
  sim
}