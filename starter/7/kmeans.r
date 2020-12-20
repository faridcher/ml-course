x # input matrix
k # number of clusters

# init_cent
init_cent <- x[sample(nrow(x),k),]
idx <- findClosestCentroids(X, initial_centroids)
d <- dist(x)
dist_rows(d
centroids <- computeCentroids(X, idx, K)
kMean <- runkMeans(X, initial_centroids, max_iters, TRUE)
