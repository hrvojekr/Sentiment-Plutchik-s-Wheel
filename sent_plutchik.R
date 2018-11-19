
# Packges
install.packages("tidyverse")
install.packages("tidytext")

#Load Library
library(tidyverse)
library(tidytext)

# "NRC" lexicon (Plutchik's Wheel)

sent_plutchik <- get_sentiments("nrc") %>% 
  count(sentiment)

sent_plutchik

# Plot n vs. sentiment

ggplot(nrc_counts, aes(x = sentiment, y = n)) +
  # Add a col layer
  geom_col() +
  theme_gdocs()
