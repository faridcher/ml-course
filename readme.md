## Introduction
This is one of the best massive open online courses (MOOCs) on machine learning and is taught by Prof. Andrew NG. However, Prof. NG teaches the course along with MATLAB/Octave and the programming exercises must be done and submitted with either of them. Do you like the course but not the proprietary MATLAB or the sluggish Octave? Or for any reason, would you rather to use the free GNU R to complete the programming exercises?

To watch the lecture videos and slides please visit the [course original website](https://www.coursera.org/learn/machine-learning). This repository provides the starter code to solve the programming exercises in R statistical software. Simply follow these steps to complete the programming exercises:

1. Watch the lecture videos
2. Read R compatible version of instructions which are available as [wiki](https://github.com/faridcher/machine-learning-course/wiki) pages
3. fill the parts of the code that are written "YOUR CODE HERE"
4. If you couldn't solve it by yourself, get help from the accompanied file suffixed by `-solution` inside the same directory of the starter code. For example, `starter/ex1/computeCost.r` has an associated solution file named `starter/ex1/computeCost-solution.r`
5. Submit

## Dependencies
In order to produce similar results and plots to Octave/MATLAB, you should install a few packages (`install.packages(c('rgl','lbfgsb3c','SnowballC','jsonlite', 'httr'))`):

- `rgl` package is used to produce the 3D scatter plots and surface plots in the exercises 1 and 7.
- `lbfgsb3c`: to solve large optimization tasks in exercises 4 and 8
- `SnowballC`: `portStemmer` function in this package plays the same role of the `portStemmer.m` in exercise 6
- `jsonlite` and `httr` packages are needed for submissions.

Furthermore, the `ginv` (generalized inverse) function in `MASS` package doesn't produce the same result of the MATLAB `pinv` (pseudo-inverse). So `lib/pinv.r` is the modified version of `MASS::ginv` to produce the same result of the MATLAB `pinv`. 

## Submission
After completing each assignment, `source("submit.r")`  and then `submit()` in your R console. I submitted the solutions to Coursera for testing and the scores were 100%. Please report any problems with submission here. 

## Licence
This project is released under MIT to the extent it is original.
