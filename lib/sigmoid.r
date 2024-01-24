sigmoid <- function(z) {
  g <- matrix(0,dim(as.matrix(z)))
  1 / (1 + exp(-1 * z))
}
