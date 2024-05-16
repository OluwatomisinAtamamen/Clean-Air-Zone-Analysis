# CAZ Air Pollution Analysis

This repository contains a data analysis coursework. This contains the code and data for analyzing the effects of the Clean Air Zone (CAZ) implementation in Portsmouth, UK, on air pollution levels. The analysis focuses on particulate matter (PM10), nitric oxide, and nitrogen oxides as nitrogen dioxide.

## Data

The data for this project is provided in CSV files covering the years 2018 to 2023. The data includes measurements of PM10, nitric oxide, and nitrogen dioxide levels at the Anglesea Road monitoring station.
The data processing scripts that generates the cleaned data/tibble is also in each analysis folder.

## Analysis

The analysis is divided into five parts:

1. **PM10 Levels**

- **App URL:** [Shiny App 1](https://up2136848.shinyapps.io/pm10/)
- **Description:** This visualization shows the levels of PM10 on the specified dates.

2. **Nitric Oxide Levels**

- **App URL:** [Shiny App 2](https://up2136848.shinyapps.io/nitric_oxide/)
- **Description:** This visualization shows the levels of nitric oxide on the specified dates.

3. **Nitrogen Dioxide Levels**

- **App URL:** [Shiny App 3](https://up2136848.shinyapps.io/nitrogen_oxides_as_nitrogen_dioxide/)
- **Description:** This visualization shows the levels of nitrogen dioxide on the specified dates.

4. **Monthly Averages for 2020**

- **Description:** This visualization shows the monthly average levels of pollutants for the year 2020.

5. **Impact of Clean Air Zone on Nitrogen Pollutants(Fifth Analysis)**

- **App URL:** [Shiny App 5](https://up2136848.shinyapps.io/fifth_analysis/)
- **Description:** This visualization compares nitrogen-related pollutant levels a year before and after the implementation of the Clean Air Zone (CAZ) in Portsmouth.

### Deployment

The Shiny apps have been deployed to Shiny.io. The `rsconnect` directory is included in the `.gitignore` file to prevent sensitive information from being tracked.

### Report

A detailed report of the data curation is included as `report.pdf`.

## How to Run the Code

1. Clone the repository.
2. Navigate to the project directory.
3. Open the files with RStudio
4. Run each visualization script in the `scripts` directory to generate the visualizations.


## Acknowledgments

- University of Portsmouth for the coursework framework.
