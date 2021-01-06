readRand <- function(x, filepath, size = 10000) {
  file <- paste(filepath, "/", x, sep = "")
  sample <- sample(length(readLines(file)), size = size, replace = FALSE)
  dat <- readLines(file, encoding = "UTF-8", skipNul = TRUE)[sample]
}
