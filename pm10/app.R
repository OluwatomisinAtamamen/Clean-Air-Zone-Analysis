library(shiny)
library(plotly)
library(lubridate)

source("PM10_tibble.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Air Pollutant Visualizer: Hourly Insights into Particulate Matter Levels"),
  sidebarLayout(
    conditionalPanel(
      condition = "input.tabsetPanel == 'Time Series Plot'",
      sidebarPanel(
        selectInput("selected_date", "Select Date:", choices = as.character(unique(pm_10_tibble$Date)), multiple = FALSE)
      )
    ),
    mainPanel(
      tabsetPanel(id = "tabsetPanel",
        tabPanel("Time Series Plot", plotlyOutput("time_series_plot")),
        tabPanel("Hourly Average Plot", plotlyOutput("avg_pm10_plot"))
      )
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$time_series_plot <- renderPlotly({
    # Filter PM10 data based on selected date
    filtered_data <- subset(pm_10_tibble, Date == input$selected_date)
    
    # Create time series plot using plotly
    plot_ly(filtered_data, x = ~time, y = ~`PM<sub>10</sub> particulate matter (Hourly measured)`, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>PM10 Value:", `PM<sub>10</sub> particulate matter (Hourly measured)`)) %>%
      layout(title = "PM10 Time Series Plot",
             xaxis = list(title = "Time"),
             yaxis = list(title = "PM10 Value"))
  })

  output$avg_pm10_plot <- renderPlotly({
    # Calculate average PM10 values for each hour
    avg_data <- pm_10_tibble %>%
      group_by(time) %>%
      summarise(Avg_PM10 = mean(`PM<sub>10</sub> particulate matter (Hourly measured)`))

     # Create plot of average PM10 values using plotly
    plot_ly(avg_data, x = ~time, y = ~Avg_PM10, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>Average PM10 Value:", Avg_PM10)) %>%
      layout(title = "Hourly Average PM10 Values",
             xaxis = list(title = "Time"),
             yaxis = list(title = "Average PM10 Value"))
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)