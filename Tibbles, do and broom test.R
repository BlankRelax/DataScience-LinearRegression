library(tidyverse)
library(broom)
library(HistData)
data("GaltonFamilies")
set.seed(1) # if you are using R 3.5 or earlier
#set.seed(1, sample.kind = "Rounding") # if you are using R 3.6 or later
galton <- GaltonFamilies %>%
  group_by(family, gender) %>%
  sample_n(1) %>%
  ungroup() %>% 
  gather(parent, parentHeight, father:mother) %>%
  mutate(child = ifelse(gender == "female", "daughter", "son")) %>%gtrfrdgr
  unite(pair, c("parent", "child"))

galton

galton %>% group_by(pair) %>% filter(pair == "mother_son") %>% summarize(cor(.$childHeight, .$parentHeight)) 
galton %>% group_by(pair) %>% filter(pair == "father_daughter") %>% summarize(cor(.$childHeight, .$parentHeight))
galton %>% group_by(pair) %>% filter(pair == "father_son") %>% summarize(cor(.$childHeight, .$parentHeight))
galton %>% group_by(pair) %>% filter(pair == "mother_daughter") %>% summarize(cor(.$childHeight, .$parentHeight))

fd_galton <- galton %>% group_by(pair) %>% do(tidy(lm(childHeight ~ parentHeight, data =.), conf.int = T)) %>% filter(pair == "father_daughter") %>% print()# %>% select(childHeight, parentHeight, conf.low, conf.high) %>% ggplot(aes(childHeight, parentHeight, ymin =conf.low, ymax = conf.high)) + geom_errorbar() + geom_point()
ms_galton <- galton %>% group_by(pair) %>% filter(pair == "mother_son") %>% do(tidy(lm(childHeight ~ parentHeight, data =.), conf.int = T)) %>% print()
fs_galton <- galton %>% group_by(pair) %>% filter(pair == "father_son") %>% do(tidy(lm(childHeight ~ parentHeight, data =.), conf.int = T)) %>% print()
md_galton <- galton %>% group_by(pair) %>% filter(pair == "mother_daughter") %>% do(tidy(lm(childHeight ~ parentHeight, data =.), conf.int = T)) %>% print()



conf_interval_md <- md_galton[2,8] - md_galton[2,7]
conf_interval_md
conf_interval_fd <- fd_galton[2,8] - fd_galton[2,7] 
conf_interval_fd
conf_interval_ms <- ms_galton[2,8] - ms_galton[2,7]
conf_interval_ms
conf_interval_fs <- fs_galton[2,8] - fs_galton[2,7] 
conf_interval_fs

