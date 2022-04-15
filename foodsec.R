#load all necessary libraries
library(rjson)
library(readxl)
library(dplyr)
library(ggplot2)

#load all data
data <- read.csv(file = 'data/gfa25.csv')
metadata <- fromJSON(file = 'data/JSON metadata for International Food Security.json')
grain <- read_excel(path = 'data/GrainDemandProduction.xlsx')

head(grain)
colnames(grain)
head(data)
colnames(data)

#check missing values
is.na(data)
is.na(grain)

#copy grain demand production spreadsheet
graindrp <- grain 

#rename metric tons and subregion
graindrp <- graindrp %>% 
  rename(vars(oldnames), ~newnames)

graindrp <- graindrp %>%
  rename("metricTons" = `Millions of metric tons`)

graindrp <- graindrp %>%
  rename("subRegion" = "Sub-region")

#drop Dataset column
graindrp <-select(graindrp, -c(Dataset))
colnames(graindrp)

#select Sub Saharan Africa region only
grainSubSaharanAfrica <- graindrp %>% filter(Region == "Sub-Saharan Africa")

#filter by 2021
sub2021 <- grainSubSaharanAfrica %>% filter(c(Year == "2021"))

sub2021TotalGrain <- sub2021 %>% filter(c(Element == "Total grain demand"))

totalGrainPlot <- ggplot(sub2021TotalGrain, aes(x=subRegion, y=metricTons)) + geom_bar(stat = "identity", fill="#f68060")
totalGrainPlot
