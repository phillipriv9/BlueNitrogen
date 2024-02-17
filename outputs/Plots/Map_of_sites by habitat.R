# Install and load necessary libraries
# install.packages(c("sf", "rnaturalearth", "rnaturalearthdata"))
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(dplyr)


# Read your data (replace "your_data.csv" with your actual file name)
df1 <- read.csv("combined/AllCombined.csv")

df1_concatenated <- df1 %>%
  mutate(site_plot = paste(Source, Site_name, Site, Plot, sep = "_"))

# Convert Latitude and Longitude to numeric if needed
df1_concatenated$Latitude <- as.numeric(df1_concatenated$Latitude)
df1_concatenated$Longitude <- as.numeric(df1_concatenated$Longitude)

# ...

# Summarize
df1_summarized <- df1_concatenated %>%
  group_by(site_plot) %>%
  summarize(
    MeanLatitude = mean(Latitude, na.rm = TRUE),
    MeanLongitude = mean(Longitude, na.rm = TRUE),
    Habitat = unique(Habitat)  # Capture all unique habitat values for a given site_plot
    # Add other summary statistics or variables as needed
  )

# Join with df1_summarized to add Habitat column
df1_summarized <- left_join(df1_summarized, df1_concatenated %>% select(site_plot, Habitat), by = "site_plot")

# Load world map data from rnaturalearth
world <- ne_countries(scale = "medium", returnclass = "sf")

# Create a scatter plot of latitude vs longitude with a world map background
ggplot() +
  geom_sf(data = world, fill = "white", color = "gray") +
  geom_point(data = df1_summarized, aes(x = MeanLongitude, y = MeanLatitude, color = "Habitat.x"), shape = 1, size = 2) +
  labs(title = "Map of Sites",
       x = "Longitude",
       y = "Latitude") +
  theme_minimal() +
  coord_sf(lims_method = "geometry_bbox")