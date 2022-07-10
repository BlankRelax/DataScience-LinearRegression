library(Lahman)
library(tidyverse)
library("broom")
library(caret)
data("Teams")

dat <- Teams 
#dat <- Teams %>% filter(yearID == 1971) %>% group_by(yearID) %>% mutate(BB = BB/G, HR = HR/G, R=R/G)  %>% select(BB, HR, R, yearID)
sumry_mean <- summarise(dat, mean_BB =mean(BB))

df <- data.frame(yearID = c(1961:2018))
s <- (c())

for (i in 1961:2018) {
  dat <- Teams %>% group_by(yearID) %>% filter(yearID == i) %>% select(BB, HR, yearID, R)
  sumry <- lm(R ~ HR + BB, data = dat)
  sumry_tidy <- tidy(sumry, conf.int = T)
  s <- s %>% c(sumry_tidy$estimate[3])
}
df <- df %>% mutate(estimate = s)

df %>% ggplot(aes(yearID, estimate)) + geom_point(alpha = 0.5) + geom_smooth(method = "lm")
sumry_2 <- lm(estimate ~ yearID, data = df)
tidy(sumry_2)

#sumry_mean_year <- lm(mean_BB ~ yearID, sumry_mean)
#tidy(sumry_mean_year)
#sumry_mean_year_tidy <- tidy(sumry_mean_year, conf.int = T)
#sumry_mean_year_tidy