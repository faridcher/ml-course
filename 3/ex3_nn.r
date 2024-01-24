## Machine Learning Online Class - Exercise 3 | Part 2: Neural Networks

#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  linear exercise. You will need to complete the following functions 
#  in this exericse:
#
#     lrCostFunction.r (logistic regression cost function)
#     oneVsAll.r
#     predictOneVsAll.r
#     predict.r
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("../lib/sigmoid.r","displayData.r","lrCostFunction.r",
             "oneVsAll.r","predict.r", "predictOneVsAll.r")
# Uncomment the following, if you want to execute the solution scripts.
sources <- c(sources[1:2], paste0(substr(sources[-c(1,2)],1,nchar(sources[-c(1,2)])-2), '-solution.r'))
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

load('ex3data1.rda')
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
load('ex3weights.rda')

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
# showing 5 random digits
for (i in 1:5){
    cat(sprintf('\nDisplaying Example Image. Press Ctrl-c to End\n'))
    displayData(X[rp[i], ])
    pred <- predict(Theta1, Theta2, X[rp[i],])
    cat(sprintf('\nNeural Network Prediction: %d (y %d) (digit %d)\n', pred ,y[rp[i]],pred%%10))
    #cat(sprintf('Program paused. Press enter to continue.\n'))
    #line <- readLines(con = stdin(),1)
    if(interactive()) Sys.sleep(2)
}
