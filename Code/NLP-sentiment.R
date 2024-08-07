#sentiment analysis
sentiment_analysis <- tokens_description  %>% 
  inner_join(get_sentiments("bing"), "word") %>% 
  count(occupancyRatio, sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(sentiment = positive - negative)

sentiment_analysis_words <- tokens_description %>% 
  inner_join(get_sentiments("bing"), "word") %>% 
  count(word, sentiment, sort = TRUE) %>% 
  ungroup()

sentiment_analysis_words %>% 
  group_by(sentiment) %>% 
  top_n(10, n) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) + 
  geom_col(show.legend = FALSE) + 
  facet_wrap(~sentiment, scales = "free_y") + 
  labs(y = "Contribution to Sentiment", x = NULL) + 
  coord_flip()

#find most common sentiment words
sentiments_description <- tokens_description %>% 
  inner_join(get_sentiments("afinn"), by = "word") %>% 
  group_by(word) %>% 
  summarize(occurences = n())
top10sentiment_description <- sentiments_description$word[1:10]

sentiments_name <- tokens_name %>% 
  inner_join(get_sentiments("afinn"), by = "word") %>% 
  group_by(word) %>% 
  summarize(occurences = n())
top10sentiment_name <- sentiments_name$word[1:10]

#create df with dummy variables for top 10 sentiment words in description
topsentiment_description_df <- data[,1:30]

for (i in top10sentiment_description){
  topsentiment_description_df[[i]] <- numeric(nrow(topsentiment_description_df))
}

for (word in top10sentiment_description){
  for (row in 1:nrow(topsentiment_description_df)){
    description <- gsub("[{}\"]", "", topsentiment_description_df$description[row])
    if (grepl(word, topsentiment_description_df$description[row])){
      topsentiment_description_df[[word]][row] <- 1
    }
  }
}

#create df with dummy variables for top 10 sentiment words in name
topsentiment_name_df <- data[,1:30]
for (i in top10sentiment_name){
  topsentiment_name_df[[i]] <- numeric(nrow(topsentiment_name_df))
}

for (word in top10sentiment_name){
  for (row in 1:nrow(topsentiment_name_df)){
    name <- gsub("[{}\"]", "", topsentiment_name_df$name[row])
    if (grepl(word, topsentiment_name_df$name[row])){
      topsentiment_name_df[[word]][row] <- 1
    }
  }
}

sentiment_contribution_name<- tokens_name %>% 
  inner_join(get_sentiments("afinn"), by = "word") %>% 
  group_by(word) %>% 
  summarize(occurences = n(), contribution = sum(occupancyRatio))

sentiment_contribution_name %>% 
  top_n(10, abs(contribution)) %>%
  mutate(word = reorder(word, contribution)) %>%
  ggplot(aes(word, contribution, fill = contribution > 0)) + 
  geom_col(show.legend = FALSE) + 
  labs(title = "Top 10 Sentiment Words in Name Contributing to Occupancy Ratio") +
  coord_flip()