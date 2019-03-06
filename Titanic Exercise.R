# titanic exercise
library(readxl)
library("dplyr")
library("tidyr")
titanic_clean1 <- titanic3 %>% 
  mutate(embarked = ifelse(grepl(" ", embarked, ignore.case = TRUE), "S", embarked)) %>% 
  replace_na(list(embarked = "S"))

titanic_clean1 %>% summarise(avg_age = mean(age, na.rm = TRUE))

titanic_clean1 <- titanic_clean1 %>% replace_na(list(age = 30))

titanic_clean1 <- titanic_clean1 %>% replace_na(list(boat = "NONE"))

titanic_clean1 <- titanic_clean1 %>% replace_na(list(cabin = "NONE"))

titanic_clean1 <- titanic_clean1 %>% mutate(has_cabin_number = ifelse(grepl("NONE", cabin), 0, 1))

write.csv(titanic_clean1, "titanic_clean1.csv", row.names = FALSE)

library(ggplot2)

str(titanic_clean1)

posn.jd <- position_jitterdodge(0.5, 0, 0.6)
ggplot(titanic_clean1, aes(x = pclass, y = age, col = sex)) + geom_point(position = posn.jd, size = 3, alpha = 0.5) + facet_grid(. ~ survived)