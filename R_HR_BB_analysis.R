library(Lahman)
library(tidyverse)
#R = runs 
#HR = homeruns
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(B_per_game = B/G, R_per_game = R/G) %>% ggplot(aes(B_per_game, R_per_game)) + geom_point(alpha = 0.5) # HOME RUNS VS RUNS
#Teams %>% filter(yearID %in% 1961:2001) %>% mutate(X3B_per_game = X3B/G, X2B_per_game = X2B/G) %>% ggplot(aes(X2B_per_game, X3B_per_game)) + geom_point(alpha = 0.5) # STOLEN BASES VS RUNS
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(W_per_game = W/G, E_per_game = E/G) %>% summarise(cor(W_per_game, E_per_game))
Teams %>% filter(yearID %in% 1961:2001) %>% mutate(X3B_per_game = X3B/G, X2B_per_game = X2B/G) %>% summarise(cor(X3B_per_game, X2B_per_game))