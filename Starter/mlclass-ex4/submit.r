submit = function(){
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  
  conf$assignmentSlug = 'neural-network-learning';
  conf$itemName = 'Neural Networks Learning';
  conf$partArrays = c(     
    '1', 
    'nnCostFunction.r' , 
    'Feedforward and Cost Function', 
    '2', 
    'nnCostFunction.r' , 
    'Regularized Cost Function', 
    '3', 
    'sigmoidGradient.r' , 
    'Sigmoid Gradient', 
    '4', 
    'nnCostFunction.r' , 
    'Neural Network Gradient (Backpropagation)', 
    '5', 
    'nnCostFunction.r' , 
    'Regularized Gradient')
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output

  submitWithConfiguration(conf);
}

output = function(partId, auxstring) {
  source("nnCostFunction.r")
  source("sigmoidGradient.r")
  
  # Random Test Cases
  X = matrix(3 * sin(seq(1,30,1)), 3, 10);
  Xm = matrix(sin(seq(1,32,1)), 16, 2) / 5;
  ym = 1 + (seq(1,16) %% 4)
  t1 = sin(matrix(seq(1,24,2),4,3))
  t2 = cos(matrix(seq(1,40,2),4,5))
  t = c(c(t1),c(t2))
  
  if (partId == '1')
    out = sprintf('%0.5f ', nnCostFunction(2, 4, 4, Xm, ym, 0)(t))
  else if (partId == '2')
    out = sprintf('%0.5f ', nnCostFunction(2, 4, 4, Xm, ym, 1.5)(t))
  else if (partId == '3')
    out = paste0(sprintf('%0.5f ', sigmoidGradient(X)), collapse = '')
  else if (partId == '4'){
    out = sprintf('%0.5f ', nnCostFunction(2, 4, 4, Xm, ym, 0)(t))
    out = paste0(c(out, sprintf('%0.5f ', nnGradFunction(2, 4, 4, Xm, ym, 0)(t))  ),
                 collapse = '')
  }else if (partId == '5'){
    out = sprintf('%0.5f ', nnCostFunction(2, 4, 4, Xm, ym, 1.5)(t))
    out = paste0(c(out, sprintf('%0.5f ', nnGradFunction(2, 4, 4, Xm, ym, 1.5)(t))  ),
               collapse = '')
  }
   
}
