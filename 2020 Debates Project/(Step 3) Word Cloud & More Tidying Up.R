##Word Cloud

library(dplyr)
library(tidyr)
library(tidytext)
library(wordcloud2)
library(RColorBrewer)

#####All Comments across 3 debates- for 6 of the channels
comments.all = all_debates_comments %>% select(authorDisplayName, textOriginal)

head(comments.all$textOriginal)
#use the unnest token function to convert to lowercase, remove punctuation, etc.

#strip of any http elements
comments.all$stripped_text1 <-gsub("http\\S+", "", comments.all$textOriginal)

comments.allstr <- comments.all %>%
  select(stripped_text1) %>%
  unnest_tokens(word, stripped_text1)

head(comments.allstr)
#remove stop words from the list of words
aacleaned_all <- comments.allstr %>%
  anti_join(stop_words)

head(aacleaned_all)



#####
data(stop_words)
aacleaned_all <- aacleaned_all %>%
  anti_join(stop_words)


aacleaned_all <- aacleaned_all %>%
  count(word, sort = TRUE) 
aacleaned_all

aacleaned_all <-aacleaned_all %>%
  filter(!word %in% c('t.co', 'https', 'dont', "'s", "'don't", "'m", "'re", 'tvtime', 
                      'watched', 'watching', 'watch', 'la', "it's", 'el', 'en', 'tv',
                      '1', 'ep', 'week', 'amp'))

#Wordcloud

set.seed(1234)

set1_pallette <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3", "#FF7F00", "#A65628", "#F781BF", "#999999")

wordcloud2(aacleaned_all, size=1.5)

##Final wordcloud
wordcloud2(aacleaned_all, size=1.6, color=rep_len( set1_pallette, nrow(aacleaned_all) ) )

