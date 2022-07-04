library(HistData)
library(tidyverse)
library()
data("GaltonFamilies")

galton_heights <-GaltonFamilies %>% filter(childNum ==1 & gender == "male") %>% select(father, childHeight) %>% rename(son = childHeight) 
galton_heights %>% summarise(cor(father, son))