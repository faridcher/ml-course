featureNormalize  <- function(X) {
  #FEATURENORMALIZE Normalizes the features in X 
  #   FEATURENORMALIZE(X) returns a normalized version of X where
  #   the mean value of each feature is 0 and the standard deviation
  #   is 1. This is often a good preprocessing step to do when
  #   working with learning algorithms.
  
  mu <- colMeans(X)
  
  #vectorized multivariate apply
  X_norm <- matrix(mapply(`-`,t(X),mu),dim(X) ,byrow = TRUE)
  
  sigma <- apply(X,2,sd)
  X_norm <- matrix(mapply(`/`,t(X_norm),sigma),dim(X) ,byrow = TRUE)
  
  list(X_norm=X_norm, mu=mu, sigma=sigma)

}
