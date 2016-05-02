randInitializeWeights <- function(L_in, L_out) {
  #RANDINITIALIZEWEIGHTS Randomly initialize the weights of a layer with L_in
  #incoming connections and L_out outgoing connections
  #   W <- RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights
  #   of a layer with L_in incoming connections and L_out outgoing
  #   connections.
  #
  #   Note that W should be set to a matrix of size (L_out, 1 + L_in) as
  #   the first row of W handles the "bias" terms
  #
  
  # You need to return the following variables correctly
  W <- matrix(0,L_out, 1 + L_in)
  
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Initialize W randomly so that we break the symmetry while
  #               training the neural network.
  #
  # Note: The first row of W corresponds to the parameters for the bias units
  #
  
  epsilon_init <- 0.12
  
  rnd <- runif(L_out * (1 + L_in))
  rnd <- matrix(rnd,L_out,1 + L_in)
  W <- rnd * 2 * epsilon_init - epsilon_init
  W
  # --------------------------------------------------------------------------
  
}
