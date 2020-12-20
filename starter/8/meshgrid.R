meshgrid <- function (x, y = x)
{
  if (!is.numeric(x) || !is.numeric(y))
    stop("Arguments 'x' and 'y' must be numeric vectors.")
  x <- c(x)
  y <- c(y)
  n <- length(x)
  m <- length(y)
  X <- matrix(rep(x, each = m), nrow = m, ncol = n)
  Y <- matrix(rep(y, times = n), nrow = m, ncol = n)
  return(list(X = X, Y = Y))
}
