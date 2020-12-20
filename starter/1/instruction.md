Programming Exercise 1: Linear Regression
================
Farid Cheraghi
Sep 2, 2020

  - [Introduction](#introduction)
      - [Where to get help](#where-to-get-help)
  - [1 Simple R function](#simple-r-function)
      - [1.1 Submitting Solutions](#submitting-solutions)
  - [2 Linear regression with one
    variable](#linear-regression-with-one-variable)
      - [2.1 Plotting the Data](#plotting-the-data)
      - [2.2 Gradient Descent](#gradient-descent)
      - [2.3 Debugging](#debugging)
      - [2.4 Visualizing
        ![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
        "J(\\theta)")](#visualizing-jtheta)
  - [3 Linear regression with multiple
    variables](#linear-regression-with-multiple-variables)
      - [3.1 Feature Normalization](#feature-normalization)
      - [3.2 Gradient Descent](#gradient-descent-2)
      - [3.3 Normal Equations](#normal-equations)
  - [Submission and Grading](#submission-and-grading)
      - [Optional Exercises](#optional-exercises-1)

## Introduction

In this exercise, you will implement linear regression and get to see it
work on data. Before starting on this programming exercise, we strongly
recommend watching the video lectures and completing the review
questions for the associated topics. To get started with the exercise,
you will need to download the starter code and unzip its contents to the
directory where you wish to complete the exercise. If needed, use the
`setwd()` command in R to change to this directory before starting this
exercise.

Files included in this exercise:

  - `ex1.R` - R script that steps you through the exercise
  - `ex1_multi.R` - R script for the later parts of the exercise
  - `ex1data1.txt` - Dataset for linear regression with one variable
  - `ex1data2.txt` - Dataset for linear regression with multiple
    variables
  - `submit.R` - Submission script that sends your solutions to our
    servers
  - ⋆ `warmUpExercise.R` - Simple example function in R
  - ⋆ `plotData.R` - Function to display the dataset
  - ⋆ `computeCost.R` - Function to compute the cost of linear
    regression
  - ⋆ `gradientDescent.R` - Function to run gradient descent
  - † `computeCostMulti.R` - Cost function for multiple variables
  - † `gradientDescentMulti.R` - Gradient descent for multiple variables
  - † `featureNormalize.R` - Function to normalize features
  - † `normalEqn.R` - Function to compute the normal equations

⋆ indicates files you will need to complete and † indicates optional
exercises

Throughout the exercise, you will be using the scripts `ex1.R` and
`ex1_multi.R`. These scripts set up the dataset for the problems and
make calls to functions that you will write. You do not need to modify
either of them. You are only required to modify functions in other
files, by following the instructions in this assignment. For this
programming exercise, you are only required to complete the first part
of the exercise to implement linear regression with one variable. The
second part of the exercise, which is optional, covers linear regression
with multiple variables.

### Where to get help

The exercises in this course use R, a high-level programming language
well-suited for numerical computations. If you do not have R installed,
please download a Windows installer from
[r-project](https://cran.r-project.org/bin/windows/base/) website.
[R-Studio](https://rstudio.com/products/rstudio/download/) is a free and
open-source R integrated development environment (IDE) making R script
development a bit easier when compared to R basic GUI. You may start
from the `.Rproj` (a R-Studio project file) in each exercise directory.
At the R command line, typing help followed by a function name displays
documentation for a built-in function. For example, `help('plot')` or
simply `?plot` will bring up help information for plotting. Further
documentation for R functions can be found at the R documentation pages.

## 1 Simple R function

The first part of `ex1.R` gives you practice with R syntax and the
homework submission process. In the file `warmUpExercise.R`, you will
find the outline of an R function. Modify it to return a 5 x 5 identity
matrix by filling in the following code:

``` r
A <- diag(5)
```

When you are finished, run `ex1.R` (assuming you are in the correct
directory, type `source("ex1.R")` at the R prompt) and you should see
output similar to the following:

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    0    0    0    0
    ## [2,]    0    1    0    0    0
    ## [3,]    0    0    1    0    0
    ## [4,]    0    0    0    1    0
    ## [5,]    0    0    0    0    1

Now `ex1.R` will pause until you press any key, and then will run the
code for the next part of the assignment. If you wish to quit, typing
<kbd>ctrl-c</kbd> will stop the program in the middle of its run.

### 1.1 Submitting Solutions

After completing a part of the exercise, you can submit your solutions
for grading by typing submit at the R command line. The submission
script will prompt you for your login e-mail and submission token and
ask you which files you want to submit. You can obtain a submission
token from the web page for the assignment.

*You should now submit your solutions.*

You are allowed to submit your solutions multiple times, and we will
take only the highest score into consideration.

## 2 Linear regression with one variable

In this part of this exercise, you will implement linear regression with
one variable to predict profits for a food truck. Suppose you are the
CEO of a restaurant franchise and are considering different cities for
opening a new outlet. The chain already has trucks in various cities and
you have data for profits and populations from the cities.

You would like to use this data to help you select which city to expand
to next. The file `ex1data1.txt` contains the dataset for our linear
regression problem. The first column is the population of a city and the
second column is the profit of a food truck in that city. A negative
value for profit indicates a loss. The `ex1.R` script has already been
set up to load this data for you.

### 2.1 Plotting the Data

Before starting on any task, it is often useful to understand the data
by visualizing it. For this dataset, you can use a scatter plot to
visualize the data, since it has only two properties to plot (profit and
population). (Many other problems that you will encounter in real life
are multi-dimensional and can’t be plotted on a 2-d plot.) In `ex1.R`,
the dataset is loaded from the data file into the variables X and y:

``` r
data <- read.table("ex1data1.txt",sep=',')
X <- data[, 1]
y <- data[, 2]
m <- length(y) # number of training examples
```

Next, the script calls the plotData function to create a scatter plot of
the data. Your job is to complete `plotData.R` to draw the plot; modify
the file and fill in the following code:

``` r
plot(x, y, col = "red", pch = 4,cex = 1.1,lwd = 2,
    xlab = 'Profit in $10,000s',
    ylab = 'Population of City in 10,000s')
```

Now, when you continue to run `ex1.R`, our end result should look like
Figure 1, with the same red “x” markers and axis labels. To learn more
about the plot command, you can type `?plot` at the R command prompt or
to search for plotting documentation. (To change the markers to red “x”,
we used the option `pch=4` together with the plot command, i.e.,
`plot(..,[your options here],.., pch="4")` )

<div class="figure" style="text-align: center">

<img src="instruction_files/figure-gfm/unnamed-chunk-4-1.png" alt="Figure 1: Scatter plot of training data"  />

<p class="caption">

Figure 1: Scatter plot of training data

</p>

</div>

### 2.2 Gradient Descent

In this part, you will fit the linear regression parameters
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta") to
our dataset using gradient descent.

#### 2.2.1 Update Equations

The objective of linear regression is to minimize the cost function

  
![ J(\\theta)= \\frac{1}{2m} \\sum\_{i=1}^m (h\_\\theta
(x^{(i)})-y^{(i)})^2
](https://latex.codecogs.com/png.latex?%20J%28%5Ctheta%29%3D%20%5Cfrac%7B1%7D%7B2m%7D%20%5Csum_%7Bi%3D1%7D%5Em%20%28h_%5Ctheta%20%28x%5E%7B%28i%29%7D%29-y%5E%7B%28i%29%7D%29%5E2%20
" J(\\theta)= \\frac{1}{2m} \\sum_{i=1}^m (h_\\theta (x^{(i)})-y^{(i)})^2 ")  

where the hypothesis
![h\_\\theta(x)](https://latex.codecogs.com/png.latex?h_%5Ctheta%28x%29
"h_\\theta(x)") is given by the linear model

  
![ h\_\\theta(x)=\\theta^Tx=\\theta\_0+\\theta\_1x\_1
](https://latex.codecogs.com/png.latex?%20h_%5Ctheta%28x%29%3D%5Ctheta%5ETx%3D%5Ctheta_0%2B%5Ctheta_1x_1%20
" h_\\theta(x)=\\theta^Tx=\\theta_0+\\theta_1x_1 ")  

Recall that the parameters of your model are the
![\\theta\_j](https://latex.codecogs.com/png.latex?%5Ctheta_j
"\\theta_j") values. These are the values you will adjust to minimize
cost ![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)"). One way to do this is to use the batch gradient descent
algorithm. In batch gradient descent, each iteration performs the
update:

<center>

![\\displaystyle
\\theta\_j:=\\theta\_j-\\alpha\\frac{1}{m}\\sum\_{i=1}^m (h\_\\theta
(x^{(i)})-y^{(i)})x\_j^{(i)}](https://latex.codecogs.com/png.latex?%5Cdisplaystyle%20%5Ctheta_j%3A%3D%5Ctheta_j-%5Calpha%5Cfrac%7B1%7D%7Bm%7D%5Csum_%7Bi%3D1%7D%5Em%20%28h_%5Ctheta%20%28x%5E%7B%28i%29%7D%29-y%5E%7B%28i%29%7D%29x_j%5E%7B%28i%29%7D
"\\displaystyle \\theta_j:=\\theta_j-\\alpha\\frac{1}{m}\\sum_{i=1}^m (h_\\theta (x^{(i)})-y^{(i)})x_j^{(i)}")
(simultaneously update
![\\theta\_j](https://latex.codecogs.com/png.latex?%5Ctheta_j
"\\theta_j") for all ![j](https://latex.codecogs.com/png.latex?j "j")).

</center>

With each step of gradient descent, your parameters
![\\theta\_j](https://latex.codecogs.com/png.latex?%5Ctheta_j
"\\theta_j") come closer to the optimal values that will achieve the
lowest cost
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)").

-----

**Implementation Note:** We store each example as a row in the the X
matrix in R. To take into account the intercept term
(![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0")), we add an additional first column to X and set it to all
ones. This allows us to treat
![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0") as simply another ‘feature’.

-----

#### 2.2.2 Implementation

In `ex1.R`, we have already set up the data for linear regression. In
the following lines, we add another dimension to our data to accommodate
the ![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0") intercept term. We also initialize the initial parameters
to 0 and the learning rate alpha to 0.02.

``` r
X <- cbind(rep(1,m),X) # Add a column of ones to x
X <- as.matrix(X)
# initialize fitting parameters
theta <- c(8,3)

# Some gradient descent settings
iterations <- 1500
alpha <- 0.02
```

#### 2.2.3 Computing the cost ![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29 "J(\\theta)")

As you perform gradient descent to learn minimize the cost function
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)"), it is helpful to monitor the convergence by computing the
cost. In this section, you will implement a function to calculate
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") so you can check the convergence of your gradient descent
implementation. Your next task is to complete the code in the file
`computeCost.R`, which is a function that computes
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)"). As you are doing this, remember that the variables X and
y are not scalar values, but matrices whose rows represent the examples
from the training set. Once you have completed the function, the next
step in `ex1.R` will run `computeCost` once using
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta")
initialized to zeros, and you will see the cost printed to the screen.
You should expect to see a cost of 32.07.

*You should now submit your solutions.*

#### 2.2.4 Gradient descent

Next, you will implement gradient descent in the file
`gradientDescent.R`. The loop structure has been written for you, and
you only need to supply the updates to
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta")
within each iteration. As you program, make sure you understand what you
are trying to optimize and what is being updated. Keep in mind that the
cost ![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") is parameterized by the vector
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta"), not
X and y. That is, we minimize the value of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") by changing the values of the vector
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta"), not
by changing X or y. Refer to the equations in this handout and to the
video lectures if you are uncertain. A good way to verify that gradient
descent is working correctly is to look at the value of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") and check that it is decreasing with each step. The
starter code for `gradientDescent.R` calls `computeCost` on every
iteration and prints the cost. Assuming you have implemented gradient
descent and `computeCost` correctly, your value of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") should never increase, and should converge to a steady
value by the end of the algorithm. After you are finished, `ex1.R` will
use your final parameters to plot the linear fit. The result should look
something like Figure 2. Your final values for
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta") will
also be used to make predictions on profits in areas of 35,000 and
70,000 people. Note the way that the following lines in `ex1.R` uses
matrix multiplication, rather than explicit summation or looping, to
calculate the predictions. This is an example of code vectorization in
R.

*You should now submit your solutions.*

``` r
predict1 <- c(1, 3.5) %*% theta
predict2 <- c(1, 7) %*% theta
```

### 2.3 Debugging

Here are some things to keep in mind as you implement gradient descent:

  - R vector indices start from one, not zero. If you’re storing
    ![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
    "\\theta_0") and
    ![\\theta\_1](https://latex.codecogs.com/png.latex?%5Ctheta_1
    "\\theta_1") in a vector called `theta`, the values will be
    `theta[1]` and `theta[2]`.

  - If you are seeing many errors at runtime, inspect your matrix
    operations to make sure that you’re adding and multiplying matrices
    of compatible dimensions. Printing the dimensions of matrices with
    the `dim()` command and the length of vectors with `length()`
    command will help you debug.

<div class="figure" style="text-align: center">

<img src="instruction_files/figure-gfm/unnamed-chunk-7-1.png" alt="Figure 2: Training data with linear regression fit"  />

<p class="caption">

Figure 2: Training data with linear regression fit

</p>

</div>

  - By default, R interprets math operators to be element-wise
    operators. If you want matrix multiplication, you need to add the
    “%” notation before and after the operator to specify this to R.
    For example, `A %*% B` does a matrix multiply, while `A*B` does an
    element-wise multiplication.

### 2.4 Visualizing ![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29 "J(\\theta)")

To understand the cost function
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") better, you will now plot the cost over a 2-dimensional
grid of ![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0") and
![\\theta\_1](https://latex.codecogs.com/png.latex?%5Ctheta_1
"\\theta_1") values. You will not need to code anything new for this
part, but you should understand how the code you have written already is
creating these images. In the next step of `ex1.R`, there is code set up
to calculate
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") over a grid of values using the `computeCost` function
that you wrote.

``` r
# initialize J_vals to a matrix of 0's
J_vals <- matrix(0, length(theta0_vals), length(theta1_vals))

# Fill out J_vals
for (i in 1:length(theta0_vals)) {
    for (j in 1:length(theta1_vals)) {
      J_vals[i,j] <- computeCost(X, y, c(theta0_vals[i], theta1_vals[j]))
    }
}
```

After these lines are executed, you will have a 2-D array of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") values. The script `ex1.R` will then use these values to
produce surface and contour plots of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") using the `persp` and `contour` commands. The plots should
look something like Figure 3:

<div class="figure" style="text-align: center">

<img src="instruction_files/figure-gfm/unnamed-chunk-10-1.png" alt="Figure 3: Cost function $J(\theta)$"  />

<p class="caption">

Figure 3: Cost function
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)")

</p>

</div>

The purpose of these graphs is to show you that how
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") varies with changes in
![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0") and
![\\theta\_1](https://latex.codecogs.com/png.latex?%5Ctheta_1
"\\theta_1"). The cost function
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") is bowl-shaped and has a global mininum. (This is easier
to see in the contour plot than in the 3D surface plot). This minimum is
the optimal point for
![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0") and
![\\theta\_1](https://latex.codecogs.com/png.latex?%5Ctheta_1
"\\theta_1"), and each step of gradient descent moves closer to this
point.

-----

#### Optional Exercises

If you have successfully completed the material above, congratulations\!
You now understand linear regression and should able to start using it
on your own datasets. For the rest of this programming exercise, we have
included the following optional exercises. These exercises will help you
gain a deeper understanding of the material, and if you are able to do
so, we encourage you to complete them as well.

-----

## 3 Linear regression with multiple variables

In this part, you will implement linear regression with multiple
variables to predict the prices of houses. Suppose you are selling your
house and you want to know what a good market price would be. One way to
do this is to first collect information on recent houses sold and make a
model of housing prices. The file `ex1data2.txt` contains a training set
of housing prices in Portland, Oregon. The first column is the size of
the house (in square feet), the second column is the number of bedrooms,
and the third column is the price of the house. The `ex1_multi.R` script
has been set up to help you step through this exercise.

### 3.1 Feature Normalization

The `ex1_multi.R` script will start by loading and displaying some
values from this dataset. By looking at the values, note that house
sizes are about 1000 times the number of bedrooms. When features differ
by orders of magnitude, first performing feature scaling can make
gradient descent converge much more quickly.

Your task here is to complete the code in `featureNormalize.R` to

  - Subtract the mean value of each feature from the dataset.
  - After subtracting the mean, additionally scale (divide) the feature
    values by their respective “standard deviations.”

The standard deviation is a way of measuring how much variation there is
in the range of values of a particular feature (most data points will
lie within ![\\pm 2](https://latex.codecogs.com/png.latex?%5Cpm%202
"\\pm 2") standard deviations of the mean); this is an alternative to
taking the range of values (max-min). In R, you can use the `sd`
function to compute the standard deviation. For example, inside
`featureNormalize.R`, the quantity `X[,1]` contains all the values of
![x\_1](https://latex.codecogs.com/png.latex?x_1 "x_1") (house sizes) in
the training set, so `sd(X[,1])` computes the standard deviation of the
house sizes. At the time that `featureNormalize.R` is called, the extra
column of 1’s corresponding to
![x\_{\\theta}=1](https://latex.codecogs.com/png.latex?x_%7B%5Ctheta%7D%3D1
"x_{\\theta}=1") has not yet been added to X (see `ex1_multi.R` for
details). You will do this for all the features and your code should
work with datasets of all sizes (any number of features / examples).
Note that each column of the matrix X corresponds to one feature.

*You should now submit your solutions.*

-----

**Implementation Note:** When normalizing the features, it is important
to store the values used for normalization - the mean value and the
standard deviation used for the computations. After learning the
parameters from the model, we often want to predict the prices of houses
we have not seen before. Given a new x value (living room area and
number of bedrooms), we must first normalize x using the mean and
standard deviation that we had previously computed from the training
set.

-----

### 3.2 Gradient Descent

Previously, you implemented gradient descent on a univariate regression
problem. The only difference now is that there is one more feature in
the matrix X. The hypothesis function and the batch gradient descent
update rule remain unchanged. You should complete the code in
`computeCostMulti.R` and `gradientDescentMulti.R` to implement the cost
function and gradient descent for linear regression with multiple
variables. If your code in the previous part (single variable) already
supports multiple variables, you can use it here too. Make sure your
code supports any number of features and is well-vectorized. You can use
`nrow(X)` to find out how many rows (objects) are present in the
dataset.

*You should now submit your solutions.*

-----

**Implementation Note:** In the multivariate case, the cost function can
also be written in the following vectorized form:

  
![J(\\theta)=\\frac{1}{2m} (X\\theta-\\vec{y})^T
\\,(X\\theta-\\vec{y})](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29%3D%5Cfrac%7B1%7D%7B2m%7D%20%28X%5Ctheta-%5Cvec%7By%7D%29%5ET%20%5C%2C%28X%5Ctheta-%5Cvec%7By%7D%29
"J(\\theta)=\\frac{1}{2m} (X\\theta-\\vec{y})^T \\,(X\\theta-\\vec{y})")  

where

  
![ X=\\begin{pmatrix} &#10;\\ldots & (x^{(1)})^T & \\ldots
\\\\&#10;\\ldots & (x^{(2)})^T & \\ldots \\\\&#10; & \\vdots &
\\\\&#10;\\ldots & (x^{(m)})^T &
\\ldots&#10;\\end{pmatrix}&#10;\\qquad&#10;\\vec{y}=\\begin{pmatrix}&#10;y^{(1)}
\\\\&#10;y^{(2)} \\\\&#10;\\vdots
\\\\&#10;y^{(m)}&#10;\\end{pmatrix}&#10;](https://latex.codecogs.com/png.latex?%20X%3D%5Cbegin%7Bpmatrix%7D%20%0A%5Cldots%20%26%20%28x%5E%7B%281%29%7D%29%5ET%20%26%20%5Cldots%20%5C%5C%0A%5Cldots%20%26%20%28x%5E%7B%282%29%7D%29%5ET%20%26%20%5Cldots%20%5C%5C%0A%20%26%20%5Cvdots%20%26%20%5C%5C%0A%5Cldots%20%26%20%28x%5E%7B%28m%29%7D%29%5ET%20%26%20%5Cldots%0A%5Cend%7Bpmatrix%7D%0A%5Cqquad%0A%5Cvec%7By%7D%3D%5Cbegin%7Bpmatrix%7D%0Ay%5E%7B%281%29%7D%20%5C%5C%0Ay%5E%7B%282%29%7D%20%5C%5C%0A%5Cvdots%20%5C%5C%0Ay%5E%7B%28m%29%7D%0A%5Cend%7Bpmatrix%7D%0A
" X=\\begin{pmatrix} 
\\ldots & (x^{(1)})^T & \\ldots \\\\
\\ldots & (x^{(2)})^T & \\ldots \\\\
 & \\vdots & \\\\
\\ldots & (x^{(m)})^T & \\ldots
\\end{pmatrix}
\\qquad
\\vec{y}=\\begin{pmatrix}
y^{(1)} \\\\
y^{(2)} \\\\
\\vdots \\\\
y^{(m)}
\\end{pmatrix}
")  

The vectorized version is efficient when you’re working with numerical
computing tools like R. If you are an expert with matrix operations, you
can prove to yourself that the two forms are equivalent.

-----

#### 3.2.1 Optional (ungraded) exercise: Selecting learning rates

In this part of the exercise, you will get to try out different learning
rates for the dataset and find a learning rate that converges quickly.
You can change the learning rate by modifying `ex1_multi.R` and changing
the part of the code that sets the learning rate. The next phase in
`ex1_multi.R` will call your `gradientDescent.R` function and run
gradient descent for about 50 iterations at the chosen learning rate.
The function should also return the history of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") values in a vector J. After the last iteration, the
`ex1_multi.R` script plots the J values against the number of the
iterations. If you picked a learning rate within a good range, your plot
looks similar to Figure 4. If your graph looks very different,
especially if your value of
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") increases or even blows up, adjust your learning rate and
try again. We recommend trying values of the learning rate
![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\\alpha") on a
log-scale, at multiplicative steps of about 3 times the previous value
(i.e., 0.3, 0.1, 0.03, 0.01 and so on). You may also want to adjust the
number of iterations you are running if that will help you see the
overall trend in the curve.

<div class="figure" style="text-align: center">

<img src="instruction_files/figure-gfm/unnamed-chunk-11-1.png" alt="Figure 4: Convergence of gradient descent with an appropriate learning rate"  />

<p class="caption">

Figure 4: Convergence of gradient descent with an appropriate learning
rate

</p>

</div>

-----

**Implementation Note:** If your learning rate is too large,
![J(\\theta)](https://latex.codecogs.com/png.latex?J%28%5Ctheta%29
"J(\\theta)") can diverge and ‘blow up’, resulting in values which are
too large for computer calculations. In these situations, R will tend to
return `NaNs` or `Inf`. NaN stands for ‘not a number’ and is often
caused by undefined operations that involve
![\\pm\\infty](https://latex.codecogs.com/png.latex?%5Cpm%5Cinfty
"\\pm\\infty").

-----

**R Tip:** To compare how different learning learning rates affect
convergence, it’s helpful to plot J for several learning rates on the
same figure. In R, this can be done by first setting up the first
`plot(..., type='l')` and then calling `lines(...)` multiple times.
Concretely, if you’ve tried three different values of
![\\alpha](https://latex.codecogs.com/png.latex?%5Calpha "\\alpha") (you
should probably try more values than this) and stored the costs in J1,
J2 and J3, you can use the following commands to plot them on the same
figure:

``` r
plot(1:50, J1[1:50], col=1, type='l')
lines(1:50, J2[1:50], col=2)
lines(1:50, J3[1:50], col=3)
```

The final argument `col` specifies different colors for the plots.

-----

Notice the changes in the convergence curves as the learning rate
changes. With a small learning rate, you should find that gradient
descent takes a very long time to converge to the optimal value.
Conversely, with a large learning rate, gradient descent might not
converge or might even diverge\! Using the best learning rate that you
found, run the `ex1_multi.R` script to run gradient descent until
convergence to find the final values of
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta").
Next, use this value of
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta") to
predict the price of a house with 1650 square feet and 3 bedrooms. You
will use this value later to check your implementation of the normal
equations. Don’t forget to normalize your features when you make this
prediction\!

You do not need to submit any solutions for these optional (ungraded)
exercises.

### 3.3 Normal Equations

In the lecture videos, you learned that the closed-form solution to
linear regression is

  
![ \\theta = (X^T X)^{-1} X^T \\vec{y}.
](https://latex.codecogs.com/png.latex?%20%5Ctheta%20%3D%20%28X%5ET%20X%29%5E%7B-1%7D%20X%5ET%20%5Cvec%7By%7D.%20
" \\theta = (X^T X)^{-1} X^T \\vec{y}. ")  

Using this formula does not require any feature scaling, and you will
get an exact solution in one calculation: there is no “loop until
convergence” like in gradient descent. Complete the code in
`normalEqn.R` to use the formula above to calculate
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta").
Remember that while you don’t need to scale your features, we still need
to add a column of 1’s to the X matrix to have an intercept term
(![\\theta\_0](https://latex.codecogs.com/png.latex?%5Ctheta_0
"\\theta_0")). The code in `ex1.R` will add the column of 1’s to X for
you.

*You should now submit your solutions.*

*Optional (ungraded) exercise:* Now, once you have found
![\\theta](https://latex.codecogs.com/png.latex?%5Ctheta "\\theta")
using this method, use it to make a price prediction for a
1650-square-foot house with 3 bedrooms. You should find that gives the
same predicted price as the value you obtained using the model fit with
gradient descent (in Section 3.2.1).

## Submission and Grading

After completing various parts of the assignment, be sure to use the
submit function to submit your solutions to our servers. The following
is a breakdown of how each part of this exercise is scored.

| Part                              |   Submitted File    |   Points   |
| :-------------------------------- | :-----------------: | :--------: |
| Warm up exercise                  | `warmUpExercise.R`  | 10 points  |
| Compute cost for one variable     |   `computeCost.R`   | 40 points  |
| Gradient descent for one variable | `gradientDescent.R` | 50 points  |
| Total Points                      |                     | 100 points |

### Optional Exercises

| Part                                    |      Submitted File      |  Points  |
| :-------------------------------------- | :----------------------: | :------: |
| Feature normalization                   |   `featureNormalize.R`   | 0 points |
| Compute cost for multiple variables     |   `computeCostMulti.R`   | 0 points |
| Gradient descent for multiple variables | `gradientDescentMulti.R` | 0 points |
| Normal Equations                        |      `normalEqn.R`       | 0 points |

You are allowed to submit your solutions multiple times, and we will
take only the highest score into consideration.
