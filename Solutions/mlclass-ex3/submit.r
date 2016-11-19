submit = function(){
  source("lib/submitWithConfiguration.r")

  conf = list()
  
  conf$assignmentSlug = 'multi-class-classification-and-neural-networks';
  conf$itemName = 'Multi-class Classification and Neural Networks';
  conf$partArrays = c(
    '1', 
    'lrCostFunction.r' , 
    'Regularized Logistic Regression', 
    '2', 
    'oneVsAll.r' , 
    'One-vs-All Classifier Training', 
    '3', 
    'predictOneVsAll.r' , 
    'One-vs-All Classifier Prediction', 
    '4', 
    'predict.r' , 
    'Neural Network Prediction Function')
  
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output;

  submitWithConfiguration(conf);
}

output = function(partId, auxstring) {
  source("lrCostFunction.r")
  source("oneVsAll.r")
  source("predictOneVsAll.r")
  source("predict.r")
  source("sigmoid.r")
  # Random Test Cases
  X = cbind(rep(1,20), exp(1) * sin(seq(1,20,1)), exp(0.5) * cos(seq(1,20,1)) )
  y = (sin(X[,1]+X[,2]) > 0)
  
  Xm = c(-1, -1 , -1 ,-2 , -2, -1 , -2, -2 , 
          1, 1 ,  1, 2 ,  2, 1 , 2, 2 , 
         -1, 1 ,  -1, 2 ,  -2, 1 , -2, 2 , 
          1, -1 , 1, -2 ,  -2, -1 , -2 ,-2 )
  Xm = matrix(Xm,ncol = 2, byrow = T)
  
  ym = c(1, 1, 1 ,1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4 ,4, 4 )
  t1 = sin(matrix(seq(1,24,2), 4, 3))
  t2 = cos(matrix(seq(1,40,2), 4, 5))
  theta = c(.25,.5,-.5)
  
  if (partId == '1'){
    out = sprintf('%0.5f ', lrCostFunction(X, y, 0.1)(theta) )
    out = paste0(c(out,sprintf('%0.5f ',lrGradFunction(X, y, 0.1)(theta))),collapse = '')
  }else if (partId == '2')
    out = paste0(sprintf('%0.5f ', oneVsAll(Xm, ym, 4, 0.1)), collapse = '')
  else if (partId == '3')
    out = paste0(sprintf('%0.5f ', predictOneVsAll(t1, Xm)), collapse = '')
  else if (partId == '4')
    out = paste0(sprintf('%0.5f ', predict(t1, t2, Xm)), collapse = '')
}
