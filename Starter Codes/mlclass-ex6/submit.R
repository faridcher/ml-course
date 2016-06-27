submit = function(){
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  conf$assignmentSlug = 'support-vector-machines';
  conf$itemName = 'Support Vector Machines';
  conf$partArrays = c(
    '1', 
    'gaussianKernel.r' , 
    'Gaussian Kernel', 
    '2', 
    'dataset3Params.r' , 
    'Parameters (C, sigma) for Dataset 3', 
    '3', 
    'processEmail.r' , 
    'Email Preprocessing', 
    '4', 
    'emailFeatures.r' , 
    'Email Feature Extraction')
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output;

  submitWithConfiguration(conf);
}

output = function(partId, auxstring) {
  source("gaussianKernel.r")
  source("processEmail.r")
  source("emailFeatures.r")
  source("dataset3Params.r")
  source("svmTrain.r")
  source("bsxfun.r")
  source("svmPredict.r")
  source("getVocabList.r")
  # Random Test Cases
  x1 = sin(seq(1,10))
  x2 = cos(seq(1,10))
  ec = 'the quick brown fox jumped over the lazy dog';
  wi = 1 + abs(round(x1 * 1863));
  wi = c(wi,wi)
  
  if (partId == '1')
    out = sprintf('%0.5f ', gaussianKernel(2)(x1, x2))
  else if (partId == '2'){
    load('ex6data3.rda')
    list2env(data,.GlobalEnv)
    d3p = dataset3Params(X, y, Xval, yval)
    out = sprintf('%0.5f ', d3p$C)
    out = paste0(c(out, sprintf('%0.5f ', d3p$sigma)), collapse = '')
  }else if (partId == '3'){
    word_indices = processEmail(ec)
    out = paste0(sprintf('%d ', word_indices), collapse = '')
  }else if (partId == '4'){
    x = emailFeatures(wi)
    out = paste0(sprintf('%d ', x), collapse = '')
  }
}
