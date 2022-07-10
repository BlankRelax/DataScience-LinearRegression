library(Lahman)
library(tidyverse)
library("broom")
library(caret)
data("Teams")

fit <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_per_game = HR/G, BB_per_game = BB/G, R_per_game = R/G) %>% lm(R_per_game ~ BB_per_game + HR_per_game, data =.)
tidy(fit, conf.int=TRUE)
#Teams %>% filter(yearID %in% 1961:2001) %>% mutate(B_per_game = B/G, R_per_game = R/G) %>% ggplot(aes(B_per_game, R_per_game)) + geom_point(alpha = 0.5) # HOME RUNS VS RUNS
#Teams %>% filter(yearID %in% 1961:2001) %>% mutate(X3B_per_game = X3B/G, X2B_per_game = X2B/G) %>% ggplot(aes(X2B_per_game, X3B_per_game)) + geom_point(alpha = 0.5) # STOLEN BASES VS RUNS
T#eams %>% filter(yearID %in% 1961:2001) %>% mutate(W_per_game = W/G, E_per_game = E/G) %>% summarise(cor(W_per_game, E_per_game))
Info <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_per_game = HR/G, BB_per_game = BB/G, R_per_game = R/G) %>% lm(R_per_game ~ BB_per_game, data =.)
lse <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_per_game = HR/G, BB_per_game = BB/G, R_per_game = R/G) %>% lm(R_per_game ~ BB_per_game, data =.) %>% .$coef
lse 
summary(Info)

#dat <- Teams %>% filter(yearID %in% 1961:2001) %>% mutate(HR_strata = round(HR/G,1), BB_per_game = BB/G, R_per_game = R/G) %>% filter(HR_strata >= 0.4 & HR_strata <=1.2)
#dat %>% ggplot(aes(BB_per_game, R_per_game)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")# + facet_wrap(~HR_strata)

pa_per_game <- Batting %>% 
  filter(yearID == 2002) %>% 
  group_by(teamID) %>%
  summarize(pa_per_game = sum(AB+BB)/max(G))# %>% 
  #.$pa_per_game %>% 
 # mean

