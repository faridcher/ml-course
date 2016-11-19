## Machine Learning Online Class - Exercise 3 | Part 1: One-vs-all

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

## Setup the parameters you will use for this part of the exercise
input_layer_size  <- 400  # 20x20 Input Images of Digits
num_labels <- 10          # 10 labels, from 1 to 10   
                          # (note that we have mapped "0" to label 10)

## ------------- Part 1: Loading and Visualizing Data --------------
#  We start the exercise by first loading and visualizing the dataset. 
#  You will be working with a dataset that contains handwritten digits.
#

# Load Training Data
cat(sprintf('Loading and Visualizing Data ...\n'))
load('ex3data1.Rda') #data
list2env(data,.GlobalEnv)
rm(data)

m <- dim(X)[1]

# Randomly select 100 data points to display
rand_indices <- sample(m)
sel <- X[rand_indices[1:100], ]

displayData(sel)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------ Part 2: Vectorize Logistic Regression ------------
#  In this part of the exercise, you will reuse your logistic regression
#  code from the last exercise. Your task here is to make sure that your
#  regularized logistic regression implementation is vectorized. After
#  that, you will implement one-vs-all classification for the handwritten
#  digit dataset.
#

cat(sprintf('\nTraining One-vs-All Logistic Regression...\n'))

lambda <- 0.1
all_theta <- oneVsAll(X, y, num_labels, lambda)

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ----------------- Part 3: Predict for One-Vs-All -----------------
pred <- predictOneVsAll(all_theta, X)

cat(sprintf('\nTraining Set Accuracy: %f\n', mean(pred == y) * 100))

