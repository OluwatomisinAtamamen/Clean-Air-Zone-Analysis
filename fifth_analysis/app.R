library(shiny)
library(plotly)
library(lubridate)
library(dygraphs)

source("CAZ_effect_tibble.R")

# Define UI ----
ui <- fluidPage(
  titlePanel("Comparison of Air Pollutant Concentrations Before and After Clean Air Zone Implementation"),
  mainPanel(
    tabsetPanel(id = "tabsetPanel",
      tabPanel("Before Clean Air Zone Implementation", 
               dygraphOutput("dygraph_before_NO2"),
               dygraphOutput("dygraph_before_NO"),
               dygraphOutput("dygraph_before_NOx")),
      tabPanel("After Clean Air Zone Implementation", 
               dygraphOutput("dygraph_after_NO2"),
               dygraphOutput("dygraph_after_NO"),
               dygraphOutput("dygraph_after_NOx"))
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  output$dygraph_before_NO2 <- renderDygraph({
    dygraph(avg_before[, c("Date", "Avg_NO2")], main = "Average Nitrogen dioxide Before") %>%
      dyRangeSelector()
  })

  output$dygraph_before_NO <- renderDygraph({
    dygraph(avg_before[, c("Date", "Avg_NO")], main = "Average Nitric Oxide Before") %>%
      dyRangeSelector()
  })

  output$dygraph_before_NOx <- renderDygraph({
    dygraph(avg_before[, c("Date", "Avg_NOx")], main = "Average Nitrogen Oxides (as Nitrogen Dioxide) Before") %>%
      dyRangeSelector()
  })

  output$dygraph_after_NO2 <- renderDygraph({
    dygraph(avg_after[, c("Date", "Avg_NO2")], main = "Average Nitrogen dioxide After") %>%
      dyRangeSelector()
  })

  output$dygraph_after_NO <- renderDygraph({
    dygraph(avg_after[, c("Date", "Avg_NO")], main = "Average Nitric Oxide After") %>%
      dyRangeSelector()
  })

  output$dygraph_after_NOx <- renderDygraph({
    dygraph(avg_after[, c("Date", "Avg_NOx")], main = "Average Nitrogen Oxides (as Nitrogen Dioxide) After") %>%
      dyRangeSelector()
  })
}

# Run the app ----
shinyApp(ui = ui, server = server)