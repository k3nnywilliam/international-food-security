#load all necessary libraries
library(rjson)
library(readxl)
library(leaflet)
library(dplyr)
library(ggplot2)
library(plotly)
library(openxlsx)

#load all data
data <- read.csv(file = '../data/gfa25.csv')
metadata <- fromJSON(file = '../data/JSON metadata for International Food Security.json')
grain <- read.xlsx("https://data.nal.usda.gov/system/files/GrainDemandProduction.xlsx")
#grain <- read_excel(path = '../data/GrainDemandProduction.xlsx')

head(grain)
colnames(grain)
head(data)
colnames(data)

#check missing values
is.na(data)
is.na(grain)

#drop Dataset column
grain <-select(grain, -c(Dataset))
colnames(grain)

#rename metric tons and subregion
grain <- grain %>%
  rename("metricTons" = "Millions of metric tons")

grain <- grain %>%
  rename("subRegion" = "Sub-region")

grain

grain_df <- grain
grain_df

unique(grain_df[c("Element")])

#filter by years
grain_df2021 <- grain_df %>% filter(c(Year == "2021"))
grain_df2031 <- grain_df %>% filter(c(Year == "2031"))

sub2021TotalGrain <- grain_df2021 %>% filter(c(Element == "Total grain demand"))
sub2021FoodGrain <- grain_df2021 %>% filter(c(Element == "Food grain demand"))
sub2021ProdGrain <- grain_df2021 %>% filter(c(Element == "Grain production"))

#select Sub Saharan Africa region only
#grainSubSaharanAfrica2021 <- grain_df2021 %>% filter(Region == "Sub-Saharan Africa")
#grainSubSaharanAfrica2031 <- grain_df2031 %>% filter(Region == "Sub-Saharan Africa")


totalGrainPlot2021 <- ggplot(sub2021TotalGrain, aes(x=subRegion, y=metricTons)) + geom_bar(stat = "identity", fill="#f68060")
totalGrainPlot2021
totalGrainPlot2031 <- ggplot(sub2031TotalGrain, aes(x=subRegion, y=metricTons)) + geom_bar(stat = "identity", fill="#f68060")
totalGrainPlot2031


fig <- plot_ly(
  data = sub2021TotalGrain,
  x = ~subRegion,
  y = ~metricTons,
  name = "Grain Demand",
  type = "bar"
)
fig
