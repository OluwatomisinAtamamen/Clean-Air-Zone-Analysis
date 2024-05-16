library(readr)
library(dplyr)
library(lubridate)


poar_2020 <- read_csv("POAR_2020.csv", skip = 4)
btc_data_for_2020 <- select(poar_2020, Date, time, `Nitrogen dioxide`, `Nitric oxide`, `Nitrogen oxides as nitrogen dioxide`)
data_2020 <- na.omit(btc_data_for_2020)

poar_2021 <- read_csv("POAR_2021.csv", skip = 4)
btc_data_for_2021 <- select(poar_2021, Date, time, `Nitrogen dioxide`, `Nitric oxide`, `Nitrogen oxides as nitrogen dioxide`)
data_2021 <- na.omit(btc_data_for_2021)

poar_2022 <- read_csv("POAR_2022.csv", skip = 4)
btc_data_for_2022 <- select(poar_2022, Date, time, `Nitrogen dioxide`, `Nitric oxide`, `Nitrogen oxides as nitrogen dioxide`)
data_2022 <- na.omit(btc_data_for_2022)

# Convert Date column to Date type
data_2020$Date <- as.Date(data_2020$Date, format = "%d/%m/%Y")
data_2021$Date <- as.Date(data_2021$Date, format = "%d/%m/%Y")
data_2022$Date <- as.Date(data_2022$Date, format = "%d/%m/%Y")

# Combine all data
all_data <- bind_rows(data_2020, data_2021, data_2022)

# Filter data for 28/11/2020 to 28/11/2021(Before CAZ)
data_before <- filter(all_data, Date >= as.Date("2020-11-28") & Date <= as.Date("2021-11-28"))

# Filter data for 30/11/2021 to 30/11/2022(After CAZ)
data_after <- filter(all_data, Date >= as.Date("2021-11-30") & Date <= as.Date("2022-11-30"))

# Calculate average for every day in data_before
avg_before <- data_before %>%
  group_by(Date) %>%
  summarise(Avg_NO2 = mean(`Nitrogen dioxide`),
            Avg_NO = mean(`Nitric oxide`),
            Avg_NOx = mean(`Nitrogen oxides as nitrogen dioxide`))

# Calculate average for every day in data_after
avg_after <- data_after %>%
  group_by(Date) %>%
  summarise(Avg_NO2 = mean(`Nitrogen dioxide`),
            Avg_NO = mean(`Nitric oxide`),
            Avg_NOx = mean(`Nitrogen oxides as nitrogen dioxide`))