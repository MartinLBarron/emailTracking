library(tidyverse)

df <- read_csv("data/emailCounter.csv") %>%
  mutate(Date=as.Date(Date))
