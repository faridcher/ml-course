gaussianKernel <- function(sigma) {
  #RBFKERNEL returns a radial basis function kernel between x1 and x2
  #   sim <- gaussianKernel(sigma) returns a gaussian kernel function between x1 and x2
  #   and gaussianKernel(sigma)(x1, x2) returns the value in sim
  function(x1, x2) {
    # Ensure that x1 and x2 are column vectors
    x1 <- c(x1)
    x2 <- c(x2)
    
    # You need to return the following variables correctly.
    sim <- 0
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Fill in this function to return the similarity between x1
    #               and x2 computed using a Gaussian kernel with bandwidth
    #               sigma
    #
    #
    sim <- exp(-(sum((x1 - x2) ^ 2)) / (2 * sigma ^ 2))
    sim
  }
  # --------------------------------------------------------------
  
}
