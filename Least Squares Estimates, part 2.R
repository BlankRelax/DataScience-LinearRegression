library(Lahman)
library(tidyverse)
library(dplyr)
library(caret)
d_PlayerID <- bat_02 %>% distinct(playerID)

 
bat_02 <- Batting %>% filter(yearID %in% 1999:2001) %>%
  mutate(pa = AB + BB, singles_per_stint = (H - X2B - X3B - HR)/(pa), bb_per_stint = BB/(pa*stint)) %>%
  filter(pa >= 100) %>% group_by(playerID) %>% select(playerID, singles_per_stint, bb_per_stint) 

mean_singles <- summarise(bat_02, avg_single_per_plate01 =mean(singles_per_stint))
mean_bb <- summarise(bat_02, avg_bb_per_stint01 = mean(bb_per_stint))

sum(mean_singles[,2] > 0.2)
sum(mean_bb[,2] > 0.2)

bat_02 <- inner_join(bat_02, mean_singles)
bat_02 <- inner_join(bat_02, mean_bb)

bat_03 <- Batting %>% filter(yearID == 2002) %>%
  mutate(pa = AB + BB, singles_per_plates = (H - X2B - X3B - HR)/(pa), bb_per_stint = BB/(pa*stint)) %>%
  filter(pa >= 100) %>% group_by(playerID) %>% select(playerID, singles_per_plates, bb_per_stint) 

mean_singles1 <- summarise(bat_03, avg_single_per_plate02 = mean(singles_per_plates))
mean_bb1 <- summarise(bat_03,avg_bb_per_stint01 = mean(bb_per_stint))

bat_02 <- inner_join(bat_02, mean_singles1)
x <- cor(bat_02$avg_single_per_plate02, bat_02$avg_single_per_plate01)
x

bat_02 <- inner_join(bat_02, mean_bb1, by = "playerID")
y <- cor(bat_02$avg_bb_per_stint01.x, bat_02$avg_bb_per_stint01.y)
y

bat_02 <- inner_join(bat_02, bat_03, by = "playerID")
lm(bb_per_stint.y ~ avg_bb_per_stint01.x, bat_02)
lm(singles_per_plates ~ avg_single_per_plate01, bat_02)

plot(bat_02$bb_per_stint.y, bat_02$avg_bb_per_stint01.x)
plot(bat_02$singles_per_plates, bat_02$avg_single_per_plate01)
