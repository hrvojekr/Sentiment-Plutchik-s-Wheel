
# Packges
install.packages("tidyverse")
install.packages("tidytext")
install.packages("xlsx")

#Load Library
library(tidyverse)
library(tidytext)
library(xlsx)
library(readxl)

#Get the data
testSloSent <- read.delim("tadejtext.txt", fileEncoding = "UTF-8"  )
#testSloSent <- "Z dodatnimi minutami ste me prijetno presenetili. Res super!"

#Slovenian Dictionary
sloLex <- read.xlsx("slo_sentiments_dictionary_opt.xlsx", sheetIndex = 1 , encoding="UTF-8")
tibble(sloLex)
sloLex <- read_excel("slo_sentiments_dictionary_opt.xlsx")

sloSentList <- as.list(sloLex)
SloSentTibble <- tibble(sloSentList)

#Make DF the same type
# is.factor(WholeConversation$gypp_text)
# is.character(nrc$word)

WholeConversation_Ch <- as.character(testSloSent$gypp_text)
WWhWholeConversation_Tibble <- tibble(WholeConversation_Ch)

#Count words that repeat itself
GyppTibbleSlo <- count(WWhWholeConversation_Tibble,WholeConversation_Ch)

gypp_plutchik <- GyppTibbleSlo %>% 
  # Join to nrc lexicon
  inner_join(sloLex, by = c("WholeConversation_Ch" = "word")) %>% 
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
