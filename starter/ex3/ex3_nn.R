## Machine Learning Online Class - Exercise 3 | Part 2: Neural Networks

#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  linear exercise. You will need to complete the following functions 
#  in this exericse:
#
#     lrCostFunction.R (logistic regression cost function)
#     oneVsAll.R
#     predictOneVsAll.R
#     predict.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("displayData.R","lrCostFunction.R",
             "oneVsAll.R","predict.R",
             "predictOneVsAll.R","sigmoid.R")
for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}


## Setup the parameters you will use for this exercise
input_layer_size  <- 400;  # 20x20 Input Images of Digits
hidden_layer_size <- 25;   # 25 hidden units
num_labels <- 10;          # 10 labels, from 1 to 10   
                          # (note that we have mapped "0" to label 10)

## ------------- Part 1: Loading and Visualizing Data --------------
#  We start the exercise by first loading and visualizing the dataset. 
#  You will be working with a dataset that contains handwritten digits.
#

# Load Training Data
cat(sprintf('Loading and Visualizing Data ...\n'))

load('ex3data1.Rda')
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
load('ex3weights.Rda')
list2env(data,.GlobalEnv)
rm(data)

## ------------------- Part 3: Implement Predict -------------------
#  After training the neural network, we would like to use it to predict
#  the labels. You will now implement the "predict" function to use the
#  neural network to predict the labels of the training set. This lets
#  you compute the training set accuracy.

pred <- predict(Theta1, Theta2, X)

cat(sprintf('\nTraining Set Accuracy: %f\n', mean(pred==y) * 100))

cat(sprintf('Program paused. Press enter to continue.\n'))
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
    cat(sprintf('\nNeural Network Prediction: %d (y %d) (digit %d)\n', pred ,y[rp[i]],pred%%10))
    
    # line <- readLines(con = stdin(),1)
    #cat(sprintf('Program paused. Press enter to continue.\n'))
    #line <- readLines(con = stdin(),1)
    
    Sys.sleep(2)
    #press esc to quit the loop in Rstudio
}

