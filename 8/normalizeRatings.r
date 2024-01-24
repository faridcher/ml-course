normalizeRatings <- function(Y, R) {
  #NORMALIZERATINGS Preprocess data by subtracting mean rating for every
  #movie (every row)
  #   Ynorm_Ymean <- NORMALIZERATINGS(Y, R) normalized Y so that each movie
  #   has a rating of 0 on average, and returns the mean rating in Ymean.
  #
  
  m <- dim(Y)[1]
  n <- dim(Y)[2]
  
  Ymean <- rep(0,m)
  Ynorm <- matrix(0,m,n)
  for (i in 1:m) {
    Ymean[i] <- mean(Y[i, R[i,] == 1])
    Ynorm[i, R[i,]] <- Y[i, R[i,] == 1] - Ymean[i]
  }
  list(Ynorm = Ynorm, Ymean = Ymean)
}