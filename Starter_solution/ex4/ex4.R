## Machine Learning Online Class - Exercise 4 Neural Network Learning

#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  linear exercise. You will need to complete the following functions
#  in this exericse:
#
#     sigmoidGradient.R
#     randInitializeWeights.R
#     nnCostFunction.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("checkNNGradients.R","computeNumericalGradient.R",
             "debugInitializeWeights.R","displayData.R","lbfgsb3_.R",
             "nnCostFunction.R","predict.R","randInitializeWeights.R",
             "sigmoid.R","sigmoidGradient.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## Setup the parameters you will use for this exercise
input_layer_size  <- 400  # 20x20 Input Images of Digits
hidden_layer_size <- 25   # 25 hidden units
num_labels <- 10          # 10 labels, from 1 to 10
                          # (note that we have mapped "0" to label 10)

## ------------- Part 1: Loading and Visualizing Data --------------
#  We start the exercise by first loading and visualizing the dataset.
#  You will be working with a dataset that contains handwritten digits.
#

# Load Training Data
cat(sprintf('Loading and Visualizing Data ...\n'))

load('ex4data1.Rda')
list2env(data,.GlobalEnv)
rm(data)

m <- dim(X)[1]

# Randomly select 100 data points to display
sel <- sample(m)
sel <- sel[1:100]

displayData(X[sel,])

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ----------------- Part 2: Loading Pameters -----------------
# In this part of the exercise, we load some pre-initialized
# neural network parameters.

cat(sprintf('\nLoading Saved Neural Network Parameters ...\n'))

# Load the weights into variables Theta1 and Theta2
load('ex4weights.Rda')
list2env(data,.GlobalEnv)
rm(data)

# Unroll parameters
nn_params <-c(c(Theta1),c(Theta2))

## ----------------- Part 3: Compute Cost (Feedforward) -----------------
#  To the neural network, you should first start by implementing the
#  feedforward part of the neural network that returns the cost only. You
#  should complete the code in nnCostFunction.R to return cost. After
#  implementing the feedforward to compute the cost, you can verify that
#  your implementation is correct by verifying that you get the same cost
#  as us for the fixed debugging parameters.
#
#  We suggest implementing the feedforward cost *without* regularization
#  first so that it will be easier for you to debug. Later, in part 4, you
#  will get to implement the regularized cost.
#
cat(sprintf('\nFeedforward Using Neural Network ...\n'))

# Weight regularization parameter (we set this to 0 here).
lambda <- 0

J <- nnCostFunction(input_layer_size, hidden_layer_size,
                    num_labels, X, y, lambda)(nn_params)

cat(sprintf(('Cost at parameters (loaded from ex4weights): %f 
             \n(this value should be about 0.287629)\n'), J))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## --------------- Part 4: Implement Regularization ---------------
#  Once your cost function implementation is correct, you should now
#  continue to implement the regularization with the cost.
#

cat(sprintf('\nChecking Cost Function (w/ Regularization) ... \n'))

# Weight regularization parameter (we set this to 1 here).
lambda <- 1

J <- nnCostFunction(input_layer_size, hidden_layer_size,
                   num_labels, X, y, lambda)(nn_params)

cat(sprintf('Cost at parameters (loaded from ex4weights): %f
            \n(this value should be about 0.383770)\n', J))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ----------------- Part 5: Sigmoid Gradient  -----------------
#  Before you start implementing the neural network, you will first
#  implement the gradient for the sigmoid function. You should complete the
#  code in the sigmoidGradient.R file.
#

cat(sprintf('\nEvaluating sigmoid gradient...\n'))

g <- sigmoidGradient(c(1, -0.5, 0, 0.5, 1))
cat(sprintf('Sigmoid gradient evaluated at [1 -0.5 0 0.5 1]:\n  '))
cat(sprintf('%f ', g))
cat(sprintf('\n\n'))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ----------------- Part 6: Initializing Pameters -----------------
#  In this part of the exercise, you will be starting to implment a three
#  layer neural network that classifies digits. You will start by
#  implementing a function to initialize the weights of the neural network
#  (randInitializeWeights.R)

cat(sprintf('\nInitializing Neural Network Parameters ...\n'))

initial_Theta1 <- randInitializeWeights(input_layer_size, hidden_layer_size)
initial_Theta2 <- randInitializeWeights(hidden_layer_size, num_labels)

# Unroll parameters
initial_nn_params <- c(initial_Theta1,initial_Theta2)


## --------------- Part 7: Implement Backpropagation ---------------
#  Once your cost matches up with ours, you should proceed to implement the
#  backpropagation algorithm for the neural network. You should add to the
#  code you've written in nnCostFunction.R to return the partial
#  derivatives of the parameters.
#
cat(sprintf('\nChecking Backpropagation... \n'))

#  Check gradients by running checkNNGradients
checkNNGradients()

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## --------------- Part 8: Implement Regularization ---------------
#  Once your backpropagation implementation is correct, you should now
#  continue to implement the regularization with the cost and gradient.
#

cat(sprintf('\nChecking Backpropagation (w/ Regularization) ... \n'))

#  Check gradients by running checkNNGradients
lambda <- 3
checkNNGradients(lambda)

# Also output the costFunction debugging values
debug_J  <- nnCostFunction(input_layer_size,
                          hidden_layer_size, num_labels, X, y, lambda)(nn_params)

cat(sprintf('\n\nCost at (fixed) debugging parameters (w/ lambda <- 10): %f
(this value should be about 0.576051)\n\n', debug_J))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------------------- Part 8: Training NN --------------------
#  You have now implemented all the code necessary to train a neural
#  network. To train your neural network, we will now use "fmincg", which
#  is a function which works similarly to "fminunc". Recall that these
#  advanced optimizers are able to train our cost functions efficiently as
#  long as we provide them with the gradient computations.
#
cat(sprintf('\nTraining Neural Network... \n'))

#  You should also try different values of lambda
lambda <- 1

# Create "short hand" for the cost function to be minimized
costFunction <- nnCostFunction(input_layer_size, hidden_layer_size, 
                                   num_labels, X, y, lambda) #over nn_params

gradFunction <- nnGradFunction(input_layer_size, hidden_layer_size, 
                               num_labels, X, y, lambda) #over nn_params

# Now, costFunction and gradFunction are functions that take in only one argument (the
# neural network parameters)

# lbfgsb3 works like fmincg (fast)
library(lbfgsb3)

# After you have completed the assignment, change the maxit to a larger
# value to see how more training helps.
opt <- lbfgsb3_(initial_nn_params, fn= costFunction, gr=gradFunction,
                  control = list(trace=1,maxit=50))


nn_params <- opt$prm
cost <- opt$f

# Obtain Theta1 and Theta2 back from nn_params
Theta1 <- matrix(nn_params[1:(hidden_layer_size * (input_layer_size + 1))],
                 hidden_layer_size, (input_layer_size + 1))

Theta2 <- matrix(nn_params[(1 + (hidden_layer_size * (input_layer_size + 1))):length(nn_params)],
                 num_labels, (hidden_layer_size + 1))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------------- Part 9: Visualize Weights -------------------
#  You can now "visualize" what the neural network is learning by
#  displaying the hidden units to see what features they are capturing in
#  the data.

cat(sprintf('\nVisualizing Neural Network... \n'))

displayData(Theta1[, -1])

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------------- Part 10: Implement Predict -------------------
#  After training the neural network, we would like to use it to predict
#  the labels. You will now implement the "predict" function to use the
#  neural network to predict the labels of the training set. This lets
#  you compute the training set accuracy.

pred <- predict(Theta1, Theta2, X)

cat(sprintf('\nTraining Set Accuracy: %f\n', mean(pred==y) * 100))

cat('Program paused. Press enter to continue.\n')
line <- readLines(con = stdin(),1)

#  To give you an idea of the network's output, you can also run
#  through the examples one at the a time to see what it is predicting.

#  Randomly permute examples
rp <- sample(m)

for (i in 1:m){
    # Display
    cat(sprintf('\nDisplaying Example Image. Press Esc to End\n'))
    displayData(X[rp[i], ])

    pred <- predict(Theta1, Theta2, X[rp[i],])
    cat(sprintf('\nNeural Network Prediction: %d (y %d) (digit %d)\n', pred  , y[rp[i]]  ,pred %% 10))

    # line <- readLines(con = stdin(),1)
    #cat(sprintf('Program paused. Press enter to continue.\n')
    #line <- readLines(con = stdin(),1)
    Sys.sleep(2)
    #press esc to quit the loop in Rstudio
}
