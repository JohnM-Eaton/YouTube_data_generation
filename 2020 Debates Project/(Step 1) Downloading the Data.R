####Downloading the Data from YouTube
##Packages used
library(tuber) # youtube API
library(magrittr) # Pipes %>%, %T>% and equals(), extract().
library(tidyverse) # all tidyverse packages
library(purrr) # package for iterating/extracting data
library(lubridate)

#Downloading Data for 9/29 Presidential debate

client_id <-"[insert your own]"
client_secret <- "[insert your own]"

# use the youtube oauth 
yt_oauth(app_id = client_id,
         app_secret = client_secret,
         token = '')

#WSJ footage YT video
D1.WSJ_stats <- get_stats(video_id="yW8nIA33-zY")
#individual videos: view count, like count, dislike count, comment count

D1.WSJ_details <- get_video_details(video_id="yW8nIA33-zY")
#Title, tags, description

#get all comments
D1.WSJ1_comments <- get_all_comments(video_id="yW8nIA33-zY")

#fix date
D1.WSJ1_comments$date_posted = str_split_fixed(D1.WSJ1_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.WSJ1_comments$channel = "Wall Street Journal"

#Creating column for video type
D1.WSJ1_comments$type = "Full"

#Creating column for time of debate
D1.WSJ1_comments$debate = "First Presidential debate"


####CBS News footage YT video
D1.CBS_stats <- get_stats(video_id="9HnKFUNlcfY")
#individual videos: view count, like count, dislike count, comment count

D1.CBS_details <- get_video_details(video_id="9HnKFUNlcfY")
#Title, tags, description

#get all comments
D1.CBS_comments <- get_all_comments(video_id="9HnKFUNlcfY")

#fix date
D1.CBS_comments$date_posted = str_split_fixed(D1.CBS_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.CBS_comments$channel = "CBS News"

#Creating column for video type
D1.CBS_comments$type = "Full"

#Creating column for time of debate
D1.CBS_comments$debate = "First Presidential debate"

####NBC News footage YT video
D1.NBC_stats <- get_stats(video_id="5cathmZFeXs")
#individual videos: view count, like count, dislike count, comment count

D1.NBC_details <- get_video_details(video_id="5cathmZFeXs")
#Title, tags, description

#get all comments
D1.NBC_comments <- get_all_comments(video_id="5cathmZFeXs")

#fix date
D1.NBC_comments$date_posted = str_split_fixed(D1.NBC_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.NBC_comments$channel = "NBC News"

#Creating column for video type
D1.NBC_comments$type = "Full"

#Creating column for time of debate
D1.NBC_comments$debate = "First Presidential debate"


####CNN footage YT video
D1.CNN_stats <- get_stats(video_id="yHFI8TsSKXY")
#individual videos: view count, like count, dislike count, comment count

D1.CNN_details <- get_video_details(video_id="yHFI8TsSKXY")
#Title, tags, description

#get all comments
D1.CNN_comments <- get_all_comments(video_id="yHFI8TsSKXY")

#fix date
D1.CNN_comments$date_posted = str_split_fixed(D1.CNN_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.CNN_comments$channel = "CNN"

#Creating column for video type
D1.CNN_comments$type = "Full"

#Creating column for time of debate
D1.CNN_comments$debate = "First Presidential debate"


####Fox News footage YT video
D1.foxn_stats <- get_stats(video_id="ofkPfm3tFxo")
#individual videos: view count, like count, dislike count, comment count

D1.foxn_details <- get_video_details(video_id="ofkPfm3tFxo")
#Title, tags, description

#get all comments
D1.foxn_comments <- get_all_comments(video_id="ofkPfm3tFxo")

#fix date
D1.foxn_comments$date_posted = str_split_fixed(D1.foxn_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.foxn_comments$channel = "Fox News"

#Creating column for video type
D1.foxn_comments$type = "Full"

#Creating column for time of debate
D1.foxn_comments$debate = "First Presidential debate"


####CSPAN footage YT video
D1.cspan_stats <- get_stats(video_id="wW1lY5jFNcQ")
#individual videos: view count, like count, dislike count, comment count

D1.cspan_details <- get_video_details(video_id="wW1lY5jFNcQ")
#Title, tags, description

#get all comments
D1.cspan_comments <- get_all_comments(video_id="wW1lY5jFNcQ")

#fix date
D1.cspan_comments$date_posted = str_split_fixed(D1.cspan_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D1.cspan_comments$channel = "CSPAN"

#Creating column for video type
D1.cspan_comments$type = "Full"

#Creating column for time of debate
D1.cspan_comments$debate = "First Presidential debate"


########## VICE PRESIDENTIAL DEBATE##############

####CSPAN News footage YT video
vp.cspan_stats <- get_stats(video_id="t_G0ia3JOVs")
#individual videos: view count, like count, dislike count, comment count

vp.cspan_details <- get_video_details(video_id="t_G0ia3JOVs")
#Title, tags, description

#get all comments
vp.cspan_comments <- get_all_comments(video_id="t_G0ia3JOVs")

#fix date
vp.cspan_comments$date_posted = str_split_fixed(vp.cspan_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.cspan_comments$channel = "CSPAN"

vp.cspan_comments$type = "Full"

#Creating column for time of debate
vp.cspan_comments$debate = "Vice Presidential debate"

####CBC News footage YT video
vp.cbs_stats <- get_stats(video_id="65twkjiwD90")
#individual videos: view count, like count, dislike count, comment count

vp.cbs_details <- get_video_details(video_id="65twkjiwD90")
#Title, tags, description

#get all comments
vp.cbs_comments <- get_all_comments(video_id="65twkjiwD90")

#fix date
vp.cbs_comments$date_posted = str_split_fixed(vp.cbs_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.cbs_comments$channel = "CBS News"

#Creating column for video type
vp.cbs_comments$type = "Full"

#Creating column for time of debate
vp.cbs_comments$debate = "Vice Presidential debate"


####CNN News footage YT video
vp.cnn_stats <- get_stats(video_id="LaaJ3CxEnCY")
#individual videos: view count, like count, dislike count, comment count

vp.cnn_details <- get_video_details(video_id="LaaJ3CxEnCY")
#Title, tags, description

#get all comments
vp.cnn_comments <- get_all_comments(video_id="LaaJ3CxEnCY")

#fix date
vp.cnn_comments$date_posted = str_split_fixed(vp.cnn_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.cnn_comments$channel = "CNN"

#Creating column for video type
vp.cnn_comments$type = "Full"

#Creating column for time of debate
vp.cnn_comments$debate = "Vice Presidential debate"


####NBC NEWS News footage YT video
vp.nbc_stats <- get_stats(video_id="_4Y0se-y3D4")
#individual videos: view count, like count, dislike count, comment count

vp.nbc_details <- get_video_details(video_id="_4Y0se-y3D4")
#Title, tags, description

#get all comments
vp.nbc_comments <- get_all_comments(video_id="_4Y0se-y3D4")

#fix date
vp.nbc_comments$date_posted = str_split_fixed(vp.nbc_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.nbc_comments$channel = "NBC News"

#Creating column for video type
vp.nbc_comments$type = "Full"

#Creating column for time of debate
vp.nbc_comments$debate = "Vice Presidential debate"



####Fox News footage YT video
vp.fox_stats <- get_stats(video_id="xXE6I3gWiMc")
#individual videos: view count, like count, dislike count, comment count

vp.fox_details <- get_video_details(video_id="xXE6I3gWiMc")
#Title, tags, description

#get all comments
vp.fox_comments <- get_all_comments(video_id="xXE6I3gWiMc")

#fix date
vp.fox_comments$date_posted = str_split_fixed(vp.fox_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.fox_comments$channel = "Fox News"

#Creating column for video type
vp.fox_comments$type = "Full"


#Creating column for time of debate
vp.fox_comments$debate = "Vice Presidential debate"


####Wall Street Journal footage YT video
vp.wsj_stats <- get_stats(video_id="Q__CEb3dRqw")
#individual videos: view count, like count, dislike count, comment count

vp.wsj_details <- get_video_details(video_id="Q__CEb3dRqw")
#Title, tags, description

#get all comments
vp.wsj_comments <- get_all_comments(video_id="Q__CEb3dRqw")

#fix date
vp.wsj_comments$date_posted = str_split_fixed(vp.wsj_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
vp.wsj_comments$channel = "Wall Street Journal"

#Creating column for video type
vp.wsj_comments$type = "Full"

#Creating column for time of debate
vp.wsj_comments$debate = "Vice Presidential debate"



########################################################
###SECOND PRESIDENTIAL DEBATE####
#WSJ footage YT video
D2.WSJ_stats <- get_stats(video_id="RHISJrOODJ4")
#individual videos: view count, like count, dislike count, comment count

D2.WSJ_details <- get_video_details(video_id="RHISJrOODJ4")
#Title, tags, description

#get all comments
D2.WSJ_comments <- get_all_comments(video_id="RHISJrOODJ4")

#fix date
D2.WSJ_comments$date_posted = str_split_fixed(D2.WSJ_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.WSJ_comments$channel = "Wall Street Journal"

#Creating column for video type
D2.WSJ_comments$type = "Full"

#Creating column for time of debate
D2.WSJ_comments$debate = "Second Presidential debate"


####CBS News footage YT video
D2.CBS_stats <- get_stats(video_id="_92o3Z919f4")
#individual videos: view count, like count, dislike count, comment count

D2.CBS_details <- get_video_details(video_id="_92o3Z919f4")
#Title, tags, description

#get all comments
D2.CBS_comments <- get_all_comments(video_id="_92o3Z919f4")

#fix date
D2.CBS_comments$date_posted = str_split_fixed(D2.CBS_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.CBS_comments$channel = "CBS News"

#Creating column for video type
D2.CBS_comments$type = "Full"

#Creating column for time of debate
D2.CBS_comments$debate = "Second Presidential debate"


####NBC News footage YT video
D2.NBC_stats <- get_stats(video_id="UCA1A5GqCdQ")
#individual videos: view count, like count, dislike count, comment count

D2.NBC_details <- get_video_details(video_id="UCA1A5GqCdQ")
#Title, tags, description

#get all comments
D2.NBC_comments <- get_all_comments(video_id="UCA1A5GqCdQ")

#fix date
D2.NBC_comments$date_posted = str_split_fixed(D2.NBC_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.NBC_comments$channel = "NBC News"

#Creating column for video type
D2.NBC_comments$type = "Full"

#Creating column for time of debate
D2.NBC_comments$debate = "Second Presidential debate"


####CNN footage YT video
D2.CNN_stats <- get_stats(video_id="rOn7uGVVf1I")
#individual videos: view count, like count, dislike count, comment count

D2.CNN_details <- get_video_details(video_id="rOn7uGVVf1I")
#Title, tags, description

#get all comments
D2.CNN_comments <- get_all_comments(video_id="rOn7uGVVf1I")

#fix date
D2.CNN_comments$date_posted = str_split_fixed(D2.CNN_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.CNN_comments$channel = "CNN"

#Creating column for video type
D2.CNN_comments$type = "Full"

#Creating column for time of debate
D2.CNN_comments$debate = "Second Presidential debate"


####Fox News footage YT video
D2.foxn_stats <- get_stats(video_id="nY2AXIx-GU4")
#individual videos: view count, like count, dislike count, comment count

D2.foxn_details <- get_video_details(video_id="nY2AXIx-GU4")
#Title, tags, description

#get all comments
D2.foxn_comments <- get_all_comments(video_id="nY2AXIx-GU4")

#fix date
D2.foxn_comments$date_posted = str_split_fixed(D2.foxn_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.foxn_comments$channel = "Fox News"

#Creating column for video type
D2.foxn_comments$type = "Full"

#Creating column for time of debate
D2.foxn_comments$debate = "Second Presidential debate"


####CSPAN footage YT video
D2.cspan_stats <- get_stats(video_id="bPiofmZGb8o")
#individual videos: view count, like count, dislike count, comment count

D2.cspan_details <- get_video_details(video_id="bPiofmZGb8o")
#Title, tags, description

#get all comments
D2.cspan_comments <- get_all_comments(video_id="bPiofmZGb8o")

#fix date
D2.cspan_comments$date_posted = str_split_fixed(D2.cspan_comments$publishedAt, "\\T", n=2)

#Creating column for video channel source
D2.cspan_comments$channel = "CSPAN"

#Creating column for video type
D2.cspan_comments$type = "Full"

#Creating column for time of debate
D2.cspan_comments$debate = "Second Presidential debate"
