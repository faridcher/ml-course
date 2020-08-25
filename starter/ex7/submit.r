submit = function(){
  source("lib/submitWithConfiguration.r")
  
  conf = list()
  conf$assignmentSlug = 'k-means-clustering-and-pca';
  conf$itemName = 'K-Means Clustering and PCA';
  conf$partArrays = c(
    '1', 
    'findClosestCentroids.r' , 
    'Find Closest Centroids (k-Means)', 
    '2', 
    'computeCentroids.r' , 
    'Compute Centroid Means (k-Means)', 
    '3', 
    'pca.r' , 
    'PCA', 
    '4', 
    'projectData.r' , 
    'Project Data (PCA)', 
    '5', 
    'recoverData.r' , 
    'Recover Data (PCA)')
  conf$partArrays = matrix(conf$partArrays, ncol =  3 , byrow = T)
  
  conf$output = output;

  submitWithConfiguration(conf);
}

output = function(partId, auxstring) {
  source("findClosestCentroids.r")
  source("computeCentroids.r")
  source("pca.r")
  source("projectData.r")
  source("recoverData.r")
  # Random Test Cases
  X = matrix(sin(seq(1,165)), 15, 11)
  Z = matrix(cos(seq(1,121)), 11, 11)
  C = Z[1:5,]
  idx = (1 + (1:15 %% 3))
  if (partId == '1'){
    idx = findClosestCentroids(X, C)
    out = paste0(sprintf('%0.5f ', c(idx)), collapse = '')
  }else if (partId == '2'){
    centroids = computeCentroids(X, idx, 3)
    out = paste0(sprintf('%0.5f ', c(centroids)), collapse = '')
  }else if (partId == '3'){
    USV = pca(X)
    list2env(USV,.GlobalEnv)
    out = paste0(sprintf('%0.5f ', abs(c(u,c(diag(d)) ) ) ), collapse = '')
  }else if (partId == '4'){
    X_proj = projectData(X, Z, 5)
    out = paste0(sprintf('%0.5f ', c(X_proj)), collapse = '')
  }else if (partId == '5'){
    X_rec = recoverData(X[,1:5], Z, 5)
    out = paste0(sprintf('%0.5f ', c(X_rec)), collapse = '')
  }
}
