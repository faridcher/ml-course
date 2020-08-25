#Gradient Descent partial derivatives
deriv = (t(X %*% theta_prev - y) %*% X[, j]) / m   
theta[j] = theta_prev[j] - (alpha * deriv)
#LR cost function
dif <- X %*% theta - y
J <- (t(dif) %*% dif) / (2 * m)
#Color: smooth colorful surface
color = rev(rainbow(nbcol, start = 0/6, end = 4/6))
J_vals_col  = cut(J_vals, nbcol) #
col = color[J_vals_col]

#To get reasonable plot range for plot3d, persp3d contour
apply(X,2,range)

#logistic regression cost
# -1/m SIGMA( y*logh + (1-y)log(1-h) )
h <- sigmoid(X %*% theta)
J <- -(t(y) %*% log(h) + t(1 - y) %*% log(1 - h)) / m
# calculate grads
# 1/m SIGMA( (h-y)xj )
grad <- (t(X) %*% (h - y)) / m

#counter needs: vector, vector, matrix
contour(1:5,1:6,matrix(a,5,6))

#plot decision boundary
z[i,j] <- mapFeature(u[i], v[j]) %*% theta
contour(u, v, z,levels=0)

#Higher order polynomial
#X1, X2, X1^2, X2^2, X1*X2, X1*X2^2, etc..
for (i in 1:degree)
    for (j in 0:i)
      (X1 ^ (i - j)) * (X2 ^ j)


# Wiki removed with this comment
Removed R implementation of Assignments - Copyright Violation: Unauthorized Derivative Work

Mentor Note: The "R" project is a private effort, not sponsored by Stanford Univ or Coursera, and support is not provided via the course Forums.