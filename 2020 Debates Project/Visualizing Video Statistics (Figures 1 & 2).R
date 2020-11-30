####1st Data Visualizations--of video statistics

#packages used
library(textdata)
library(plyr)
library(dplyr)
library(tidyr)
library(tidytext)
library(knitr)
library(kableExtra)
library(expss)
library(xtable)
library(ggthemes)
library(extrafont)

windowsFont()
windowsFonts(Times=windowsFont("TT Times New Roman"))
windowsFonts(Palatino=windowsFont("Palatino"))

extrafont::loadfonts(device="win")

library(extrafont)
loadfonts(device = "win")

library(ggplot2)
library(RColorBrewer)
library(scales)


#apply labels to variables 
df.all.debates = apply_labels(df.all.debates,
                              Channel_Title = "Channel",
                              Video_Title = "Video Title",
                              View_Count = "Views",
                              Like_Count = "Likes",
                              Dislike_Count = "Dislikes",
                              Comment_Count = "Comments",
                              Date_posted = "Date Published")

df.all.debates.table <- subset(df.all.debates, select =  -c(Video_ID, Video_Title, Description, Description.1, type))

df.all.debates.table$order <- c(1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2)

df.all.debates.table$View_Count <- as.numeric(df.all.debates.table$View_Count)
df.all.debates.table$Comment_Count <- as.numeric(df.all.debates.table$Comment_Count)

sum(df.all.debates.table$View_Count)

#Figure 1-Views

fig1 <- df.all.debates.table %>%
  group_by(order) %>%
  mutate(debate = reorder(debate, order)) %>%
  ggplot(aes(debate, View_Count, fill = debate)) +
  geom_bar(show.legend = TRUE, position= position_dodge(width = .5), stat="identity") +
  labs(title = "Figure 1. Number of Views by Debate (Total = 78,483,415)",
       y = "Views",
       x = NULL) + theme_hc() + 
  facet_grid(~Channel_Title, scales = "free", switch = "both") +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

brewer.pal(n = 3, name = "Set1")

fig1 + scale_fill_manual(values=c("#E41A1C", "#4DAF4A", "#377EB8")) + 
  scale_y_continuous(breaks=seq(0, 14000000, 1000000),
                     labels = comma)


sum(df.all.debates.table$Comment_Count)

#Figure 2- Comments
fig2 <- df.all.debates.table %>%
  group_by(order) %>%
  mutate(debate = reorder(debate, order)) %>%
  ggplot(aes(debate, Comment_Count, fill = debate)) +
  geom_bar(show.legend = TRUE, position= position_dodge(width = .5), stat="identity") +
  labs(title = "Figure 2. Number of Comments by Debate (Total = 530,242)",
       y = "Comments",
       x = NULL) + theme_hc() + 
  facet_grid(~Channel_Title, scales = "free", switch = "both") +
  theme(legend.position="top", legend.title=element_blank(), text = 
          element_text(size = 14, family = "Palatino", face="bold"), panel.spacing = unit(0, "lines"),
        strip.background = element_blank(),
        strip.placement = "outside", 
        axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())

fig2 + scale_fill_manual(values=c("#E41A1C", "#4DAF4A", "#377EB8")) + 
  scale_y_continuous(breaks=seq(0, 150000, 5000),
                     labels = comma)


color_pallete <- c("#E41A1C", "#4DAF4A", "#377EB8")