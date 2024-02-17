library(ggplot2)
library(dplyr)
library(stringr)

# Read the CSV file into a data frame
All_combined <- read.csv("combined/AllCombined.csv")

# Filter the data for only "marsh," "mangrove," and "mudflat" habitats
filtered_data <- All_combined %>%
  filter(Habitat %in% c("marsh", "mangrove", "mudflat")) %>%
  filter(!is.na(BD_reported_g_cm3)) %>%
  filter(CN > 1, CN < 50)


# Create a new column for faceting based on BD values
filtered_data <- filtered_data %>%
  mutate(BD_facet = ifelse(BD_reported_g_cm3 > 0.5, "Bulk density > 0.50 g cm-3", "Bulk density <= 0.50"))

# Calculate error bar limits
error_limits <- filtered_data %>%
  group_by(Habitat, BD_facet) %>%
  summarise(
    count = n(),
    mean = mean(CN),
    sd = sd(CN)
  )

# Trim top and bottom 1% of CN values
filtered_data <- filtered_data %>%
  group_by(Habitat, BD_facet) %>%
  filter(CN > quantile(CN, 0.01) & CN < quantile(CN, 0.99))


# Create a violin plot with custom colors for CN colored by Habitat and faceted by BD_facet
ggplot(filtered_data, aes(x = str_to_title(Habitat), y = CN, fill = factor(Habitat, levels = c("marsh", "mangrove", "mudflat")))) +
  geom_violin(scale = "width", alpha = 1) +
  geom_point(stat = "summary", fun = "mean", color = "black", shape = 3, position = position_dodge(width = 0.75)) +
  #geom_errorbar(stat = "summary", fun.data = mean_sdl, position = position_dodge(width = 0.75), width = 0.5) +
  labs(title = NULL,
       x = NULL,
       y = "Mean C:N ratio",
       fill = "Habitat") +
  theme_minimal() +
  scale_fill_manual(values=c(marsh = "#00BFC4", mangrove = "#F8766D", mudflat="tan")) +
  scale_x_discrete(labels = function(x) str_to_title(x)) +
  scale_y_continuous(expand = c(0, 0)) +
  coord_cartesian(ylim = c(0, max(error_limits$mean) + 15)) +
  theme(axis.title.x = element_text(face = "bold", size = 12),
        axis.title.y = element_text(size = 15),
        axis.text.x =  NULL,
        axis.text.y = element_text(size = 12),
        legend.title = element_text(size = 12),
        axis.line.x.bottom = element_line(linewidth =.3),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  facet_wrap(~ BD_facet, scales = "fixed", ncol = 2)

# Calculate error bar limits
error_limits <- filtered_data %>%
  group_by(Habitat, BD_facet) %>%
  summarise(
    count = n(),
    mean = mean(CN),
    sd = sd(CN)
  )


# Print the summary statistics
print(error_limits)
