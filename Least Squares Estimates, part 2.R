library(Lahman)
library(tidyverse)
library(dplyr)
library(caret)

bat_02 <- Batting %>% filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB, singles = (H - X2B - X3B - HR)/pa, bb = BB/pa) %>%
  filter(pa >= 100) 


playerID_d = bat_02 %>% distinct(playerID)


bat_02 <- bat_02 %>% mutate(BB_per_stint = BB/stint, singles_rate_per_stint = singles/stint)
bat_02_99 <- bat_02 %>% filter(yearID == 1999) %>% select(playerID, BB_per_stint, singles_rate_per_stint)
bat_02_00 <- bat_02 %>% filter(yearID == 2000) %>% select(playerID, BB_per_stint, singles_rate_per_stint)
bat_02_01 <- bat_02 %>% filter(yearID == 2001) %>% select(playerID, BB_per_stint, singles_rate_per_stint)

avg_BB_per_stint_pp <- for (x in playerID_d) {
  bat_02_99$BB_per_stint + bat_02_00$BB_per_stint + bat_02_01$BB_per_stint
}

avg_BB_per_stint_pp
