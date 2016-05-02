## Machine Learning Online Class
#  Exercise 8 | Anomaly Detection and Collaborative Filtering
#
#  Instructions
#  ------------
#
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     estimateGaussian.R
#     selectThreshold.R
#     cofiCostFunc.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("loadMovieList.R","checkCostFunction.R","cofiCostFunc.R","lbfgsb3_.R",
             "computeNumericalGradient.R","normalizeRatings.R","lbfgsb3_.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

## --------------- Part 1: Loading movie ratings dataset -----------------
#  You will start by loading the movie ratings dataset to understand the
#  structure of the data.
#  
cat(sprintf('Loading movie ratings dataset.\n\n'))

#  Load data
load("ex8_movies.Rda")
list2env(data,.GlobalEnv)
rm(data)

#  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies on 
#  943 users
#
#  R is a 1682x943 matrix, where R[i,j] <- 1 if and only if user j gave a
#  rating to movie i

#  From the matrix, we can compute statistics like average rating.
cat(sprintf('Average rating for movie 1 (Toy Story): %f / 5\n\n', 
        mean(Y[1, R[1, ]==1] ) ) )

#  We can "visualize" the ratings matrix by plotting it with image
revY <- apply(Y,2,rev)
image(t(revY) ,ylab="Movies",xlab="Users",
      col=topo.colors(50))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------ Part 2: Collaborative Filtering Cost Function -------------
#  You will now implement the cost function for collaborative filtering.
#  To help you debug your cost function, we have included set of weights
#  that we trained on that. Specifically, you should complete the code in 
#  cofiCostFunc.R to return J.

#  Load pre-trained weights (X, Theta, num_users, num_movies, num_features)
load("ex8_movieParams.Rda")
list2env(data,.GlobalEnv)
rm(data)

#  Reduce the data set size so that this runs faster
num_users <- 4; num_movies <- 5; num_features <- 3
X <- X[1:num_movies, 1:num_features]
Theta <- Theta[1:num_users, 1:num_features]
Y <- Y[1:num_movies, 1:num_users]
R <- R[1:num_movies, 1:num_users]

#  Evaluate cost function
J <- cofiCostFunc( Y, R, num_users, num_movies,
               num_features, 0)(c(c(X),c(Theta)))
           
cat(sprintf('Cost at loaded parameters: %f 
(this value should be about 22.22)\n', J))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ---------------- Part 3: Collaborative Filtering Gradient ----------------
#  Once your cost function matches up with ours, you should now implement 
#  the collaborative filtering gradient function. Specifically, you should 
#  complete the code in cofiCostFunc.R to return the grad argument.
#  
cat(sprintf('\nChecking Gradients (without regularization) ... \n'))

#  Check gradients by running checkNNGradients
checkCostFunction()

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## --------- Part 4: Collaborative Filtering Cost Regularization ----------
#  Now, you should implement regularization for the cost function for 
#  collaborative filtering. You can implement it by adding the cost of
#  regularization to the original cost computation.
#  

#  Evaluate cost function
J <- cofiCostFunc(Y, R, num_users, num_movies, 
               num_features, 1.5)(c(c(X),c(Theta)))
           
cat(sprintf('Cost at loaded parameters (lambda = 1.5): %f
(this value should be about 31.34)\n', J))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## -------- Part 5: Collaborative Filtering Gradient Regularization ------
#  Once your cost matches up with ours, you should proceed to implement 
#  regularization for the gradient. 

cat(sprintf('\nChecking Gradients (with regularization) ... \n'))

#  Check gradients by running checkNNGradients
checkCostFunction(1.5)

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ---------------- Part 6: Entering ratings for a new user ---------------
#  Before we will train the collaborative filtering model, we will first
#  add ratings that correspond to a new user that we just observed. This
#  part of the code will also allow you to put in your own ratings for the
#  movies in our dataset!
#
movieList <- loadMovieList()

#  Initialize my ratings
my_ratings <- rep(0,1682)

# Check the file movie_idx.txt for id of each movie in our dataset
# For example, Toy Story (1995) has ID 1, so to rate it "4", you can set
my_ratings[1] <- 4

# Or suppose did not enjoy Silence of the Lambs (1991), you can set
my_ratings[98] <- 2

# We have selected a few movies we liked / did not like and the ratings we
# gave are as follows:
my_ratings[7] <- 3
my_ratings[12]<- 5
my_ratings[54] <- 4
my_ratings[64]<- 5
my_ratings[66]<- 3
my_ratings[69] <- 5
my_ratings[183] <- 4
my_ratings[226] <- 5
my_ratings[355]<- 5

cat(sprintf('\n\nNew user ratings:\n'))

for (i in 1:length(my_ratings))
    if (my_ratings[i] > 0 )
        cat(sprintf('Rated %d for %s\n', my_ratings[i], movieList[i]))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)


## ------------------ Part 7: Learning Movie Ratings ----------------------
#  Now, you will train the collaborative filtering model on a movie rating 
#  dataset of 1682 movies and 943 users
#

cat(sprintf('\nTraining collaborative filtering...\n'))

#  Load data
load("ex8_movies.Rda")
list2env(data,.GlobalEnv)
rm(data)

#  Y is a 1682x943 matrix, containing ratings (1-5) of 1682 movies by 
#  943 users
#
#  R is a 1682x943 matrix, where R[i,j] <- 1 if and only if user j gave a
#  rating to movie i

#  Add our own ratings to the data matrix
Y <- cbind(my_ratings, Y)
R <- cbind((my_ratings != 0), R)

#  Normalize Ratings
NR  <- normalizeRatings(Y, R)
Ynorm <- NR$Ynorm
Ymean <- NR$Ymean
#  Useful Values
num_users <- dim(Y)[2]
num_movies <- dim(Y)[1]
num_features <- 10

# Set Initial Parameters (Theta, X)
n <- num_movies * num_features
X <- matrix(rnorm(n), num_movies, num_features)

n <- num_users * num_features
Theta <-  matrix(rnorm(n), num_users, num_features)

initial_parameters <- c(c(X), c(Theta))

# Set Regularization
lambda <- 10

cF <- cofiCostFunc(Y, R, num_users, num_movies,num_features, lambda)
gF <- cofiGradFunc(Y, R, num_users, num_movies,num_features, lambda)

#lbfgsb3 works like fmincg
library(lbfgsb3)
theta <- lbfgsb3_(initial_parameters, fn= cF, gr=gF,
        control = list(trace=1,maxit=100))$prm

#The following code works but optim is slow on this problem
#theta <- optim(initial_parameters, fn = cF, gr = gF,
       #method = "BFGS", control = list(maxit=10, trace=1, REPORT=1) )$par

# Unfold the returned theta back into U and W
X <- matrix(theta[1:(num_movies*num_features)], num_movies, num_features)
Theta <- matrix(theta[(num_movies*num_features+1):length(theta)], 
                num_users, num_features)

cat(sprintf('Recommender system learning completed.\n'))

cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------------ Part 8: recommendation for you ----------------------
#  After training the model, you can now make recommendations by computing
#  the predictions matrix.
#

p <- X %*% t(Theta)
my_predictions <- p[,1] + Ymean

movieList <- loadMovieList()

ix <- sort(my_predictions, decreasing = TRUE,index.return=TRUE)$ix

cat(sprintf('\nTop recommendations for you:\n'))
for (i in 1:10){
    j <- ix[i]
    cat(sprintf('Predicting rating %.1f for movie %s\n', my_predictions[j],movieList[j]))
}

cat(sprintf('\n\nOriginal ratings provided:\n'))
for (i in 1:length(my_ratings))
    if (my_ratings[i] > 0 )
        cat(sprintf('Rated %d for %s\n', my_ratings[i],movieList[i]))

