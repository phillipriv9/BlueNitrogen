#read in data from csv in email from Asanopoulos

library(dplyr)

df <- read.csv("data/raw_data/Asanopoulos.csv")


df <- df  %>% 
  mutate(Method = "EA", 
        
         study_id = "Asanopouos_et_al_2021", Database="individual" )

export_data01 <- df %>% 
  dplyr::select(study_id, site_id, core_id, Habitat_type, Year_collected, 
                Latitude, Longitude, U_depth_m, L_depth_m, OC_perc, N_perc, BD_reported_g_cm3,DOI)

##### add informational  
source_name <- "Asanopoulos"
author_initials <- "CA"


#Creating CSV file
path_out = 'data/refined/'

export_file <- paste(path_out, source_name, ".csv", sep = '') 
export_df <- export_data01

write.csv(export_df, export_file)

