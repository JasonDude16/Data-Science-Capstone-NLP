library(quanteda)
library(dplyr)
library(stringr)

source("./functions/readRand.R")
source("./functions/predictWord.R")
source("./functions/tokenize.R")

set.seed(123)
options(max.print = 100)

# READING DATA 
files <- list.files("./data")
dat <- sapply(files, readRand, filepath = "./data")
dat <- as.vector(dat)
profanity <- readLines("./profanity/profanity.txt")

# TOKENIZATION ------------------------------------------------------------

toke <- tokenize(text = dat, pattern_remove = profanity)

dat_tokens_1 <- tokens_ngrams(toke, n = 1)
dat_tokens_2 <- tokens_ngrams(toke, n = 2)
dat_tokens_3 <- tokens_ngrams(toke, n = 3)


# CLEAN WORKSPACE
rm(toke)

# DOCUMENT TERM FREQUENCY MATRIX ------------------------------------------

dat_dfm_1 <- dfm(dat_tokens_1)
dat_dfm_2 <- dfm(dat_tokens_2)
dat_dfm_3 <- dfm(dat_tokens_3)

# SUMMARY
nfeat(dat_dfm_2)
featnames(dat_dfm_2)[1:100]
nsentence(dat)[1:100]
topfeatures(dat_dfm_2, n = 100, decreasing = T)
topfeatures(dat_dfm_2, n = 100, decreasing = F)
textstat_summary(dat_dfm_2)[1:10,]
textstat_frequency(dat_dfm_2)[1:10,]

# TEXT_STAT_SUMMARY -------------------------------------------------------

text_freq1 <- textstat_frequency(dat_dfm_1)
text_freq2 <- textstat_frequency(dat_dfm_2)
text_freq3 <- textstat_frequency(dat_dfm_3)

# N-GRAM LANGUAGE MODELING ------------------------------------------------
predictWord(text_freq2, c("new"))
predictWord(text_freq3, c("new york"))
predictWord(text_freq3, c("new york city"))
