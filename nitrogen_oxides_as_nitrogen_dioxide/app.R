library(shiny)
library(plotly)
library(lubridate)

source("nitrogen_oxides_tibble.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Air Pollutant Visualizer: Hourly Insights into Total Nitrogen Oxides (as Nitrogen Dioxide) Concentration"),
  sidebarLayout(
    conditionalPanel(
      condition = "input.tabsetPanel == 'Time Series Plot'",
      sidebarPanel(
        selectInput("selected_date", "Select Date:", choices = as.character(unique(no2_tibble$Date)), multiple = FALSE)
      )
    ),
    mainPanel(
      tabsetPanel(id = "tabsetPanel",
        tabPanel("Time Series Plot", plotlyOutput("time_series_plot")),
        tabPanel("Hourly Average Plot", plotlyOutput("avg_no2_plot"))
      )
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$time_series_plot <- renderPlotly({
    # Filter NO2 data based on selected date
    filtered_data <- subset(no2_tibble, Date == input$selected_date)
    
    # Create time series plot using plotly
    plot_ly(filtered_data, x = ~time, y = ~`Nitrogen oxides as nitrogen dioxide`, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>NO2 Value:", `Nitrogen oxides as nitrogen dioxide`)) %>%
      layout(title = " Time Series Plot",
             xaxis = list(title = "Time"),
             yaxis = list(title = "Nitrogen Oxides Value"))
  })

  output$avg_no2_plot <- renderPlotly({
    # Calculate average NO2 values for each hour
    avg_data <- no2_tibble %>%
      group_by(time) %>%
      summarise(Avg_NO2 = mean(`Nitrogen oxides as nitrogen dioxide`))

     # Create plot of average NO2 values using plotly
    plot_ly(avg_data, x = ~time, y = ~Avg_NO2, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>Average NO2 Value:", Avg_NO2)) %>%
      layout(title = "Hourly Average NO2 Values",
             xaxis = list(title = "Time"),
             yaxis = list(title = "Average Nitrogen Oxides Value"))
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)