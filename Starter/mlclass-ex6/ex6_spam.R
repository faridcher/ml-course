## Machine Learning Online Class
#  Exercise 6 | Spam Classification with SVMs
#
#  Instructions
#  ------------
# 
#  This file contains code that helps you get started on the
#  exercise. You will need to complete the following functions:
#
#     gaussianKernel.R
#     dataset3Params.R
#     processEmail.R
#     emailFeatures.R
#
#  For this exercise, you will not need to change any code in this file,
#  or any other files other than those mentioned above.
#

## Initialization
rm(list=ls())
sources <- c("emailFeatures.R","getVocabList.R","linearKernel.R","bsxfun.R",
             "processEmail.R","svmPredict.R","svmTrain.R","meshgrid.R")

for (i in 1:length(sources)) {
  cat(paste("Loading ",sources[i],"\n"))
  source(sources[i])
}

# Install SnowballC package to support for wordStemmer.
# It is used in ProcessEmail.R
# install.packages("SnowballC")

## ---------------------- Part 1: Email Preprocessing ----------------------
#  To use an SVM to classify emails into Spam v.s. Non-Spam, you first need
#  to convert each email into a vector of features. In this part, you will
#  implement the preprocessing steps for each email. You should
#  complete the code in processEmail.R to produce a word indices vector
#  for a given email.

cat(sprintf('\nPreprocessing sample email (emailSample1.txt)\n'))

# Extract Features
fName <- 'emailSample1.txt'
file_contents <- readChar(fName,file.info(fName)$size)
word_indices  <- processEmail(file_contents)

# Print Stats
cat(sprintf('Word Indices: \n'))
cat(sprintf(' %d', word_indices))
cat(sprintf('\n\n'))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ---------------------- Part 2: Feature Extraction ----------------------
#  Now, you will convert each email into a vector of features in R^n. 
#  You should complete the code in emailFeatures.R to produce a feature
#  vector for a given email.

cat(sprintf('\nExtracting features from sample email (emailSample1.txt)\n'))

# Extract Features
fName <- 'emailSample1.txt'
file_contents <- readChar(fName,file.info(fName)$size)
word_indices  <- processEmail(file_contents)
features      <- emailFeatures(word_indices)

# Print Stats
cat(sprintf('Length of feature vector: %d\n', length(features)))
cat(sprintf('Number of non-zero entries: %d\n', sum(features > 0)))

cat(sprintf('Program paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## ------------- Part 3: Train Linear SVM for Spam Classification ----------
#  In this section, you will train a linear classifier to determine if an
#  email is Spam or Not-Spam.

# Load the Spam Email dataset
# You will have X, y in your environment
load('spamTrain.Rda')
list2env(data,.GlobalEnv)
rm(data)

cat(sprintf('\nTraining Linear SVM (Spam Classification)\n'))
cat(sprintf('(this may take 1 to 2 minutes) ...\n'))

C <- 0.1
model <- svmTrain(X, y, C, linearKernel)

p <- svmPredict(model, X)

cat(sprintf('Training Accuracy: %f\n', mean(p==y) * 100))

## -------------------- Part 4: Test Spam Classification -----------------
#  After training the classifier, we can evaluate it on a test set. We have
#  included a test set in spamTest.mat

# Load the test dataset
# You will have Xtest, ytest in your environment
load('spamTest.Rda')
list2env(data,.GlobalEnv)
rm(data)

cat(sprintf('\nEvaluating the trained Linear SVM on a test set ...\n'))

p <- svmPredict(model, Xtest)

cat(sprintf('Test Accuracy: %f\n', mean(p==ytest) * 100))
line <- readLines(con = stdin(),1)


## ------------------- Part 5: Top Predictors of Spam ----------------------
#  Since the model we are training is a linear SVM, we can inspect the
#  weights learned by the model to understand better how it is determining
#  whether an email is spam or not. The following code finds the words with
#  the highest weights in the classifier. Informally, the classifier
#  'thinks' that these words are the most likely indicators of spam.
#

# Sort the weights and obtin the vocabulary list
srt <- sort(model$w, decreasing = TRUE,index.return=TRUE)
weight <- srt$x
idx <- srt$ix
rm(srt)

vocabList <- getVocabList()

cat(sprintf('\nTop predictors of spam: \n'))
for (i in 1:15)
    cat(sprintf(' %-15s (%f) \n', vocabList[idx[i]], weight[i]))

cat(sprintf('\n\n'))
cat(sprintf('\nProgram paused. Press enter to continue.\n'))
line <- readLines(con = stdin(),1)

## -------------------- Part 6: Try Your Own Emails ---------------------
#  Now that you've trained the spam classifier, you can use it on your own
#  emails! In the starter code, we have included spamSample1.txt,
#  spamSample2.txt, emailSample1.txt and emailSample2.txt as examples. 
#  The following code reads in one of these emails and then uses your 
#  learned SVM classifier to determine whether the email is Spam or 
#  Not Spam

# Set the file to be read in (change this to spamSample2.txt,
# emailSample1.txt or emailSample2.txt to see different predictions on
# different emails types). Try your own emails as well!
fName <- 'spamSample1.txt'

# Read and predict
file_contents <- readChar(fName,file.info(fName)$size)
word_indices  <- processEmail(file_contents)
x             <- emailFeatures(word_indices)
p <- svmPredict(model, x)

cat(sprintf('\nProcessed %s\n\nSpam Classification: %d\n', fName, p))
cat(sprintf('(1 indicates spam, 0 indicates not spam)\n\n'))

