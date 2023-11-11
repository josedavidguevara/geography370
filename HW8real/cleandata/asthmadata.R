## cleaning data for hw8


#load libraries
library(tidyverse)
library(dplyr)


data <- read.csv("../PLACES__Local_Data_for_Better_Health__Census_Tract_Data_2023_release_20231108.csv")

#select TN data in 2020
data <- data %>% 
  filter(StateAbbr == "TN" & MeasureId == "CASTHMA")

data <- data %>% 
  group_by(CountyFIPS) %>% 
  mutate(countypop = sum(TotalPopulation, na.rm = TRUE)) %>% 
  ungroup()

# Assuming the rest of your code is correct and data is already filtered and grouped

# Create a new dataframe with unique CountyFIPS and their corresponding total population
county_population <- data %>% 
  select(CountyFIPS, countypop) %>% 
  distinct(CountyFIPS, .keep_all = TRUE)


data2 <- data %>% 
  summarise(countypop)


data <- data %>% 
  select(CountyName, CountyFIPS, LocationName, Data_Value, MeasureId, TotalPopulation, countypop)


write_csv(data, "~/Desktop/Fall2023/GEOG370/geography370/HW8real/asthma.csv")
