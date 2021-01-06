predictWord <- function(df, text) {

  require(dplyr)
  require(quanteda)
  require(stringr)
  
  source("./functions/tokenize.R")
  
  if (!is.character(text)) {
    return("Text input must be a character vector")
  }
  
  toke <- tokenize(text)
  
  ngram1 <- tokens_ngrams(toke, n = 1)
  
  if (ntoken(toke) > 1) {
    ngram2 <- tokens_ngrams(toke, n = 2)
    ngram_last <- ngram2[[1]][ntoken(ngram2)]
    prediction <- 
      df %>%
      dplyr::filter(str_detect(feature, paste(ngram_last, "_", sep = ""))) %>% 
      dplyr::arrange(desc(frequency)) %>% 
      dplyr::slice(1)
    return(stringr::str_split(prediction$feature, "_")[[1]][3])
  }
  
  if (ntoken(toke) == 1) {
    prediction <- 
      df %>%
      dplyr::filter(str_detect(feature, paste(ngram1, "_", sep = ""))) %>% 
      dplyr::arrange(desc(frequency)) %>% 
      dplyr::slice(1)
    return(stringr::str_split(prediction$feature, "_")[[1]][2])
  }
  
}
