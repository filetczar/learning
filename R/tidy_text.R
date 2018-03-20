######################
# Phil Azar 
# Learning R 
# Topic: Tidy Text
######################
library(tidyverse)
library(tidytext)
library(stringr)
install.packages('janeaustenr')
library(janeaustenr)
install.packages('gutenbergr')
library(gutenbergr)
######################
#  Chapter 1
######################

# Jane Austen text mining 
original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()

original_books

# Unnesting the books into tokens
# here we are using word, can also use sentence, ngram, chapter

data(stop_words)
tidy_jane <- unnest_tokens(original_books, word, text) %>% 
              anti_join(stop_words)


unique(stop_words$lexicon)

# SMART, snowball, onix 

stop_words %>% 
  group_by(lexicon) %>% 
  summarise(words = n())

# anti join stop words 

books_clean <- tidy_books %>% 
  anti_join(stop_words)

books_clean %>% 
  count(word, sort=TRUE) %>% 
  filter(n >= 699) %>% 
  ggplot(.,aes(x=reorder(word,-n), y=n)) +
  geom_col()

######################
#  Word Frequencies
######################

# HG Wells
hgwells <- gutenberg_download(c(35,36,5230,159))

tidy_wells <- hgwells %>% 
              unnest_tokens(word, text) %>% 
              anti_join(stop_words)

tidy_wells %>% 
  count(word,sort=TRUE)

# Bronte
bronte <- gutenberg_download(c(1260, 768, 969, 9182, 767))

tidy_bronte <- bronte %>% 
              unnest_tokens(word, text) %>% 
              anti_join(stop_words)
tidy_jane


frequency <- bind_rows(mutate(tidy_bronte, author = "Brontë Sisters"),
                       mutate(tidy_wells, author = "H.G. Wells"), 
                       mutate(tidy_jane, author = "Jane Austen")) %>% 
  mutate(word = str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n / sum(n)) %>% 
  select(-n) %>% 
  spread(author, proportion) %>% 
  gather(author, proportion, `Brontë Sisters`:`H.G. Wells`)


frequency


library(scales)

# expect a warning about rows with missing values being removed
ggplot(frequency, aes(x = proportion, y = `Jane Austen`, color = abs(`Jane Austen` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001), low = "darkslategray4", high = "gray75") +
  facet_wrap(~author, ncol = 2) +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = NULL)


cor.test(data = frequency[frequency$author == "H.G. Wells",],
         ~ proportion + `Jane Austen`)


######################
#  Sentiment Analysis
######################

li
head(tidy_jane)

nrcjoy <- get_sentiments('nrc') %>% 
            dplyr::filter(sentiment=='joy')

joy_words <- tidy_jane %>% 
            filter(book=='Emma') %>% 
            inner_join(nrcjoy) %>% 
          count(word,sort = TRUE)
joy_words
  
tidy_jane %>%
  inner_join(get_sentiments("bing")) %>%
  count(book, index = linenumber %/% 80, sentiment) %>% 
  spread(sentiment, n, fill=0) %>% 
  mutate(sentiment= positive - negative) %>% 
  ggplot(.,aes(index, sentiment, fill=book)) + 
  geom_col(show.legend = FALSE) +
  facet_wrap(~book,ncol=2,scales='free_x')


70 %/% 80
