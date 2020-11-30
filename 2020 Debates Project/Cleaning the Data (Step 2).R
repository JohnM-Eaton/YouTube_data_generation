###Cleaning the Data

#packages used

library(dplyr)
library(tidyr)
library(tidytext)




ls(pat = "comment")

#Merging the dataframes

all_debates_comments <- do.call("rbind",
                                list(D1.CBS_comments, D1.CNN_comments, D1.cspan_comments, D1.foxn_comments, D1.NBC_comments, D1.WSJ1_comments,
                                     vp.cbs_comments, vp.cnn_comments, vp.cspan_comments, vp.fox_comments, 
                                     vp.nbc_comments, vp.wsj_comments, D2.CBS_comments, D2.CNN_comments, D2.cspan_comments, D2.foxn_comments, 
                                     D2.NBC_comments, D2.WSJ_comments))

all_debate1_comments <- do.call("rbind",
                                list(D1.CBS_comments, D1.CNN_comments, D1.cspan_comments, D1.foxn_comments, D1.NBC_comments, D1.WSJ1_comments))

all_debate2_comments <- do.call("rbind",
                                list(D2.CBS_comments, D2.CNN_comments, D2.cspan_comments, D2.foxn_comments, 
                                     D2.NBC_comments, D2.WSJ_comments))

all_vpdebate_comments <- do.call("rbind",
                                 list(vp.cbs_comments, vp.cnn_comments, vp.cspan_comments, vp.fox_comments, 
                                      vp.nbc_comments, vp.wsj_comments))

###get video statistics in database format

##Debate1
#CBS
df.d1_cbs.stat <- data.frame(matrix(unlist(D1.CBS_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cbs.stat <- df.d1_cbs.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_cbs.det <- data.frame(matrix(unlist(D1.CBS_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cbs.det <- df.d1_cbs.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_cbs.det$Date_posted = str_split_fixed(df.d1_cbs.det$publishedAt, "\\T", n=2)

#Combine all into one data.frame
myvars <- c("Video_ID", "View_Count", "Like_Count", "Dislike_Count", 
            "Comment_Count", "Video_Title", "Description", "Channel_Title", "Date_posted")

df.d1_cbs.comb <- merge(df.d1_cbs.stat, df.d1_cbs.det, by="Video_ID")
df.d1_cbs.comb <- df.d1_cbs.comb[myvars]

#Creating column for video type
df.d1_cbs.comb$type = "Full"

#Creating column for time of debate
df.d1_cbs.comb$debate = "First Presidential debate"


###CNN
df.d1_cnn.stat <- data.frame(matrix(unlist(D1.CNN_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cnn.stat <- df.d1_cnn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_cnn.det <- data.frame(matrix(unlist(D1.CNN_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cnn.det <- df.d1_cnn.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_cnn.det$Date_posted = str_split_fixed(df.d1_cnn.det$publishedAt, "\\T", n=2)

df.d1_cnn.comb <- merge(df.d1_cnn.stat, df.d1_cnn.det, by="Video_ID")
df.d1_cnn.comb <- df.d1_cnn.comb[myvars]

#Creating column for video type
df.d1_cnn.comb$type = "Full"

#Creating column for time of debate
df.d1_cnn.comb$debate = "First Presidential debate"


###CSPAN
df.d1_cspan.stat <- data.frame(matrix(unlist(D1.cspan_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cspan.stat <- df.d1_cspan.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_cspan.det <- data.frame(matrix(unlist(D1.cspan_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_cspan.det <- df.d1_cspan.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_cspan.det$Date_posted = str_split_fixed(df.d1_cspan.det$publishedAt, "\\T", n=2)

df.d1_cspan.comb <- merge(df.d1_cspan.stat, df.d1_cspan.det, by="Video_ID")
df.d1_cspan.comb <- df.d1_cspan.comb[myvars]

#Creating column for video type
df.d1_cspan.comb$type = "Full"

#Creating column for time of debate
df.d1_cspan.comb$debate = "First Presidential debate"


###Fox News
df.d1_foxn.stat <- data.frame(matrix(unlist(D1.foxn_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_foxn.stat <- df.d1_foxn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_foxn.det <- data.frame(matrix(unlist(D1.foxn_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_foxn.det <- df.d1_foxn.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_foxn.det$Date_posted = str_split_fixed(df.d1_foxn.det$publishedAt, "\\T", n=2)

df.d1_foxn.comb <- merge(df.d1_foxn.stat, df.d1_foxn.det, by="Video_ID")
df.d1_foxn.comb <- df.d1_foxn.comb[myvars]

#Creating column for video type
df.d1_foxn.comb$type = "Full"

#Creating column for time of debate
df.d1_foxn.comb$debate = "First Presidential debate"



###NBC News
df.d1_nbc.stat <- data.frame(matrix(unlist(D1.NBC_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_nbc.stat <- df.d1_nbc.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_nbc.det <- data.frame(matrix(unlist(D1.NBC_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_nbc.det <- df.d1_nbc.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_nbc.det$Date_posted = str_split_fixed(df.d1_nbc.det$publishedAt, "\\T", n=2)

df.d1_nbc.comb <- merge(df.d1_nbc.stat, df.d1_nbc.det, by="Video_ID")
df.d1_nbc.comb <- df.d1_nbc.comb[myvars]

#Creating column for video type
df.d1_nbc.comb$type = "Full"

#Creating column for time of debate
df.d1_nbc.comb$debate = "First Presidential debate"


###WSJ
df.d1_wsj.stat <- data.frame(matrix(unlist(D1.WSJ_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_wsj.stat <- df.d1_wsj.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d1_wsj.det <- data.frame(matrix(unlist(D1.WSJ_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d1_wsj.det <- df.d1_wsj.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d1_wsj.det$Date_posted = str_split_fixed(df.d1_wsj.det$publishedAt, "\\T", n=2)

df.d1_wsj.comb <- merge(df.d1_wsj.stat, df.d1_wsj.det, by="Video_ID")
df.d1_wsj.comb <- df.d1_wsj.comb[myvars]

#Creating column for video type
df.d1_wsj.comb$type = "Full"

#Creating column for time of debate
df.d1_wsj.comb$debate = "First Presidential debate"


###Debate 2
#CBS
df.d2_cbs.stat <- data.frame(matrix(unlist(D2.CBS_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cbs.stat <- df.d2_cbs.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_cbs.det <- data.frame(matrix(unlist(D2.CBS_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cbs.det <- df.d2_cbs.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_cbs.det$Date_posted = str_split_fixed(df.d2_cbs.det$publishedAt, "\\T", n=2)

df.d2_cbs.comb <- merge(df.d2_cbs.stat, df.d2_cbs.det, by="Video_ID")
df.d2_cbs.comb <- df.d2_cbs.comb[myvars]

#Creating column for video type
df.d2_cbs.comb$type = "Full"

#Creating column for time of debate
df.d2_cbs.comb$debate = "Second Presidential debate"


#CNN
df.d2_cnn.stat <- data.frame(matrix(unlist(D2.CNN_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cnn.stat <- df.d2_cnn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_cnn.det <- data.frame(matrix(unlist(D2.CNN_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cnn.det <- df.d2_cnn.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_cnn.det$Date_posted = str_split_fixed(df.d2_cnn.det$publishedAt, "\\T", n=2)

df.d2_cnn.comb <- merge(df.d2_cnn.stat, df.d2_cnn.det, by="Video_ID")
df.d2_cnn.comb <- df.d2_cnn.comb[myvars]

#Creating column for video type
df.d2_cnn.comb$type = "Full"

#Creating column for time of debate
df.d2_cnn.comb$debate = "Second Presidential debate"


#CSPAN
df.d2_cspan.stat <- data.frame(matrix(unlist(D2.cspan_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cspan.stat <- df.d2_cspan.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_cspan.det <- data.frame(matrix(unlist(D2.cspan_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_cspan.det <- df.d2_cspan.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_cspan.det$Date_posted = str_split_fixed(df.d2_cspan.det$publishedAt, "\\T", n=2)

df.d2_cspan.comb <- merge(df.d2_cspan.stat, df.d2_cspan.det, by="Video_ID")
df.d2_cspan.comb <- df.d2_cspan.comb[myvars]

#Creating column for video type
df.d2_cspan.comb$type = "Full"

#Creating column for time of debate
df.d2_cspan.comb$debate = "Second Presidential debate"



#Fox News
df.d2_foxn.stat <- data.frame(matrix(unlist(D2.foxn_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_foxn.stat <- df.d2_foxn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_foxn.det <- data.frame(matrix(unlist(D2.foxn_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_foxn.det <- df.d2_foxn.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_foxn.det$Date_posted = str_split_fixed(df.d2_foxn.det$publishedAt, "\\T", n=2)

df.d2_foxn.comb <- merge(df.d2_foxn.stat, df.d2_foxn.det, by="Video_ID")
df.d2_foxn.comb <- df.d2_foxn.comb[myvars]

#Creating column for video type
df.d2_foxn.comb$type = "Full"

#Creating column for time of debate
df.d2_foxn.comb$debate = "Second Presidential debate"


#NBC
df.d2_nbc.stat <- data.frame(matrix(unlist(D2.NBC_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_nbc.stat <- df.d2_nbc.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_nbc.det <- data.frame(matrix(unlist(D2.NBC_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_nbc.det <- df.d2_nbc.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_nbc.det$Date_posted = str_split_fixed(df.d2_nbc.det$publishedAt, "\\T", n=2)

df.d2_nbc.comb <- merge(df.d2_nbc.stat, df.d2_nbc.det, by="Video_ID")
df.d2_nbc.comb <- df.d2_nbc.comb[myvars]

#Creating column for video type
df.d2_nbc.comb$type = "Full"

#Creating column for time of debate
df.d2_nbc.comb$debate = "Second Presidential debate"



#WSJ
df.d2_wsj.stat <- data.frame(matrix(unlist(D2.WSJ_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_wsj.stat <- df.d2_wsj.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.d2_wsj.det <- data.frame(matrix(unlist(D2.WSJ_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.d2_wsj.det <- df.d2_wsj.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.d2_wsj.det$Date_posted = str_split_fixed(df.d2_wsj.det$publishedAt, "\\T", n=2)

df.d2_wsj.comb <- merge(df.d2_wsj.stat, df.d2_wsj.det, by="Video_ID")
df.d2_wsj.comb <- df.d2_wsj.comb[myvars]

#Creating column for video type
df.d2_wsj.comb$type = "Full"

#Creating column for time of debate
df.d2_wsj.comb$debate = "Second Presidential debate"




### VP Debate
#CBS
df.vp_cbs.stat <- data.frame(matrix(unlist(vp.cbs_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cbs.stat <- df.vp_cbs.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_cbs.det <- data.frame(matrix(unlist(vp.cbs_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cbs.det <- df.vp_cbs.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_cbs.det$Date_posted = str_split_fixed(df.vp_cbs.det$publishedAt, "\\T", n=2)

df.vp_cbs.comb <- merge(df.vp_cbs.stat, df.vp_cbs.det, by="Video_ID")
df.vp_cbs.comb <- df.vp_cbs.comb[myvars]

#Creating column for video type
df.vp_cbs.comb$type = "Full"

#Creating column for time of debate
df.vp_cbs.comb$debate = "Vice Presidential debate"


#CNN
df.vp_cnn.stat <- data.frame(matrix(unlist(vp.cnn_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cnn.stat <- df.vp_cnn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_cnn.det <- data.frame(matrix(unlist(vp.cnn_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cnn.det <- df.vp_cnn.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_cnn.det$Date_posted = str_split_fixed(df.vp_cnn.det$publishedAt, "\\T", n=2)

df.vp_cnn.comb <- merge(df.vp_cnn.stat, df.vp_cnn.det, by="Video_ID")
df.vp_cnn.comb <- df.vp_cnn.comb[myvars]

#Creating column for video type
df.vp_cnn.comb$type = "Full"

#Creating column for time of debate
df.vp_cnn.comb$debate = "Vice Presidential debate"


#CSPAN
df.vp_cspan.stat <- data.frame(matrix(unlist(vp.cspan_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cspan.stat <- df.vp_cspan.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_cspan.det <- data.frame(matrix(unlist(vp.cspan_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_cspan.det <- df.vp_cspan.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_cspan.det$Date_posted = str_split_fixed(df.vp_cspan.det$publishedAt, "\\T", n=2)

df.vp_cspan.comb <- merge(df.vp_cspan.stat, df.vp_cspan.det, by="Video_ID")
df.vp_cspan.comb <- df.vp_cspan.comb[myvars]

#Creating column for video type
df.vp_cspan.comb$type = "Full"

#Creating column for time of debate
df.vp_cspan.comb$debate = "Vice Presidential debate"


#Fox
df.vp_foxn.stat <- data.frame(matrix(unlist(vp.fox_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_foxn.stat <- df.vp_foxn.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_fox.det <- data.frame(matrix(unlist(vp.fox_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_fox.det <- df.vp_fox.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_fox.det$Date_posted = str_split_fixed(df.vp_fox.det$publishedAt, "\\T", n=2)

df.vp_fox.comb <- merge(df.vp_foxn.stat, df.vp_fox.det, by="Video_ID")
df.vp_fox.comb <- df.vp_fox.comb[myvars]

#Creating column for video type
df.vp_fox.comb$type = "Full"

#Creating column for time of debate
df.vp_fox.comb$debate = "Vice Presidential debate"


#NBC
df.vp_nbc.stat <- data.frame(matrix(unlist(vp.nbc_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_nbc.stat <- df.vp_nbc.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_nbc.det <- data.frame(matrix(unlist(vp.nbc_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_nbc.det <- df.vp_nbc.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_nbc.det$Date_posted = str_split_fixed(df.vp_nbc.det$publishedAt, "\\T", n=2)

df.vp_nbc.comb <- merge(df.vp_nbc.stat, df.vp_nbc.det, by="Video_ID")
df.vp_nbc.comb <- df.vp_nbc.comb[myvars]

#Creating column for video type
df.vp_nbc.comb$type = "Full"

#Creating column for time of debate
df.vp_nbc.comb$debate = "Vice Presidential debate"


#WSJ
df.vp_wsj.stat <- data.frame(matrix(unlist(vp.wsj_stats), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_wsj.stat <- df.vp_wsj.stat %>%
  rename(
    Video_ID = X1,
    View_Count = X2,
    Like_Count = X3,
    Dislike_Count = X4,
    Favorite_Count = X5,
    Comment_Count = X6
  )
df.vp_wsj.det <- data.frame(matrix(unlist(vp.wsj_details), nrow = length(1), byrow = T),stringsAsFactors=FALSE)
df.vp_wsj.det <- df.vp_wsj.det %>%
  rename(
    Video_ID = X5,
    publishedAt = X6,
    Video_Title = X8,
    Description = X9,
    Channel_Title = X25,
  )

#Fixing Date comment was posted
df.vp_wsj.det$Date_posted = str_split_fixed(df.vp_wsj.det$publishedAt, "\\T", n=2)

df.vp_wsj.comb <- merge(df.vp_wsj.stat, df.vp_wsj.det, by="Video_ID")
df.vp_wsj.comb <- df.vp_wsj.comb[myvars]

#Creating column for video type
df.vp_wsj.comb$type = "Full"

#Creating column for time of debate
df.vp_wsj.comb$debate = "Vice Presidential debate"


##Combining the dataframes for tables

ls(pat = "comb")

all_comments_vpdebate <- do.call("rbind", 
                                 list(vp.cbs_comments, vp.cnbc_comments, vp.cnn_comments, vp.cspan_comments, vp.fox_comments, 
                                      vp.nbc_comments, vp.time_comments, vp.wsj_comments))
df.all.d1 <- do.call("rbind", 
                     list(df.d1_cbs.comb, df.d1_cnn.comb, df.d1_cspan.comb, df.d1_foxn.comb, df.d1_nbc.comb, df.d1_wsj.comb))

df.all.d2 <- do.call("rbind", 
                     list(df.d2_cbs.comb, df.d2_cnn.comb, df.d2_cspan.comb, df.d2_foxn.comb, df.d2_nbc.comb, df.d2_wsj.comb))

df.all.vp <- do.call("rbind", 
                     list(df.vp_cbs.comb, df.vp_cnn.comb, df.vp_cspan.comb, df.vp_fox.comb, df.vp_nbc.comb, df.vp_wsj.comb))

df.all.debates <- do.call("rbind", 
                          list(df.d1_cbs.comb, df.d1_cnn.comb, df.d1_cspan.comb, df.d1_foxn.comb, df.d1_nbc.comb, df.d1_wsj.comb,
                               df.d2_cbs.comb, df.d2_cnn.comb, df.d2_cspan.comb, df.d2_foxn.comb, df.d2_nbc.comb, df.d2_wsj.comb,
                               df.vp_cbs.comb, df.vp_cnn.comb, df.vp_cspan.comb, df.vp_fox.comb, df.vp_nbc.comb, df.vp_wsj.comb))

df.all.debates <- df.all.debates[, c(11, 8, 9, 6, 1, 7, 2, 3, 4, 5, 7, 10)]

df.all.vp <- df.all.vp[, c(11, 8, 9, 6, 1, 7, 2, 3, 4, 5, 7, 10)]

df.all.d2 <- df.all.d2[, c(11, 8, 9, 6, 1, 7, 2, 3, 4, 5, 7, 10)]

df.all.d1 <- df.all.d1[, c(11, 8, 9, 6, 1, 7, 2, 3, 4, 5, 7, 10)]

df.all.pres <- do.call("rbind", 
                       list(df.all.d2, df.all.d1))
