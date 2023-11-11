# Load the RSocrata library
library(RSocrata)

# Your App Token - replace with your actual app token
app_token <- "PrP3diUpKhlbO7zmASYXZCPnd"

# API endpoint with filters for Tennessee and November 2021
api_url <- "https://data.cdc.gov/resource/n8mc-b4w4.json?case_month=2021-11&res_state=TN"

# Read data from the API into a dataframe
df <- read.socrata(api_url, app_token = app_token)

# View the first few rows of the dataframe
head(df)

df <- df %>% 
  filter(!county_fips_code == 'NA')

df <- df %>% 
  select(state_fips_code, res_county, county_fips_code)

df <- df %>% 
  group_by(county_fips_code) %>% 
  summarise(cases = n())

df$county_fips_code <- as.numeric(df$county_fips_code)

df2 <- df %>% 
  left_join(county_population, by = c("county_fips_code" = "CountyFIPS"))

df2$caseperpop <- df2$cases/df2$countypop


write_csv(df2, "~/Desktop/Fall2023/GEOG370/geography370/HW8real/covidcounty2.csv")
