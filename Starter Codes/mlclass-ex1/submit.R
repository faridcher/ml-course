submit <- function(){
  
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  conf$assignmentSlug = 'linear-regression'
  conf$itemName = 'Linear Regression with Multiple Variables'
  conf$partArrays = c(
      '1', 'warmUpExercise.r' , 'Warm-up Exercise', 
      '2', 'computeCost.r' , 'Computing Cost (for One Variable)', 
      '3', 'gradientDescent.r' , 'Gradient Descent (for One Variable)', 
      '4', 'featureNormalize.r' , 'Feature Normalization', 
      '5', 'computeCostMulti.r' , 'Computing Cost (for Multiple Variables)', 
      '6', 'gradientDescentMulti.r' , 'Gradient Descent (for Multiple Variables)', 
      '7', 'normalEqn.r' , 'Normal Equations')
  conf$partArrays = matrix(conf$partArrays,7,3 , byrow = T)
  conf$output = output

  submitWithConfiguration(conf)
}

output = function(partId){
  source('warmUpExercise.R')
  source('computeCost.R')
  source('gradientDescent.R')
  source('featureNormalize.R')
  source('computeCostMulti.R')
  source('gradientDescentMulti.R')
  source('normalEqn.R')
  # Random Test Cases
  #X1 = [ones(20,1) (exp(1) + exp(2) * (0.1:0.1:2))']
  X1 = cbind(rep(1,20), exp(1) + exp(2) * seq(.1, 2, .1 ) )
  X1 = round(X1,4)
  #Y1 = X1(:,2) + sin(X1(:,1)) + cos(X1(:,2))
  Y1 = X1[,2] + sin(X1[,1]) + cos(X1[,2])
  
  #X2 = [X1 X1(:,2).^0.5 X1(:,2).^0.25]
  X2 = cbind(X1, X1[,2]^0.5, X1[,2]^0.25)
  Y2 = Y1^0.5 + Y1
  
  if (partId == '1')
    out = paste0(sprintf('%0.5f ', warmUpExercise()), collapse = '')
  else if (partId == '2')
    # different rounding
    out = sprintf('%0.5f ', computeCost(X1, Y1, c(0.5, -0.5)))
  else if (partId == '3')
    out = paste0(sprintf('%0.5f ', gradientDescent(X1, Y1, c(0.5, -0.5), 0.01, 10)$theta), collapse = '')
  else if (partId == '4')
    out = paste0(sprintf('%0.5f ', featureNormalize(X2[,2:4])$X_norm ), collapse = '')
  else if (partId == '5')
    #round
    out = sprintf('%0.5f ', computeCostMulti(X2, Y2, c(0.1,0.2,0.3,0.4)))
  else if (partId == '6')
    out = paste0(sprintf('%0.5f ', gradientDescentMulti(X2, Y2, -1 * c(0.1,0.2,0.3,0.4) , 0.01, 10)$theta)
                 , collapse = '')
  else if (partId == '7')
    out = paste0(sprintf('%0.5f ', normalEqn(X2, Y2)), collapse = '')
}
