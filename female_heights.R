set.seed(1989) #if you are using R 3.5 or earlier
#set.seed(1989, sample.kind="Rounding") #if you are using R 3.6 or later
library(HistData)
data("GaltonFamilies")

female_heights <- GaltonFamilies%>%     
  filter(gender == "female") %>%     
  group_by(family) %>%     
  sample_n(1) %>%     
  ungroup() %>%     
  select(mother, childHeight) %>%     
  rename(daughter = childHeight)

rho <- female_heights %>% summarise(rho1 = cor(daughter, mother)) 
0.325 * (2.39/2.29)
64.3 - (0.325 * (2.39/2.29))*64.1
