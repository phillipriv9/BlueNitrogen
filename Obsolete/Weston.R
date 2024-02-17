## import data from Yuan et al 2017, Fig Share
#https://doi.org/10.1016/j.jmarsys.2017.06.001
## from Andong salt marsh, China
## export for marsh soil C
# contact Tania Maxwell, tlgm2@cam.ac.uk
# 20.07.22

library(dplyr)
library(magrittr)
library(tidyverse)


input_file01 <- "WestonLangleyCCN.csv"

input_data01 <- read.csv(input_file01)

input_data01 <- input_data01 %>% 
  rename_with(~ gsub("..", "_", .x, fixed = TRUE)) %>% #replacing .. in columns by _
  rename_with(~ gsub(".", "_", .x, fixed = TRUE))  #replacing . in columns by _

input_data02 <- input_data01  %>% 
mutate(Method = "EA", 
       U_depth_m = as.numeric(U_depth_cm)/100 , #cm to m
       L_depth_m = as.numeric(L_depth_cm)/100)# cm to m

##### add informational  
source_name <- "WestonLangleyCCN"
author_initials <- "AL"



#### export ####

export_data01 <- input_data02 %>% 
  dplyr::select(Source, Site_name, Site, Plot, Habitat_type, Year_collected, Method,
                Latitude, Longitude, U_depth_m, L_depth_m, OC_perc, N_perc, BD_reported_g_cm3)


export_data02 <- export_data01 %>% 
  relocate(Source, Site_name, Site, Plot, Habitat_type, Latitude, Longitude, 
          Year_collected, .before = U_depth_m) %>% 
  arrange(Site, Habitat_type) %>% 
  mutate(DOI = "https://doi.org/10.1016/j.jmarsys.2017.06.001")

## export

path_out = 'refined/'

export_file <- paste(path_out, source_name, ".csv", sep = '') 
export_df <- export_data02

write.csv(export_df, export_file)