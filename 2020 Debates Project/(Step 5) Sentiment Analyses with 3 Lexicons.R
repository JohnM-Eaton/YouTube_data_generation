###Looking at results for Sentiment Analyses (NRC, Bing, Afinn)

###Preparing & Performing Sentiment Analyses


library(remotes)
library(textdata)
library(plyr)
library(dplyr)
library(tidyr)
library(tidytext)
library(scales)
library(ggthemes)
library(ggplot2)

get_sentiments("nrc")


#Looking at just NRC lexicon


nrc_all = aacleaned_all %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()


library(reshape2)

nrc_all$sentiment <- as.character(nrc_all$sentiment)

nrc_all$sentiment <- factor(nrc_all$sentiment,levels = c("negative", "anger", "disgust", "fear", 
                                                         "sadness", "anticipation", "surprise",
                                                         "trust", "joy", "positive"))
sum(nrc_all$n)

####Sentiments for all videos
nrc_all %>%
  group_by(sentiment) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(sentiment, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  labs(title = "Figure 4. Word Sentiment/Emotions for all Videos",
       y = NULL,
       x = NULL,
       caption = "N = 2,288,359 Words") +
  theme_classic() +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino"), panel.spacing = unit(1, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside") + scale_y_continuous(breaks=seq(0, 500000, 50000),
                                                          labels = comma) +
  scale_fill_manual(values=c("#990000", "#E41A1C", "#E69138", "#F1C232", "#6AA84F", "#674EA7",
                             "#CA538E", "#3D85C6", "#50C6DF", "#49A8FF"))


#Each Sentiment with Top 10 Words
nrc_all %>%
  group_by(sentiment) %>%
  top_n(10) %>%
  ungroup() %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~sentiment, scales = "free_y") +
  labs(title = "Figure 5. Top 10 Words by Sentiment for all Comments",
       y = "Contribution to Sentiment",
       x = NULL) +
  coord_flip() + theme_bw() +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino"), panel.spacing = unit(1, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside") +
  scale_fill_manual(values=c("#990000", "#E41A1C", "#E69138", "#F1C232", "#6AA84F", "#674EA7",
                             "#CA538E", "#3D85C6", "#50C6DF", "#49A8FF"))


###Create/clean another variable for sentiment analysis with more columns for visualization

comments.all2 = all_debates_comments %>% select(authorDisplayName, textOriginal, date_posted, channel, debate)

head(comments.all2$textOriginal)
#use the unnest token function to convert to lowercase, remove punctuation, etc.

#strip of any http elements
comments.all2$stripped_text1 <-gsub("http\\S+", "", comments.all2$textOriginal)

comments.all2str <- comments.all2 %>%
  select(stripped_text1, debate, channel, date_posted, textOriginal) %>%
  unnest_tokens(word, stripped_text1)

head(comments.all2str)
#remove stop words from the list of words
cleaned_all2 <- comments.all2str %>%
  anti_join(stop_words)

head(cleaned_all2)



nrc_all2 = cleaned_all2 %>%
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, debate, channel, sort = TRUE) %>%
  ungroup()

nrc_all2$sentiment <- as.character(nrc_all2$sentiment)

nrc_all2$sentiment <- factor(nrc_all2$sentiment,levels = c("negative", "anger", "disgust", "fear", 
                                                           "sadness", "anticipation", "surprise",
                                                           "trust", "joy", "positive"))
level_order <- c("negative", "anger", "disgust", "fear", 
                 "sadness", "anticipation", "surprise",
                 "trust", "joy", "positive")


afinn_all <- cleaned_all2 %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = channel) %>%
  summarise(sentiment = sum(value)) %>% 
  mutate(method = "AFINN")

bing_and_nrc <- bind_rows(
  cleaned_all2 %>% 
    inner_join(get_sentiments("bing")) %>%
    mutate(method = "Bing"),
  cleaned_all2 %>% 
    inner_join(get_sentiments("nrc") %>% 
                 filter(sentiment %in% c("positive", 
                                         "negative"))
    ) %>%
    mutate(method = "NRC")) %>%
  count(method, index = channel, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

#Comparing lexicons by network
bind_rows(afinn_all, 
          bing_and_nrc) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~method, ncol = 1, scales = "free_y")

afinn_all$order <- c(3, 3, 3, 3, 3, 3)
bing_and_nrc$order <- c(2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)


#Figure 6--Comparing 3 lexicons by channel

bind_rows(afinn_all, 
          bing_and_nrc) %>%
  mutate(method = reorder(method, order)) %>%
  ggplot(aes(index, sentiment, fill = index)) +
  geom_col(show.legend = TRUE) +
  labs(title = "Figure 6. Comparing three sentiment lexicons by channel",
       y = "Sentiment Scores",
       x = "YouTube Channel") + 
  facet_wrap(~method, ncol = 1, scales = "free_y") + theme_bw() +
  theme(legend.position="bottom", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) + 
  scale_y_continuous(labels = comma) + scale_fill_brewer(palette = "Dark2")

#3 columns instead of 1---not used in paper

bind_rows(afinn_all, 
          bing_and_nrc) %>%
  mutate(method = reorder(method, order)) %>%
  ggplot(aes(index, sentiment, fill = index)) +
  geom_col(show.legend = TRUE) +
  labs(title = "Figure 6. Comparing three sentiment lexicons by channel",
       y = "Sentiment Scores",
       x = "YouTube Channel") + 
  facet_wrap(~method, ncol = 3, scales = "free_y") +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) + theme_hc() +
  scale_y_continuous(labels = comma) + scale_fill_brewer(palette = "Dark2")


####Compare by debates-preping the data
afinn2 <- cleaned_all2 %>% 
  inner_join(get_sentiments("afinn")) %>% 
  group_by(index = debate) %>%
  summarise(sentiment = sum(value)) %>% 
  mutate(method = "AFINN")

bing_and_nrc2 <- bind_rows(
  cleaned_all2 %>% 
    inner_join(get_sentiments("bing")) %>%
    mutate(method = "Bing"),
  cleaned_all2 %>% 
    inner_join(get_sentiments("nrc") %>% 
                 filter(sentiment %in% c("positive", 
                                         "negative"))
    ) %>%
    mutate(method = "NRC")) %>%
  count(method, index = debate, sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = positive - negative)

afinn2$order <- c(1, 3, 2)
bing_and_nrc2$order <- c(1, 3, 2)


##Visualization of sentiment scores by Debates
bind_rows(afinn2, 
          bing_and_nrc2) %>%
  mutate(index = reorder(index, order)) %>%
  ggplot(aes(index, sentiment, fill = index)) +
  geom_col(show.legend = TRUE) +
  labs(title = "Figure . Comparing three sentiment lexicons by presidential debate",
       y = "Sentiment Scores",
       x = "Sentiment Lexicon") + 
  facet_grid(~method, scales = "free_y") + theme_bw() +
  scale_fill_manual(values=c("#E41A1C", "#4DAF4A", "#377EB8")) +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  scale_y_continuous(breaks=seq(-120000, 50000, 10000),
                     labels = comma)


####Figure 7 - BETTER Visualization of sentiment scores by Debates
bind_rows(afinn2, 
          bing_and_nrc2) %>%
  mutate(index = reorder(index, order)) %>%
  ggplot(aes(index, sentiment, fill = method)) +
  geom_col(show.legend = TRUE) +
  labs(title = "Figure 7. Comparing three sentiment lexicons by presidential debate",
       y = "Sentiment Scores",
       x = "Sentiment Lexicon") + 
  scale_fill_manual(values=c("#E41A1C", "#4DAF4A", "#377EB8")) +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside") + theme_hc() +
  scale_y_continuous(breaks=seq(-160000, 50000, 10000),
                     labels = comma)

