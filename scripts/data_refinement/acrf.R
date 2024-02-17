## import data from Rovai et al. 2018

library(dplyr)
library(magrittr)
library(tidyverse)


input_file01 <- "acrf.csv"

input_data01 <- read.csv(input_file01)

##### add informational  
source_name <- "acrf"
author_initials <- "acrf"



#### export ####

export_data01 <- input_data01 %>% 
  dplyr::select(study_id, site_id, core_id, Habitat_type, Year_collected, 
                Latitude, Longitude, U_depth_m, L_depth_m, OC_perc, N_perc, BD_reported_g_cm3,DOI)


## export

path_out = 'refined/'

export_file <- paste(path_out, source_name, ".csv", sep = '') 
export_df <- export_data01

write.csv(export_df, export_file)