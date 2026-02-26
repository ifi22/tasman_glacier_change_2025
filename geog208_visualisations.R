# Glacial Retreat Visualisations

# Loads packages
library(tidyverse)
library(readxl)

# Reads the excel file
glacier_data <- read_excel("ice_volume.xlsx")

# Changes names of columns and makes year numeric.
glacier_data <- glacier_data |>
  rename(ice_volume = `Ice volume (km³)`) |>
  mutate(Year = year(ymd(Year)))


# Plot of ice volume
p <- glacier_data |>
  ggplot(aes(x = Year,
             y = ice_volume
  )) +
  annotate(
    "rect",
    xmin = 2000, xmax = 2025,       # x-range to highlight
    ymin = 25, ymax = 60,           # full y-axis range
    alpha = 0.3, fill = "lightblue"    # semi-transparent highlight
  ) +
  geom_line(colour = "blue", 
            size = 1.5
  ) +
  labs(title = "Glacier Ice Volume in New Zealand between 1980–2025",
       x = "Year",
       y = "Ice Volume (km³)"
  ) +
  scale_x_continuous(
    limits = c(1980, 2025),        # start at 1980
    breaks = seq(1980, 2025, by = 5),
                 expand = c(0,0)
  ) +
  scale_y_continuous(
    limits = c(25, 60),  # normal increasing y-axis
    breaks = seq(25, 60, by = 5),
    expand = c(0,0)
  ) +
  theme_bw(base_size = 14) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        panel.grid.minor = element_blank(),
        axis.line = element_line(size = 0.2, colour = "black"
  ))

p

ggsave("glacier_volume_plot.png", 
       plot = p, 
       width = 10, 
       height = 6, 
       dpi = 300)



