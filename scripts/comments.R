library(tm)
library(SnowballC)
library(quanteda)
source("./functions/readRand.R")

options(max.print = 100)
set.seed(123)

# THOUGHTS ----------------------------------------------------------------

# Typos? 

# Relationships between words?

# How do you evaluate how many of the words come from foreign languages?

# How many unique words do you need in a frequency sorted dictionary to cover
# 50% of all word instances in the language? 90%?

-------------------------------------------------------------------------

files <- list.files("./data")
dat <- sapply(files, readRand, size = 20000)
dat <- as.vector(dat)
dat2 <- SimpleCorpus(VectorSource(dat))
dtm2 <- DocumentTermMatrix(dat2)
inspect(dtm2)  

# -------------------------------------------------------------------------

corpus <- VCorpus(DirSource("./test"))
dtm <- DocumentTermMatrix(corpus, control = list(removePunctuation = TRUE))
inspect(dtm)
findFreqTerms(dtm, 100)
findAssocs(dtm, c("hello", "the"), .2)
Boost_tokenizer()

quanteda::as.dfm(dtm)
summary(corpus)
corpus <- quanteda::corpus(dat)
tokens(dat3)


# TF-IDF ------------------------------------------------------------------

dat_tfidf <- dfm_tfidf(dat_dfm, scheme_tf = "prop")
dat_tfidf[1:10, 1:10]

# CHECK INCOMPLETE CASES
which(!complete.cases(convert(dat_tfidf[1:100000], to = "data.frame")))

# REMOVE INCOMPLETE CASES

# CLEAN UP DATA FRAME (AGAIN)

# -------------------------------------------------------------------------

# # SINGULAR VALUE DECOMPOSITION
dat_irlba <- irlba(t(), nv = 300, maxit = 50)
