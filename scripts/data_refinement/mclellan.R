# Install and load the dplyr package if you haven't already
# install.packages("dplyr")
library(dplyr)

# read McLellan from csv file I updated from paper 
data1 <- read.csv("data/raw_data/mcclellan2021.csv")

data1 <- data1 %>%
  mutate(study_id= "MCClellan_et_al_2021", site_id=Site, core_id=Core_id)
# Save the merged data frame to a CSV file in the working directory
write.csv(data1, "data/refined/mclellan.csv", row.names = FALSE)
