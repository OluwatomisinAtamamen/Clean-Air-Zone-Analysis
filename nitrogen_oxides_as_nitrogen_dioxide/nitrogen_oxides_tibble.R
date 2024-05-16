library(readr)
library(dplyr)
library(lubridate)

specific_dates_2020 <- c("19/03/2020", "26/03/2020", "29/06/2020", "10/11/2020", "20/12/2020")
specific_dates_2021 <- c("03/03/2021", "29/11/2021")

poar2018 <- read_csv("POAR_2018.csv", skip = 4)
raw_no2_for_2018 <- select(poar2018, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2018 <- filter(raw_no2_for_2018, Date == "20/11/2018")
no2_for_2018 <- na.omit(filtered_no2_for_2018)


poar2019 <- read_csv("POAR_2019.csv", skip = 4)
raw_no2_for_2019 <- select(poar2019, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2019 <- filter(raw_no2_for_2019, Date == "03/01/2019")
no2_for_2019 <- na.omit(filtered_no2_for_2019)


poar2020 <- read_csv("POAR_2020.csv", skip = 4)
raw_no2_for_2020 <- select(poar2020, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2020 <- filter(raw_no2_for_2020, Date %in% specific_dates_2020)
no2_for_2020 <- na.omit(filtered_no2_for_2020)


poar2021 <- read_csv("POAR_2021.csv", skip = 4)
raw_no2_for_2021 <- select(poar2021, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2021 <- filter(raw_no2_for_2021, Date %in% specific_dates_2021)
no2_for_2021 <- na.omit(filtered_no2_for_2021)


poar2022 <- read_csv("POAR_2022.csv", skip = 4)
raw_no2_for_2022 <- select(poar2022, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2022 <- filter(raw_no2_for_2022, Date == "25/07/2022")
no2_for_2022 <- na.omit(filtered_no2_for_2022)


poar2023 <- read_csv("POAR_2023.csv", skip = 4)
raw_no2_for_2023 <- select(poar2023, Date, time, `Nitrogen oxides as nitrogen dioxide`)
filtered_no2_for_2023 <- filter(raw_no2_for_2023, Date == "24/07/2023")
no2_for_2023 <- na.omit(filtered_no2_for_2023)

no2_tibble <- bind_rows(no2_for_2018, no2_for_2019, no2_for_2020, no2_for_2021, no2_for_2022, no2_for_2023)
no2_tibble$Date <- as.Date(no2_tibble$Date, format = "%d/%m/%Y")