
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

#Count words that repeat itself
GyppTibble <- count(WholeConversation_Tibble,WholeConversation_Ch)


gypp_plutchik <- GyppTibble %>% 
# Join to nrc lexicon
inner_join(nrc, by = c("WholeConversation_Ch" = "word")) %>% 
# Only consider Plutchik sentiments
filter(!sentiment %in% c("positive", "negative")) %>%
# Group by sentiment
group_by(sentiment) %>% 
# Get total count by sentiment
summarize(count = sum(n))

#Plot the data
ggplot(gypp_plutchik, aes(x = sentiment, y = count)) +
  # Add a column geom
  geom_col()


