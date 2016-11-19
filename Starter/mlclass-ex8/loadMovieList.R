loadMovieList <- function() {
  #GETMOVIELIST reads the fixed movie list in movie.txt and returns a
  #cell array of the words
  #   movieList <- GETMOVIELIST() reads the fixed movie list in movie.txt
  #   and returns a cell array of the words in movieList.
  
  
  ## Read the fixed movieulary list
  fName <- 'movie_ids.txt'
  file_contents <- readChar(fName,file.info(fName)$size)
  
  movieList <- strsplit(file_contents,split = '\n')[[1]]
  movieList <- gsub('^[0-9]+ ','',movieList)
  
  movieList
  
}
