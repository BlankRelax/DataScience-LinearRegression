library(HistData)
library(tidyverse)
data("GaltonFamilies")

galton_heights <-GaltonFamilies %>% filter(childNum ==1 & gender == "male") %>% select(father, childHeight) %>% rename(son = childHeight) 
#galton_heights %>% summarise(cor(father, son))
lm(son ~ father, data = galton_heights)

#R <- sample_n(galton_heights, 25, replace = TRUE) %>% summarise(cor(father, son)) # small sample of parent sample
#R

#monte carlo simulation

#B <- 1000
#N <- 50
#R <- replicate(B, {
 # sample_n(galton_heights, N, replace = TRUE) %>% summarise(r = cor(father, son)) %>% .$r
#})

#data.frame(R) %>% ggplot(aes(R)) + geom_histogram(binwidth = 0.05, color = "black")
#mean(R)
#sd(R) 

rss <- function(beta0, beta1, data){
  resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  return(sum(resid^2))
}

beta1 = seq(0, 1, len=nrow(galton_heights))
results <- data.frame(beta1 =  beta1, rss = sapply(beta1, rss, beta0 = 25))

results %>% ggplot(aes(beta1, rss)) + geom_line() + geom_line(aes(beta1, rss), col=2)
results