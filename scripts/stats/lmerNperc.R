#install.packages("Matrix", dependencies = TRUE)
library(dplyr)
#library(tidyverse)
library(lme4)

df<-read.csv("data/combined/AllCombined.csv")

df$Latitude <- as.numeric(df$Latitude)


df2 <- df %>%
  filter(Habitat %in% c("marsh", "mangrove"), CN > 5, CN < 100)

marsh <- df2 %>%
  filter(Habitat %in% c("marsh"))
mangrove <- df2 %>%
  filter(Habitat %in% c("mangrove"))
CCN <-df2 %>%
  filter(Database %in% c("CCN"))

model <- lmer(N_perc ~  OC_perc*Habitat + centerdepth + (1 | study_id/core_id), data = df2, REML = false) #plot nested within source
# variability derives from different experimenters sampling different sites.

model2 <- lmer(CN ~  OC_perc * Habitat  +(1 | study_id/core_id/centerdepth), data = CCN)
#this model nests depth within plot with source

Marsh_model <- lmer(CN~ OC_perc *  centerdepth + (1 | study_id/core_id), data = marsh) #plot nested within source
# variability derives from different experimenters sampling different sites.

Mangrove_model <- lmer(CN ~ OC_perc * centerdepth +(1 | study_id/core_id), data = mangrove)
#this model nests depth within plot with source

CCN_model <- lmer(N_perc ~ OC_perc * Habitat +(1 | study_id/core_id/centerdepth), data = CCN)
#this model nests depth within plot with source


summary(model)
summary(model2)
summary(Marsh_model)
summary(Mangrove_model)

summary(CCN_model)
