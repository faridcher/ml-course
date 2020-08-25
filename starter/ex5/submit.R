submit = function(){
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  conf$assignmentSlug = 'regularized-linear-regression-and-bias-variance';
  conf$itemName = 'Regularized Linear Regression and Bias/Variance';
  conf$partArrays = c(
    '1', 
    'linearRegCostFunction.r' , 
    'Regularized Linear Regression Cost Function', 
    '2', 
    'linearRegCostFunction.r' , 
    'Regularized Linear Regression Gradient', 
    '3', 
    'learningCurve.r' , 
    'Learning Curve', 
    '4', 
    'polyFeatures.r' , 
    'Polynomial Feature Mapping', 
    '5', 
    'validationCurve.r' , 
    'Validation Curve')
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output;

  submitWithConfiguration(conf);
}

output = function(partId, auxstring) {
  source("linearRegCostFunction.r")
  source("learningCurve.r")
  source("polyFeatures.r")
  source("validationCurve.r")
  source("trainLinearReg.r")
  
  # Random Test Cases
  X = cbind(rep(1,10), sin(seq(1,15,1.5)), cos(seq(1,15,1.5)) )
  y = sin(seq(1,30,3))
  Xval = cbind(rep(1,10), sin(seq(0,14,1.5)) , cos(seq(0,14,1.5)) )
  yval = sin(seq(1,10))
  
  theta1 = c(0.1, 0.2, 0.3)
  if (partId == '1')
    out = sprintf('%0.5f ', linearRegCostFunction(X, y, 0.5)(theta1))
  else if (partId == '2')
    out = paste0(sprintf('%0.5f ', linearRegGradFunction(X, y, 0.5)(theta1)), collapse = '')
  else if (partId == '3'){
    lc = learningCurve(X, as.matrix(y), Xval, as.matrix(yval), 1)
    merg = c(lc$error_train, lc$error_val)
    out = paste0(sprintf('%0.5f ', merg), collapse = '')
  }else if (partId == '4')
    out = paste0(sprintf('%0.5f ', c(polyFeatures(X[2,], 8))), collapse = '')
  else if (partId == '5'){
    vc = validationCurve(X, y, Xval, yval)
    merg = c(vc[[1]],vc[[2]],vc[[3]])
    out = paste0(sprintf('%0.5f ', merg ), collapse = '')
  }
}
