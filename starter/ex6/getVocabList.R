getVocabList  <- function() {
  #GETVOCABLIST reads the fixed vocabulary list in vocab.txt and returns a
  #cell array of the words
  #   vocabList <- GETVOCABLIST() reads the fixed vocabulary list in vocab.txt
  #   and returns a cell array of the words in vocabList.
  
  ## Read the fixed vocabulary list
  vocabList <-
  read.table('vocab.txt',sep = '\t',stringsAsFactors = FALSE)[,2]
  
  vocabList
}
