pinv <-
  function (X, tol = max(dim(X)) * max(X) * .Machine$double.eps)
  {
    if (length(dim(X)) > 2L || !(is.numeric(X) || is.complex(X)))
      stop("'X' must be a numeric or complex matrix")
    if (!is.matrix(X))
      X <- as.matrix(X)
    Xsvd <- svd(X)
    if (is.complex(X))
      Xsvd$u <- Conj(Xsvd$u)
    Positive <- any(Xsvd$d > max(tol * Xsvd$d[1L], 0))
    if (Positive)
      Xsvd$v %*% (1 / Xsvd$d * t(Xsvd$u))
    else
      array(0, dim(X)[2L:1L])
  }