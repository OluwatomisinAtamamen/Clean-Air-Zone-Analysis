library(ggplot2)
# Create a line chart
ggplot(monthly_average_long, aes(x = Month, y = `Monthly Pollution Levels`, color = `Air Pollutants`, group = `Air Pollutants`)) +
  geom_line() +
  labs(x = "Month", y = "Monthly Pollution Levels", color = "Air Pollutants") +
  theme_minimal()