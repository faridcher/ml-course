processEmail <- function(email_contents) {
  #PROCESSEMAIL preprocesses a the body of an email and
  #returns a list of word_indices
  #   word_indices <- PROCESSEMAIL(email_contents) preprocesses
  #   the body of an email and returns a list of indices of the
  #   words contained in the email.
  #
  
  # Load Vocabulary
  vocabList <- getVocabList()
  
  # Init return value
  # word_indices
  
  # ---------------------------- Preprocess Email ---------------------------
  
  # Find the Headers ( \n\n and remove )
  # Uncomment the following lines if you are working with raw emails with the
  # full headers
  
  # hdrstart <- strfind(email_contents, ([char(10) char(10)]))
  # email_contents <- email_contents(hdrstart(1):})
  
  # Lower case
  email_contents <- tolower(email_contents)
  
  # Strip all HTML
  # Looks for any expression that starts with < and ends with > and replace
  # and does not have any < or > in the tag it with a space
  email_contents <- gsub('<[^<>]+>', ' ',email_contents)
  
  # Handle Numbers
  # Look for one or more characters between 0-9
  email_contents <- gsub('[0-9]+', 'number',email_contents)
  
  # Handle URLS
  # Look for strings starting with http:// or https://
  email_contents <-
    gsub('(http|https)://[^\\s]*', 'httpaddr',email_contents ,perl = TRUE)
  
  # Handle Email Addresses
  # Look for strings with @ in the middle
  email_contents <-
    gsub('[^\\s]+@[^\\s]+', 'emailaddr',email_contents,perl = TRUE)
  
  # Handle $ sign
  email_contents <- gsub('[$]+', 'dollar',email_contents)
  
  
  # ---------------------------- Tokenize Email ---------------------------
  
  # Output the email to screen as well
  cat(sprintf('\n----- Processed Email -----\n\n'))
  
  # Process file
  l <- 0
  
  # Tokenize and also get rid of any punctuation
  splitters <- paste(" @$/#.-:&*+<-[]?!(){},'\">_<;#",
                     intToUtf8(10), #newline
                     intToUtf8(13), #tab
                     sep = '')
  
  for (i in 1:nchar(splitters))
  {
    email_contents <-
      strsplit(email_contents, substr(splitters,i,i),fixed = TRUE)
    sp <- ""
    for (i in 1:length(email_contents)) {
      sp <- c(sp,email_contents[[i]])
    }
    email_contents <- sp
  }
  #remove empty string
  email_contents <- email_contents[email_contents != ""]
  
  # Remove any non alphanumeric characters
  email_contents <- gsub('[^a-zA-Z0-9]', '',email_contents)
  
  # Stem the word
  # (the porterStemmer sometimes has issues, so we use a try catch block)
  
  #try({str <- porterStemmer(strtrim(str))},
  #finally={str <- ''})
  
  require(SnowballC)
  email_contents <- SnowballC::wordStem(email_contents)
  
  # Skip the word if it is too short
  #if (nchar(str) < 1)
  #   next
  
  # Look up the word in the dictionary and add to word_indices if
  # found
  # ----------------------- YOUR CODE HERE -----------------------
  # Instructions: Fill in this function to add the index of str to
  #               word_indices if it is in the vocabulary. At this point
  #               of the code, you have a stemmed word from the email in
  #               the variable str. You should look up str in the
  #               vocabulary list (vocabList). If a match exists, you
  #               should add the index of the word to the word_indices
  #               vector. Concretely, if str <- 'action', then you should
  #               look up the vocabulary list to find where in vocabList
  #               'action' appears. For example, if vocabList{18} <-
  #               'action', then, you should add 18 to the word_indices
  #               vector (e.g., word_indices <- [word_indices ; 18]; ).
  #
  # Note: vocabList{idx} returns a the word with index idx in the
  #       vocabulary list.
  #
  # Note: You can use strcmp(str1, str2) to compare two strings (str1 and
  #       str2). It will return 1 only if the two strings are equivalent.
  #
  
  word_indices <- match(email_contents, vocabList)
  word_indices <- word_indices[!is.na(word_indices)]
  
  # --------------------------------------------------------------
  
  cat(email_contents)
  
  # Print footer
  cat(sprintf('\n\n--------------------------\n'))
  
  word_indices
}
