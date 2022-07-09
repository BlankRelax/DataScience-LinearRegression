library(HistData)
library(tidyverse)
library(gridExtra)
data("GaltonFamilies")

galton_heights <-GaltonFamilies %>% filter(childNum ==1 & gender == "male") %>% select(father, childHeight) %>% rename(son = childHeight) 
#galton_heights %>% summarise(cor(father, son))
fit <- lm(son ~ father, data = galton_heights)
summary(fit) #LSE for Least Squares Estimate

#R <- sample_n(galton_heights, 25, replace = TRUE) %>% summarise(cor(father, son)) # small sample of parent sample
#R

#monte carlo simulation

#B <- 1000
#N <- 25
#lse <- replicate(B, {
 # sample_n(galton_heights, N, replace = TRUE) %>% lm(son ~ father, data = .) %>% .$coef
#})
#lse = data.frame(beta_0 =lse[1,], beta_1 = lse[2, ]) #correlation of non-standardsied variabes


#B <- 1000
#N <- 50
#lse <- replicate(B, {
 # sample_n(galton_heights, N, replace = TRUE) %>%
  #  mutate(father = father - mean(father)) %>% #correlation of standarised models
   # lm(son ~ father, data = .) %>% .$coef 
#})

#cor(lse[1,], lse[2,]) 
  



#p1 <- lse %>% ggplot(aes(beta_0)) + geom_histogram(binwidth = 5, color = "black")
#p2 <- lse %>% ggplot(aes(beta_1)) + geom_histogram(binwidth = 0.1, color = "black")
#grid.arrange(p1, p2, ncol=2)

#mean(R)
#sd(R) 

B <- 1000
N <- 100
lse <- replicate(B, {
  sample_n(galton_heights, N, replace = TRUE) %>% 
    lm(son ~ father, data = .) %>% .$coef 
})

lse <- data.frame(beta_0 = lse[1,], beta_1 = lse[2,])

#rss <- function(beta0, beta1, data){ #residual sum of squares
 # resid <- galton_heights$son - (beta0+beta1*galton_heights$father)
  #return(sum(resid^2))
#}

#beta1 = seq(0, 1, len=nrow(galton_heights))
#results <- data.frame(beta1 =  beta1, rss = sapply(beta1, rss, beta0 = 36))

#results %>% ggplot(aes(beta1, rss)) + geom_line() + geom_line(aes(beta1, rss), col=2)
