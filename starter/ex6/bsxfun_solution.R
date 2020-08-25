#A <- matrix(1:8,4,2)
#B <- 1:4
#bsxfun('+',B, A) == bsxfun('+',A, B)

bsxfun <- function (func, x, y)
{
  dim_fix <- function(x,y) {
    # y is always with the smaller dimension
    
    d <- dim(x)[!(dim(x) %in% dim(y))]
    if (is.na(d[1]))
      d <- dim(x)[1]
    ifelse(dim(y)[1] == 1,
           y <- repmat(y,d,1),
           y <- repmat(y,1,d))
    
    if (dim(x)[1] != dim(y)[1])
      y <- t(y)
    
    return(y)
  }
  
  x <- as.matrix(x)
  y <- as.matrix(y)
  
  stopifnot(is.numeric(x), is.numeric(y))
  dx <- dim(x)
  dy <- dim(y)
  
  if (!all(dx == dy))
    ifelse (sum(dx) < sum(dy),
            x <- dim_fix(y,x),
            y <- dim_fix(x,y))
  
  dx <- dim(x)
  dy <- dim(y)
  if (is.vector(x) && is.vector(y)) {
    z <- mapply(func, x, y)
  }
  else if (is.array(x) && is.array(y) && all(dx == dy)) {
    z <- mapply(func, x, y)
    dim(z) <- dx
  }
  else {
    stop("Argument 'x', 'y' must be vectors or arrays of the same size.")
  }
  return(z)
}

repmat <- function (a, n, m = n)
{
  if (length(a) == 0)
    return(c())
  if (!is.numeric(a) && !is.complex(a))
    stop("Argument 'a' must be a numeric or complex.")
  if (is.vector(a))
    a <- matrix(a, nrow = 1, ncol = length(a))
  if (!is.numeric(n) || !is.numeric(m) || length(n) != 1 ||
      length(m) != 1)
    stop("Arguments 'n' and 'm' must be single integers.")
  n <- max(floor(n), 0)
  m <- max(floor(m), 0)
  if (n <= 0 || m <= 0)
    return(matrix(0, nrow = n, ncol = m))
  matrix(1, n, m) %x% a
}
