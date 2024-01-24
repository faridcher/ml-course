cofiCostFunc <- function(Y, R, num_users, num_movies,
                         num_features, lambda = 0) {
  #COFICOSTFUNC Collaborative filtering cost function
  #   J <- COFICOSTFUNC(Y, R, num_users, num_movies, ...
  #   num_features, lambda)(params) returns the cost for the
  #   collaborative filtering problem.
  #
  function(params) {
    # Unfold the U and W matrices from params
    X <-
      matrix(params[1:(num_movies * num_features)], num_movies, num_features)
    Theta <-
      matrix(params[(num_movies * num_features + 1):length(params)],num_users, num_features)
    
    
    # You need to return the following values correctly
    J <- 0
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the cost function for collaborative
    #               filtering. Concretely, you should first implement the cost
    #               function (without regularization) and make sure it
    #               matches our costs. 
    #
    # Notes: X - num_movies  x num_features matrix of movie features
    #        Theta - num_users  x num_features matrix of user features
    #        Y - num_movies x num_users matrix of user ratings of movies
    #        R - num_movies x num_users matrix, where R(i, j) <- 1 if the
    #            i-th movie was rated by the j-th user
    
    
    J
    
    # --------------------------------------------------------------
  }
}

cofiGradFunc <- function(Y, R, num_users, num_movies,
                         num_features, lambda = 0) {
  #cofiGradFunc returns the gradient for the
  #   collaborative filtering problem.
  function(params) {
    # Unfold the U and W matrices from params
    X <-
      matrix(params[1:(num_movies * num_features)], num_movies, num_features)
    Theta <-
      matrix(params[(num_movies * num_features + 1):length(params)],
             num_users, num_features)
    
    
    # You need to return the following values correctly
    X_grad <- matrix(0,dim(X)[1],dim(X)[2])
    Theta_grad <- matrix(0, dim(Theta)[1], dim(Theta)[2])
    
    # ----------------------- YOUR CODE HERE -----------------------
    # Instructions: Compute the gradient for collaborative
    #               filtering. you should implement the
    #               gradient and use the checkCostFunction routine to check
    #               that the gradient is correct. Finally, you should implement
    #               regularization.
    #
    # Notes: X - num_movies  x num_features matrix of movie features
    #        Theta - num_users  x num_features matrix of user features
    #        Y - num_movies x num_users matrix of user ratings of movies
    #        R - num_movies x num_users matrix, where R[i, j] <- 1 if the
    #            i-th movie was rated by the j-th user
    #
    # You should set the following variables correctly:
    #
    #        X_grad - num_movies x num_features matrix, containing the
    #                 partial derivatives w.r.t. to each element of X
    #        Theta_grad - num_users x num_features matrix, containing the
    #                     partial derivatives w.r.t. to each element of Theta
    #
    
    
    grad
    # --------------------------------------------------------------
  }
}