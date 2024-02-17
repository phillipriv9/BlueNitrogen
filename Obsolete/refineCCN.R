library(dplyr)
library(readr)

folder_path <- "CCN"
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

# Initialize an empty list to store data frames from each CSV file
data_list <- list()

# Function to read and dynamically select columns from a CSV file
read_and_select_columns <- function(file_path) {
  data <- read_csv(file_path)
  
  # Get common columns between the current data and the previous ones
  common_columns <- intersect(names(data), names(data_list))
  
  # If it's not the first file, select only the common columns
  if (length(data_list) > 0) {
    data <- select(data, all_of(common_columns))
  }
  
  data_list <<- append(data_list, list(data))
}

# Apply the function to each CSV file in the folder
walk(csv_files, read_and_select_columns)

# Combine all data frames into a single data frame
combined_data <- bind_rows(data_list)

# Select only certain columns
selected_columns <- c("study_id", "site_id", "core_id", "core_year", "core_month", "core_day")
combined_data <- select(combined_data, all_of(selected_columns))

# Rename selected columns
combined_data <- rename(combined_data,
                        new_study_id = study_id,
                        new_site_id = site_id,
                        new_core_id = core_id,
                        new_core_year = core_year,
                        new_core_month = core_month,
                        new_core_day = core_day)

# Specify the folder for saving the combined data
output_folder <- "~/Dropbox (Villanova)/Manuscripts/Blue nitrogen/BlueNProject/combined"

# Save the selected and renamed columns of the combined data frame to a CSV file
output_file <- file.path(output_folder, "CCN_combined_data.csv")
write_csv(combined_data, output_file)
