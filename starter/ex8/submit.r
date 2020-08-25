submit = function(){
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  conf$assignmentSlug = 'anomaly-detection-and-recommender-systems'
  conf$itemName = 'Anomaly Detection and Recommender Systems'
  conf$partArrays = c(     
    '1', 
    'estimateGaussian.r' , 
    'Estimate Gaussian Parameters', 
    '2', 
    'selectThreshold.r' , 
    'Select Threshold', 
    '3', 
    'cofiCostFunc.r' , 
    'Collaborative Filtering Cost', 
    '4', 
    'cofiCostFunc.r' , 
    'Collaborative Filtering Gradient', 
    '5', 
    'cofiCostFunc.r' , 
    'Regularized Cost', 
    '6', 
    'cofiCostFunc.r' , 
    'Regularized Gradient')
  
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output

  submitWithConfiguration(conf)
}

output = function(partId, auxstring) {  
  # Random Test Cases
  n_u = 3; n_m = 4; n = 5;
  X = matrix(sin(seq(1,n_m*n)), n_m, n)
  Theta = matrix(cos(seq(1,n_u*n)), n_u, n)
  Y = matrix(sin(seq(1,2*n_m*n_u,2)), n_m, n_u)
  R = (Y > 0.5)
  pval = c(abs(c(Y)),0.001,1)
  yval = c(c(R), 1, 0)
  params = c(c(X),c(Theta))
  
  source("estimateGaussian.r")
  source("selectThreshold.r")
  source("cofiCostFunc.r")
  
  if (partId == '1'){
    eg = estimateGaussian(X)
    out = paste0(sprintf('%0.5f ', c(eg$mu,eg$sigma2)), collapse = '')
  }else if (partId == '2'){
    stt = selectThreshold(yval, pval)
    out = paste0(sprintf('%0.5f ', c(stt$bestEpsilon,stt$bestF1)), collapse = '')
  }else if (partId == '3'){
    J = cofiCostFunc(Y, R, n_u, n_m, n, 0)(params)
    out = sprintf('%0.5f ', c(J))
  }else if (partId == '4'){
    grad = cofiGradFunc(Y, R, n_u, n_m, n, 0)(params)
    out = paste0(sprintf('%0.5f ', c(grad)),collapse = '')
  }else if (partId == '5'){
    J = cofiCostFunc(Y, R, n_u, n_m, n, 1.5)(params)
    out = sprintf('%0.5f ', c(J))
  }else if (partId == '6'){
    grad = cofiGradFunc( Y, R, n_u, n_m, n, 1.5)(params)
    out = paste0(sprintf('%0.5f ', c(grad)), collapse = '')
  }
}
