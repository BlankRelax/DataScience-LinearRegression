library(Lahman)
library(tidyverse)
library(caret)
data("Teams")
# %>% filter(yearID %in% 1961:2001
dat <- Teams %>% mutate(HR_per_game = HR/G, BB_per_game = BB/G, R_per_game = R/G)
dat %>% group_by(HR) %>% do(fit=lm(R~BB, data = .))