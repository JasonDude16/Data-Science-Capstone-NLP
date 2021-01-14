predictWord <- function(df, text) {

  if (!isNamespaceLoaded("dplyr")) {
    return(print("dplyr package is not loaded"))
  }

  if (!isNamespaceLoaded("quanteda")) {
    return(print("quanteda package is not loaded"))
  }
  
  if (!isNamespaceLoaded("stringr")) {
    return(print("stringr package is not loaded"))
  }

  if (!is.character(text)) {
    return(print("Text input must be a character vector"))
  }
  
  source("./functions/tokenize.R")
  
  toke <- tokenize(text)
  
  if (ntoken(toke) == 1) {
    ngram <- tokens_ngrams(toke, n = 1)
  } else if (ntoken(toke) == 2) {
    ngram <- tokens_ngrams(toke, n = 2)
  } else {
    ngram <- tokens_ngrams(toke, n = 3)
    ngram <- ngram[[1]][ntoken(ngram)]
  }
  
  prediction <- 
    df %>%
    dplyr::filter(str_detect(feature, paste(ngram, "_", sep = ""))) %>% 
    dplyr::arrange(desc(frequency)) %>% 
    dplyr::slice(1:3)
  
  word1 <- stringr::str_split(prediction$feature, "_")
  word1 <- word1[[1]][length(word1[[1]])]
  word2 <- stringr::str_split(prediction$feature, "_")
  word2 <- word2[[2]][length(word2[[2]])]
  word3 <- stringr::str_split(prediction$feature, "_")
  word3 <- word3[[3]][length(word3[[3]])]
  
  return(c(word1, word2, word3))
  
}
