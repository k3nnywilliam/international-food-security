library(dplyr)
library(leaflet)
library(plotly)
library(ggplot2)
#library(readxl)
library(openxlsx)
#source('outFile.R')

server <- function(input, output) {

  
  #read excel data
  filedata <- reactive({
    read.xlsx("https://data.nal.usda.gov/system/files/GrainDemandProduction.xlsx")
  })
  
  #transform 2021 data
  data2021 <- reactive({
    grain <-filedata()
    
    grain <- grain %>%
      rename("metricTons" = "Millions.of.metric.tons")
    
    grain <- grain %>%
      rename("subRegion" = "Sub-region")
    
  })
  
  
  #filter by total grain demand, 2021
  df2021TotalGrain <- function() {
    
    df2021 <- data2021()
    
    grain_df2021 <- df2021 %>% filter(c(Year == "2021"))
    total2021 <- grain_df2021 %>% filter(c(Element == "Total grain demand"))
  }
  
  #filter by food demand, 2021
  sub2021FoodGrain <- function() {
    
    df2021 <- data2021()
    
    grain_df2021 <- df2021 %>% filter(c(Year == "2021"))
    total2021 <- grain_df2021 %>% filter(c(Element == "Food grain demand"))
  }
  
  #filter by grain production, 2021
  sub2021ProdGrain <- function() {
    
    df2021 <- data2021()
    
    grain_df2021 <- df2021 %>% filter(c(Year == "2021"))
    total2021 <- grain_df2021 %>% filter(c(Element == "Grain production"))
  }
  
  #filter total grain by region, 2021
  filtered_2021_plot_total <- reactive({
    totalGrain <- df2021TotalGrain()
    totalGrain <- totalGrain %>% filter(c(Region == input$region))
  })
  
  #filter food grain by region, 2021
  filtered_2021_plot_food <- reactive({
    foodgrain <- sub2021FoodGrain()
    filter(foodgrain, Region == input$region)
  })
  
  #filter grain production by region, 2021
  filtered_2021_plot_prod <- reactive({
    prodGrain <- sub2021ProdGrain()
    filter(prodGrain, Region == input$region)
  })
  
  
  # "Select", "Food grain demand", 
  #"Other grain demand", "Total grain demand", 
  #"Grain production", "Implied additional supply required"
  
  displayPlot <- function(data, title) {
    
    plot_colors <- RColorBrewer::brewer.pal(n = 3, name = "Set2")
    base::names(plot_colors) <- base::c("4", "6", "8")
    
    plotOut <-renderPlotly({
      plot_ly(
        data = data(),
        x = ~subRegion,
        y = ~metricTons,
        name = "Grain Demand",
        type = "bar",
        colors = plot_colors
      ) %>%
        layout(title = title)
    })
    
    
  }
  
  output$totalGrain2021_plot <- displayPlot(filtered_2021_plot_total, "Grain Demand Production 2021")
  output$foodGrain2021_plot <- displayPlot(filtered_2021_plot_food, "Food Demand Production 2021")
  output$foodGrain2021_prod <- displayPlot(filtered_2021_plot_prod, "Grain Production 2021")
  
}