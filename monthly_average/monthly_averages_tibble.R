library(readr)
library(dplyr)
library(lubridate)
library(tidyr)

poar_2020 <- read_csv("POAR_2020.csv", skip = 4)
raw_data_for_2020 <- select(poar_2020, Date, time, `PM<sub>10</sub> particulate matter (Hourly measured)`, `Nitric oxide`, `Nitrogen oxides as nitrogen dioxide`)
data_for_2020 <- na.omit(raw_data_for_2020)

# Group by month and calculate the monthly average
monthly_average <- data_for_2020 %>%
  mutate(Month = month(Date, label = TRUE)) %>%
  group_by(Month) %>%
  summarise(
    Average_PM10 = mean(`PM<sub>10</sub> particulate matter (Hourly measured)`, na.rm = TRUE),
    Average_Nitric_Oxide = mean(`Nitric oxide`, na.rm = TRUE),
    Average_Nitrogen_Dioxide = mean(`Nitrogen oxides as nitrogen dioxide`, na.rm = TRUE)
  )

monthly_average_long <- pivot_longer(monthly_average, -Month, names_to = "Air Pollutants", values_to = "Monthly Pollution Levels")
