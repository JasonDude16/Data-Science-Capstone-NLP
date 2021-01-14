library(quanteda)
library(dplyr)
library(stringr)

source("./functions/readRand.R")
source("./functions/predictWord.R")
source("./functions/tokenize.R")

set.seed(123)
options(max.print = 100)

# READING DATA ------------------------------------------------------------
files <- list.files("./data")
dat <- sapply(files, readRand, filepath = "./data")
dat <- as.vector(dat)
profanity <- readLines("./profanity/profanity.txt")

# TOKENIZE AND N-GRAMS ----------------------------------------------------
toke <- tokenize(text = dat, pattern_remove = profanity)
dat_tokens_1 <- tokens_ngrams(toke, n = 1)
dat_tokens_2 <- tokens_ngrams(toke, n = 2)
dat_tokens_3 <- tokens_ngrams(toke, n = 3)
dat_tokens_4 <- tokens_ngrams(toke, n = 4)
rm(toke)

# DOCUMENT TERM FREQUENCY MATRIX ------------------------------------------
dat_dfm_1 <- dfm(dat_tokens_1)
dat_dfm_2 <- dfm(dat_tokens_2)
dat_dfm_3 <- dfm(dat_tokens_3)
dat_dfm_4 <- dfm(dat_tokens_4)

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
text_freq4 <- textstat_frequency(dat_dfm_4)

# WORD PREDICTION ---------------------------------------------------------
predictWord(text_freq2, c("new"))
predictWord(text_freq3, c("new york"))
predictWord(text_freq4, c("new york city"))
predictWord(text_freq4, c("How are you"))

# QUIZ --------------------------------------------------------------------
predictWord(text_freq4, c("The guy in front of me just bought a pound of bacon, a bouquet, and a case of"))
predictWord(text_freq4, c("You're the reason why I smile everyday. Can you follow me please? It would mean the"))
predictWord(text_freq4, c("Hey sunshine, can you follow me and make me the"))
predictWord(text_freq4, c("Very early observations on the Bills game: Offense still struggling but the"))
predictWord(text_freq4, c("Go on a romantic date at the"))
predictWord(text_freq4, c("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my"))
predictWord(text_freq4, c("Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"))
predictWord(text_freq4, c("After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little"))
predictWord(text_freq4, c("Be grateful for the good times and keep the faith during the"))
predictWord(text_freq4, c("If this isn't the cutest thing you've ever seen, then you must be"))

