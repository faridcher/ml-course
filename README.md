## Introduction

This is the R equivalent version of all assignments of the online machine learning course (MOOC) offered by Stanford university and instructed by [Andrew NG](http://www.andrewng.org). The course materials including lectures and presentation PDFs, can be downloaded all at once from [Coursera website](https://class.coursera.org/ml-003/lecture). The course [wiki page](https://share.coursera.org/wiki/index.php/ML:Main) is accessible too. 

One can solve the assignment and pass the quizzes and earn a certificate from [Coursera](https://www.coursera.org/learn/machine-learning). This repository is an attempt to bring this excellent online course to the great community of R users. 

The code provides the starter code and infrastructure for carrying out the assignment in R statistical software. The completed assignments are available too, however publishing the solutions is against the course rules and I will remove them in future. If you had any question regarding the assignments, fill free to ask them here in Github issues.

To solve the assignments simply fill the parts of the code that is written "YOUR CODE HERE". The assignment instructions (pdf) are also included in this repository. There is a RStudio project file in each exercise folder that is a proper starting point to complete the codes. Then the assignments can be submitted directly from R.

The "Solutions" folder has the solutions to the exercises. The `.Rda` or `.txt` data files are not included in this folder.

## Dependencies (3rd party packages)
I have tried my best not to use 3rd party packages in the starter codes. However to produce similar results and plots to Octave/Matlab I had to use a few packages although they are not many. 

[rgl](https://cran.r-project.org/package=rgl) package is used to produce the 3D scatter plots and surface plots in the exercises.

There are many optimization tasks within the assignments. Most of them were not large scale optimization problem and they were optimized using built-in `optim` function of R. However to solve optimization problems in exercise 4 and exercise 8, I have used a slightly modified version of [lbfgsb3](https://cran.r-project.org/package=lbfgsb3) package. One should first install the package and then source the `lbfgsb3_.R`. The sourcing is done in the starter codes automatically. `fmincg` or `fminunc` optimization functions in Octave/Matlab take one function as input that computes cost and gradient simultaneously. However cost and gradient functions MUST be supplied into `optim` or `lbfgsb3` functions in R individually. So I have separated the cost and gradient functions in the starter codes.

Stemmer software (portStemmer.m) is used in the exercise 6 (spam classification) and the `portStemmer` function is called from `processEmail` function. Instead of re-implementing `portStemmer` function in R, I have used [SnowballC](https://cran.r-project.org/package=SnowballC) package that produces the same results as with the case of portStemmer.m.

`R.matlab` package was used for reading Octave/Matlab `.mat` datasets. The datasets were converted to `.Rda`  format. Thus you would not need this package to complete the assignments.

`raster` package is used to produce the plot of the bird in exercise 7.

Last but not the least is the Octave/Matlab `pinv` function. There is a `ginv` function in `MASS` package that doesn't produce the same exact result of Octave/Matlab `pinv`. Therefore a slightly modified version of MASS `ginv` is included in the starter codes. `MASS` package is not needed to be installed.

To wrap up, before starting to code make sure the following 6 packages are pre-installed: `rgl`, `lbfgsb3`, `SnowballC` and `raster`.

`install.packages(c('rgl','lbfgsb3','SnowballC','raster'))`

## Submission
Now it is possible to submit assignments directly from R. So R programmers can take the course too. I submitted all assignments to coursera for testing and  the scores were 100%.

Two more packages namely `httr` for `POST()` function and `jsonlite` for `toJSON()` function are needed to be installed before submission.

`install.packages(c('jsonlite', 'httr'))`

In order to submit, after completing each assignment, set the working directory to the root folder of the corresponding assignment e.g. `setwd('D:\MachineLearningMOOC\StarterCodes\mlclass-ex1')`. Then `source` the `submit.r` in R and type `submit()` in the R console.

Try not to use my solutions and submit your own efforts as it is against the course rules. In future I may remove the solutions from the repository, so the submissions will be all your own efforts.

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
14. Large scale machine learning, stochastic and mini-batch gradient descent, online learning, map reduce
