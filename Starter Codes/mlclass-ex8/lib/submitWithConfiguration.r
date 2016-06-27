submitWithConfiguration = function(conf) {
  
  cat(sprintf('== Submitting solutions | %s... \n', conf$itemName))

  tokenFile = 'lib/token.rda';
  if (file.exists(tokenFile)){
    load(tokenFile)
    ptt = promptToken(ptt$email, ptt$token, tokenFile)
    email = ptt$email
    token = ptt$token
  }else{
    ptt = promptToken('', '', tokenFile)
    email = ptt$email
    token = ptt$token
  }

  if (token==''){
    cat('!! Submission Cancelled')
    return
  }
  
  response <<- tryCatch(
    {
      submitParts(conf, email, token)
    }, 
    error = function(e)
    {
      cat(sprintf('!! Submission failed: unexpected error: %s\n',e$message))
      cat(sprintf('!! Please try again later.'))
      return
    }
  )
  
  if (is.null(response)){
    return
  }else if (!is.null(response$errorMessage)){
    cat(sprintf('!! Submission failed: %s \n', response$errorMessage))
  }else{
    showFeedback(conf$partArrays, response)
    save(ptt,file=tokenFile )
  }
}

promptToken <- function (email, existingToken, tokenFile){
  if (email!='' && existingToken!=''){
    cat(sprintf('Use token from last successful submission (%s)? (Y/n): ', email))
    
    reenter = readLines(con = stdin(),1)
    if (reenter=='' || reenter == 'Y' || reenter == 'y'){
      #token = existingToken
      return (list(email=email, token=existingToken))
    } else
      file.remove(tokenFile)
  }
  cat('Login (email address): ')
  email = readLines(con = stdin(),1)
  cat('token:')
  token = readLines(con = stdin(),1)
  list(email=email, token=token)
}

submitParts <- function(conf, email, token){
  bodys = makePostBody(conf, email, token)
  submissionUrl = submissionUrl()
  #params = {'jsonBody', body}
  
  js = jsonlite::toJSON(bodys)
  js = gsub('[\\[\\]]','',js,perl = T)
  params = list(jsonBody=js)
  r = httr::POST(submissionUrl, body = params, encode = "form")
  response=httr::content(r,as = "parsed")
}

makePostBody = function(conf, email, token){
  bodyStruct = list()
  bodyStruct$assignmentSlug = conf$assignmentSlug
  bodyStruct$submitterEmail = email
  bodyStruct$secret = token
  bodyStruct$parts = makePartsStruct(conf)
  bodyStruct
}

makePartsStruct = function(conf){
  parts = list()
  for (row in 1:nrow(conf$partArrays)){
    partId = conf$partArrays[row,1]
    output1 = conf$output(partId)
    parts[[partId]] <- list(output=output1)
  }
  parts
}

showFeedback <- function (parts, response){
  cat('== \n')
  cat(sprintf('== %43s | %9s | %-s\n', 'Part Name', 'Score', 'Feedback'))
  cat(sprintf('== %43s | %9s | %-s\n', '---------', '-----', '--------'))
  for (i in 1:nrow(parts)){
    ii <- which(names(response$partFeedbacks) == parts[i,1])
    partFeedback = response$partFeedbacks[[ii]]
    partEvaluation = response$partEvaluations[[ii]]
    score = sprintf('%d / %3d', partEvaluation$score, partEvaluation$maxScore)
    cat(sprintf('== %43s | %9s | %-s\n', parts[i,3], score, partFeedback))
  }
  evaluation = response$evaluation
  totalScore = sprintf('%d / %d', evaluation$score, evaluation$maxScore)
  cat(sprintf('==                                   --------------------------------\n'))
  cat(sprintf('== %43s | %9s | %-s\n', '', totalScore, ''))
  cat('== ')
}

###############################################################################
#
# Service configuration
#
###############################################################################
submissionUrl = function(){
  submissionUrl = 'https://www-origin.coursera.org/api/onDemandProgrammingImmediateFormSubmissions.v1';
}
