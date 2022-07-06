library(HistData)
library(tidyverse)
library(caret)
data("GaltonFamilies")

galton_heights <-GaltonFamilies %>% filter(childNum ==1 & gender == "male") %>% select(father, childHeight) %>% rename(son = childHeight)

conditional_avg <- galton_heights %>% filter(round(father) == 72) %>% summarise(avg = mean(son)) %>% .$avg
conditional_avg

#stratification

galton_heights %>% mutate(father_strata = factor(round(father))) %>% ggplot(aes(father_strata, son)) + geom_boxplot() + geom_point()
group <- galton_heights %>% mutate(father = round(father)) %>% group_by(father)
