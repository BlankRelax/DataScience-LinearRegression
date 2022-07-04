library(Lahman)
library(tidyverse)
install.packages("HistData")
#R = runs 
#HR = homeruns
#Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_per_game = HR/G, R_per_game = R/G) %>% ggplot(aes(HR_per_game, R_per_game)) + geom_point(alpha = 0.5) # HOME RUNS VS RUNS
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(X3B_per_game = X3B/G, X2B_per_game = X2B/G) %>% ggplot(aes(X2B_per_game, X3B_per_game)) + geom_point(alpha = 0.5) # STOLEN BASES VS RUNS
