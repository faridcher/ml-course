## Introduction

This is the R version assignments of the online machine learning course (MOOC) on Coursera website by Prof. Andrew Ng.

To download lecture videos visit the course website:
- [Course website](https://www.coursera.org/learn/machine-learning)
- [The course wiki page](https://share.coursera.org/wiki/index.php/ML:Main)

This repository provides the starter code to solve the assignment in R statistical software; the completed assignments are also available beside each exercise file.

Simply follow these steps to complete the assignments:

1. View the lectures videos and handouts.
2. Instructions are basically for MATLAB/OCTAVE. R compatible version of instructions will become available here as [Wiki](https://github.com/faridcher/machine-learning-course/wiki) pages in future.
3. Use the **starter** folder and fill the parts of the code that is written "YOUR CODE HERE"
4. If you couldn't solve it yourself, get help from the accompanied file suffixed by `_solution` inside the same folder of the starter code. For example, `starter/ex1/computeCost.R` has an associated solution file named `starter/ex1/computeCost_solution.R`
5. Submit

## Dependencies
In order to produce similar results and plots to Octave/Matlab, you should install a few packages:

- `rgl` package is used to produce the 3D scatter plots and surface plots in the exercises.

- `SnowballC`: `portStemmer` function in this package has the same role of the `portStemmer.m`.
 
- `raster` package is used to produce the plot of the bird in exercise 7.

- `jsonlite` and `httr` packages are needed for submission.

- `pinv.R`: The `ginv` function, generalized inverse, in `MASS` package doesn't produce the same result of the Matlab `pinv` (pseudo-inverse). `pinv.R` is the modified version of MASS `ginv` to produce the same effect of the MATLAB `pinv`. For more info see [the stackoverflow discussion](http://stackoverflow.com/questions/36391548/r-ginv-and-matlab-pinv-produce-different-results)

- `lbfgsb3_.R`: Certain optimization tasks could only be solved using `lbfgsb3` package, yet there are a few bugs in this package. The purpose of `lbfgsb3_.R` is to address these bugs; it is used for exercises 4 and 8.
Beware that `fmincg` or `fminunc` optimization function in Matlab takes one function as input and computes cost and gradient simultaneously. However, cost and gradient functions MUST be supplied into `optim` or `lbfgsb3` functions individually.

Before starting to code, install the following packages:
`install.packages(c('rgl','lbfgsb3','SnowballC','raster','jsonlite', 'httr'))`

Note that you don't have to do anything with what is mentioned above, just be informed.

## Submission
After completing each assignment, `source("submit.r")`  and then `submit()` in your R console.

I submitted the solutions to Coursera for testing and the scores were 100%. Please report any problem with submission here. 

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

## Screen-shots
A few screenshots of the plots produced in R:

![Anomaly Detection](https://raw.githubusercontent.com/faridcher/ml-course/master/img/AnomolyDetection.png)
![Gradient Descent Convergence](https://raw.githubusercontent.com/faridcher/ml-course/master/img/GradientDescent_Convergence.PNG)
![K-Means Clustering](https://raw.githubusercontent.com/faridcher/ml-course/master/img/K-Means_Clustering.png)
![K-Means Raster Compress](https://raw.githubusercontent.com/faridcher/ml-course/master/img/K-Means_CompressImage.png)
![Learning Curves](https://raw.githubusercontent.com/faridcher/ml-course/master/img/Learning%20Curve.png)
![PCA Face Dataset](https://raw.githubusercontent.com/faridcher/ml-course/master/img/PCA_FaceDataset.png)
![SVM RBF Kernel](https://raw.githubusercontent.com/faridcher/ml-course/master/img/SVM_RBF_Kernel.png)
![Multiple Regression](https://raw.githubusercontent.com/faridcher/ml-course/master/img/GradientDescent_multiple-regression.PNG)
![PCA Pixel Dataset Centroids](https://raw.githubusercontent.com/faridcher/ml-course/master/img/PCA_PixelDataset_Centroid.PNG)
