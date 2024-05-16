library(shiny)
library(plotly)
library(lubridate)

source("nitric_oxide_tibble.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Air Pollutant Visualizer: Hourly Insights into Nitric Oxide Levels"),
  sidebarLayout(
    conditionalPanel(
      condition = "input.tabsetPanel == 'Time Series Plot'",
      sidebarPanel(
        selectInput("selected_date", "Select Date:", choices = as.character(unique(no_tibble$Date)), multiple = FALSE)
      )
    ),
    mainPanel(
      tabsetPanel(id = "tabsetPanel",
        tabPanel("Time Series Plot", plotlyOutput("time_series_plot")),
        tabPanel("Hourly Average Plot", plotlyOutput("avg_no_plot"))
      )
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$time_series_plot <- renderPlotly({
    # Filter Nitric Oxide data based on selected date
    filtered_data <- subset(no_tibble, Date == input$selected_date)
    
    # Create time series plot using plotly
    plot_ly(filtered_data, x = ~time, y = ~`Nitric oxide`, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>Nitric Oxides Value:", `Nitric oxide`)) %>%
      layout(title = " Time Series Plot",
             xaxis = list(title = "Time"),
             yaxis = list(title = "Nitric Oxide Value"))
  })

  output$avg_no_plot <- renderPlotly({
    # Calculate average Nitric Oxide values for each hour
    avg_data <- no_tibble %>%
      group_by(time) %>%
      summarise(Avg_Nitric_Oxide = mean(`Nitric oxide`))

     # Create plot of average Nitric Oxide values using plotly
    plot_ly(avg_data, x = ~time, y = ~Avg_Nitric_Oxide, type = "scatter", mode = "lines",
            hoverinfo = "text",
            text = ~paste("Time:", time, "<br>Average Nitric Oxide Value:", Avg_Nitric_Oxide)) %>%
      layout(title = "Hourly Average Nitric Oxide Values",
             xaxis = list(title = "Time"),
             yaxis = list(title = "Average Nitric Oxide Value"))
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)