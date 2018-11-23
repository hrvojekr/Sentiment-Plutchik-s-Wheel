
# Packges
install.packages("tidyverse")
install.packages("tidytext")
install.packages("xlsx")

#Load Library
library(tidyverse)
library(tidytext)
library(xlsx)


#Get the data
WholeConversation <- read.delim("gyppwhole.txt")


#Get the nrc lexicon
nrc <- get_sentiments("nrc")


#Make DF the same type
# is.factor(WholeConversation$gypp_text)
# is.character(nrc$word)
WholeConversation_Ch <- as.character(WholeConversation$gypp_text)

WholeConversation_Tibble <- tibble(WholeConversation_Ch)


gypp_plutchik <- WholeConversation_Tibble %>% 
# Join to nrc lexicon
inner_join(nrc, by = c("WholeConversation_Ch" = "word")) %>% 
# Only consider Plutchik sentiments
filter(!sentiment %in% c("positive", "negative")) %>%
# Group by sentiment
group_by(sentiment) %>% 
# Get total count by sentiment
summarize(total_count = sum(count))


