nnCostFunction  <-
  function(input_layer_size, hidden_layer_size, num_labels,X, y, lambda) {
    #NNCOSTFUNCTION Implements the neural network cost function for a two layer
    #neural network which performs classification
    #   J <- NNCOSTFUNCTON(hidden_layer_size, num_labels, ...
    #   X, y, lambda)(nn_params) computes the cost of the neural network. The
    #   parameters for the neural network are "unrolled" into the vector
    #   nn_params and need to be converted back into the weight matrices.
    #
    
    function(nn_params) {
      # Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
      # for our 2 layer neural network
      Theta1 <-
        matrix(nn_params[1:(hidden_layer_size * (input_layer_size + 1))],
               hidden_layer_size, (input_layer_size + 1))
      
      Theta2 <-
        matrix(nn_params[(1 + (hidden_layer_size * (input_layer_size + 1))):length(nn_params)],
               num_labels, (hidden_layer_size + 1))
      
      # Setup some useful variables
      m <- dim(X)[1]
      
      # You need to return the following variable correctly
      J <- 0
      
      # ----------------------- YOUR CODE HERE -----------------------
      # Instructions: You should complete the code by working through the
      #               following parts.
      #
      # Part 1: Feedforward the neural network and return the cost in the
      #         variable J. After implementing Part 1, you can verify that your
      #         cost function computation is correct by verifying the cost
      #         computed in ex4.R
      #
      # Part 2: Implement regularization with the cost function.
      #
      #
      
      # recode y to Y
      I <- diag(num_labels)
      Y <- matrix(0, m, num_labels)
      for (i in 1:m)
        Y[i,] <- I[y[i],]
      
      
      # feedforward
      a1 <- cbind(rep(1,m),X)
      z2 <- a1 %*% t(Theta1)
      a2 <- cbind(rep(1,dim(z2)[1]), sigmoid(z2))
      z3 <- a2 %*% t(Theta2)
      a3 <- sigmoid(z3)
      h <- a3
      
      # calculte penalty
      p <- sum(Theta1[,-1] ^ 2) + sum(Theta2[,-1] ^ 2)
      
      # calculate Cost
      J <-
        sum((-Y) * log(h) - (1 - Y) * log(1 - h)) / m + lambda * p / (2 * m)
      
      J
    }
  }

nnGradFunction  <-
  function(input_layer_size, hidden_layer_size, num_labels,
           X, y, lambda) {
    #nnGradFunction Implements the neural network gradient function for a two layer
    #neural network which performs classification
    #   grad <- nnGradFunction(hidden_layer_size, num_labels, ...
    #   X, y, lambda)(nn_params) computes the gradient of the neural network. The
    #   parameters for the neural network are "unrolled" into the vector
    #   nn_params and need to be converted back into the weight matrices.
    #
    #   The returned parameter grad should be a "unrolled" vector of the
    #   partial derivatives of the neural network.
    #
    function(nn_params) {
      # Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
      # for our 2 layer neural network
      Theta1 <-
        matrix(nn_params[1:(hidden_layer_size * (input_layer_size + 1))],
               hidden_layer_size, (input_layer_size + 1))
      
      Theta2 <-
        matrix(nn_params[(1 + (hidden_layer_size * (input_layer_size + 1))):length(nn_params)],
               num_labels, (hidden_layer_size + 1))
      
      # Setup some useful variables
      m <- dim(X)[1]
      
      # You need to return the following variables correctly
      Theta1_grad <- matrix(0,dim(Theta1)[1],dim(Theta1)[2])
      Theta2_grad <- matrix(0,dim(Theta2)[1],dim(Theta2)[2])
      
      # ----------------------- YOUR CODE HERE -----------------------
      # Instructions: You should complete the code by working through the
      #               following parts.
      #
      # Part 1: Feedforward the neural network
      #
      # Part 2: Implement the backpropagation algorithm to compute the gradients
      #         Theta1_grad and Theta2_grad. You should return the partial derivatives of
      #         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
      #         Theta2_grad, respectively. After implementing Part 2, you can check
      #         that your implementation is correct by running checkNNGradients
      #
      #         Note: The vector y passed into the function is a vector of labels
      #               containing values from 1..K. You need to map this vector into a
      #               binary vector of 1's and 0's to be used with the neural network
      #               cost function.
      #
      #         Hint: We recommend implementing backpropagation using a for-loop
      #               over the training examples if you are implementing it for the
      #               first time.
      #
      # Part 3: Implement regularization with the gradients.
      #
      #         Hint: You can implement this around the code for
      #               backpropagation. That is, you can compute the gradients for
      #               the regularization separately and then add them to Theta1_grad
      #               and Theta2_grad from Part 2.
      #
      
      # recode y to Y
      I <- diag(num_labels)
      Y <- matrix(0, m, num_labels)
      for (i in 1:m)
        Y[i,] <- I[y[i],]
      
      
      # feedforward
      a1 <- cbind(rep(1,m),X)
      z2 <- a1 %*% t(Theta1)
      a2 <- cbind(rep(1,dim(z2)[1]), sigmoid(z2))
      z3 <- a2 %*% t(Theta2)
      a3 <- sigmoid(z3)
      h <- a3
      
      # calculate sigmas
      sigma3 <- h - Y
      sigma2 <-
        (sigma3 %*% Theta2) * sigmoidGradient(cbind(rep(1,dim(z2)[1]),z2))
      sigma2 <- sigma2[,-1]
      
      # accumulate gradients
      delta_1 <- (t(sigma2) %*% a1)
      delta_2 <- (t(sigma3) %*% a2)
      
      # calculate regularized gradient
      p1 <- (lambda / m) * cbind(rep(0,dim(Theta1)[1]), Theta1[,-1])
      p2 <- (lambda / m) * cbind(rep(0,dim(Theta2)[1]), Theta2[,-1])
      Theta1_grad <- delta_1 / m + p1
      Theta2_grad <- delta_2 / m + p2
      
      # Unroll gradients
      grad <-  c(c(Theta1_grad), c(Theta2_grad))
      grad
      # -------------------------------------------------------------
    }
  }