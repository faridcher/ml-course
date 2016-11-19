## Introduction

This is the R version assignments of the popular online machine learning course on Coursera website.

To download lecture videos visit the course website:
- [Course website](https://www.coursera.org/learn/machine-learning)
- [The course wiki page](https://share.coursera.org/wiki/index.php/ML:Main)

This repo provides the starter code to solve the assignment in R statistical software. 
The completed assignments are available too, but they will be removed them in future so feel free to fork. 

To solve the assignments simply fill the parts of the code that is written `"YOUR CODE HERE"`. 

## Dependencies
In order to produce similar results and plots to Octave/Matlab, you should install a few packages:

- `rgl` package is used to produce the 3D scatter plots and surface plots in the exercises.

- `lbfgsb3`: There are many optimization tasks within the assignments. Most of them were not large-scale optimization problem and they were optimized using built-in `optim` function of R. However to solve optimization problems in exercise 4 and exercise 8, I have used a slightly modified version of [lbfgsb3](https://cran.r-project.org/package=lbfgsb3) package. One should first install the package and then source the `lbfgsb3_.R`. The sourcing is done in the starter codes automatically. `fmincg` or `fminunc` optimization functions in Octave/Matlab take one function as input that computes cost and gradient simultaneously. However, cost and gradient functions MUST be supplied into `optim` or `lbfgsb3` functions in R individually. So I have separated the cost and gradient functions in the starter codes.

- `SnowballC`: `portStemmer` function in this package has the same role of the `portStemmer.m`.
- 
- `raster` package is used to produce the plot of the bird in exercise 7.

- `jsonlite` and `httr` packages are needed for submission.

Last but not the least is the Octave/Matlab `pinv` function. There is a `ginv` function in `MASS` package that doesn't produce the same exact result of Octave/Matlab `pinv`. Therefore a slightly modified version of MASS `ginv` is included in the starter codes. `MASS` package is not needed to be installed.

Before starting to code, install the following packages:
`install.packages(c('rgl','lbfgsb3','SnowballC','raster','jsonlite', 'httr'))`

## Submission
After completing each assignment, `source` the `submit.r` and type `submit()` in the R console.

I submitted my solutions to Coursera for testing and the scores were 100%. Please report any problem with submission. 

## Screen-shots
A few screen-shots of the plots produced in R:

![Anomaly Detection](http://faridcher.github.io/uploads/ml-course/Snapshots/AnomolyDetection.png)
![Gradient Descent Convergence](http://faridcher.github.io/uploads/ml-course/Snapshots/GradientDescent_Convergence.PNG)
![K-Means Clustering](http://faridcher.github.io/uploads/ml-course/Snapshots/K-Means_Clustering.png)
![K-Means Raster Compress](http://faridcher.github.io/uploads/ml-course/Snapshots/K-Means_CompressImage.png)
![Learning Curves](http://faridcher.github.io/uploads/ml-course/Snapshots/Learning Curve.png)
![PCA Face Dataset](http://faridcher.github.io/uploads/ml-course/Snapshots/PCA_FaceDataset.png)
![SVM RBF Kernel](http://faridcher.github.io/uploads/ml-course/Snapshots/SVM_RBF_Kernel.png)
![Multiple Regression](http://faridcher.github.io/uploads/ml-course/Snapshots/GradientDescent_multiple-regression.PNG)
![PCA Pixel Dataset Centroids](http://faridcher.github.io/uploads/ml-course/Snapshots/PCA_PixelDataset_Centroid.PNG)

## Topics covered in the course and assignments
1. Linear regression, cost function and normalization
2. Gradient descent and advanced optimization
3. Multiple linear regression and normal equation
4. Logistic regression, decision boundary and multi-class classification
5. Over-fitting and Regularization
6. Neural Network non-linear classification
7. Model validation, diagnosis and learning curves
8. System design, prioritizing and error analysis
9. Support vector machine (SVM), large margin classification and SVM kernels (linear and Gaussian)
10. K-Means clustering
11. Principal component analysis (PCA)
12. Anomaly detection, supervised learning
13. Recommender systems, Collaborative filtering
14. Large scale machine learning, stochastic and mini-batch gradient descent, on-line learning, map reduce
