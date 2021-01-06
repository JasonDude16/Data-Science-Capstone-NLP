# EXPLORATORY ANALYSIS  ---------------------------------------------------

dat_dfm2_df <- tidy(dat_dfm2)
colnames(dat_dfm2_df)[2] <- "word"

# Word cloud, top words
dat_dfm2_df %>%
  count(word) %>% 
  with(wordcloud(word, n, max.words = 100))

# Bar chart, top words
data.frame(word = attributes(topfeatures(dat_dfm2, n = 20))$names,
           count = topfeatures(dat_dfm2, n = 20)) %>%
  mutate(word = fct_reorder(word, desc(count))) %>% 
  ggplot(aes(word, count)) +
  geom_col(fill = "lightblue") + 
  theme_bw() +
  labs(title = "Top 20 Most Frequent Words") +
  theme(axis.text.x = element_text(angle = 315),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank())

# SENTIMENT ANALYSIS

## Top positive and negative
# Bing
dat_dfm2_df %>% 
  inner_join(get_sentiments("bing")) %>% 
  count(word, sentiment, sort = TRUE) %>%
  group_by(sentiment) %>% 
  mutate(word = fct_reorder(word, n)) %>% 
  slice(1:10) %>% 
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col(position = "dodge") + 
  facet_wrap(~sentiment, scales = "free_y") +
  labs(title = "Top 10 Most Frequent Positive and Negative Sentiments") +
  ylab("Count") +
  theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank())

# Top sentiments
## Afinn
dat_dfm2_df %>% 
  inner_join(get_sentiments("afinn")) %>% 
  count(word, value, sort = TRUE) %>%
  group_by(value) %>% 
  mutate(word = fct_reorder(word, n)) %>% 
  slice(1:3) %>% 
  ggplot(aes(word, n, fill = as.factor(value))) +
  geom_col(position = "dodge") +
  labs(title = "Top 3 Most Frequent Words by Sentiment") +
  ylab("Count") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 315),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank())

# Top sentiments
## Nrc
dat_dfm2_df %>% 
  inner_join(get_sentiments("nrc")) %>% 
  count(word, sentiment, sort = TRUE) %>%
  mutate(word = fct_reorder(word, n)) %>% 
  group_by(sentiment) %>% 
  slice(1:3) %>% 
  ggplot(aes(word, n, fill = as.factor(sentiment))) +
  geom_col(position = "dodge") +
  facet_wrap(~sentiment, scales = "free_x", nrow = 2) +
  labs(title = "Top 3 Most Frequent Words by Sentiment") +
  ylab("Count") +
  theme_bw() +
  theme(panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank())

# -------------------------------------------------------------------------

ggplot(summary(corpus), aes(x = Tokens)) +
  geom_bar()

ggplot(summary(corpus), aes(x = Sentences)) +
  geom_bar()

textplot_wordcloud(dat_dfm_samp)

textstat_frequency(dat_dfm_samp)[1:20] %>% 
  ggplot(aes(x = feature, y = frequency)) +
  geom_bar(stat = "identity")

term_count <- 
  tidy(dat_dfm_samp) %>% 
  group_by(term) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

ggplot(term_count[1:20,], aes(x = term, y = count)) +
  geom_bar(stat = "identity")