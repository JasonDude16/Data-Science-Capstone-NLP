tokenize <- function(text, pattern_remove = NULL) {
 
  if (!isNamespaceLoaded("quanteda")) {
    return(print("quanteda package is not loaded"))
  }
  
  pattern <- pattern_remove
  
  toke <- tokens(x = text, 
                 remove_punct = TRUE, 
                 remove_symbols = TRUE, 
                 remove_url = TRUE, 
                 remove_numbers = TRUE, 
                 remove_separators = TRUE)
  
  if (!is.null(pattern_remove)) {
    toke <- tokens_select(toke, pattern = pattern, selection = "remove")
  }
  
  toke <- tokens_tolower(toke)

  return(toke)
}
