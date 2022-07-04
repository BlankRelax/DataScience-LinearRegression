library(HistData)
library(tidyverse)
data("GaltonFamilies")

galton_heights <-GaltonFamilies %>% filter(childNum ==1 & gender == "male") %>% select(father, childHeight) %>% rename(son = childHeight) 
galton_heights %>% summarise(cor(father, son))

R <- sample_n(galton_heights, 25, replace = TRUE) %>% summarise(cor(father, son)) # small sample of parent sample
R

#monte carlo simulation

B <- 1000
N <- 50
R <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>% summarise(r = cor(father, son)) %>% .$r
})

#data.frame(R) %>% ggplot(aes(R)) + geom_histogram(binwidth = 0.05, color = "black")
mean(R)
sd(R)