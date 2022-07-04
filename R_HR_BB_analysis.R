library(Lahman)
library(tidyverse)
#R = runs 
#HR = homeruns
#Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_per_game = HR/G, R_per_game = R/G) %>% ggplot(aes(HR_per_game, R_per_game)) + geom_point(alpha = 0.5) # HOME RUNS VS RUNS
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(SB_per_game = SB/G, R_per_game = R/G) %>% ggplot(aes(SB_per_game, R_per_game)) + geom_point(alpha = 0.5) # STOLEN BASES VS RUNS
data("Teams")