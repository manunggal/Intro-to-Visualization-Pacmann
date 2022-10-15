library(tidyverse)
library(lubridate)
library(rvest) #webscrapping
library(writexl)

# import CO2 data from our world in data from web source
# replace github.com/ with raw.githubusercontent.com/ remove blob/
data_url <- "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv"
data_source = "owid-co2-data.csv"
data_raw <- read_csv(data_source)
data_web = read_csv(data_url)

# codebook, data explanation from our world in data
data_codebook_url = "https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-codebook.csv"
data_codebook = read_csv(data_codebook_url)

# Prepare continent and region dictionaries to fill the missing values
# read html source 
country_code_source = read_html("http://www.cloford.com/resources/codes/")

# find element that match a css selector or xpath expression
# using html_elements(). in this example, 'outlinetabe'.
# use SelectorGadget to identify the CSS selector, paste it to xpath
country_ref = country_code_source %>%
  html_nodes(xpath='//*[contains(concat( " ", @class, " " ), concat( " ", "outlinetable", " " ))]') %>%
  html_table()

# previous step returns list, select first tibble in the list
# to select columns with space, use backtick ``

# select first and second table from the list, create dictionary basis
country_ref = bind_rows(country_ref[[1]],country_ref[[2]])  %>%
  # rename columns
  rename(
    ISO_2 = `ISO (2)`,
    ISO_3 = `ISO (3)`,
    ISO_No = `ISO (No)`
  ) %>%
  # remove empty row
  filter(ISO_3 != '--') 


# create dictionary of continent and region

# setdiff(x,y) --> those elements in x but not in y
# countries that has no key-values  in dictionary
missing_iso = setdiff(data_web$iso_code, country_ref$ISO_3)
missing_iso = missing_iso[!is.na(missing_iso)]

# Missing continent and region info, added with regards to missing_iso vector
missing_continent = c(
  "Americas",
  "Americas",
  "Africa",
  "Europe",
  "Europe",
  "Asia",
  "Europe",
  "Europe",
  "Americas",
  "Africa",
  "Asia",
  NA,
  "Africa")

missing_region = c(
  "West Indies",
  "West Indies",
  "Central Africa",
  "South East Europe",
  "South East Europe",
  "South West Asia",
  "South East Europe",
  "South East Europe",
  "West Indies",
  "Central Africa",
  "South East Asia",
  NA,
  "Eastern Africa"
)

# create key using country iso_code
dict_key = c(country_ref$ISO_3, missing_iso)

# create continent dict value
dict_value_continent = c(country_ref$Continent, missing_continent) 

# region dict value
dict_value_region = c(country_ref$Region, missing_region) 

# create empty list for dictionary
continent_dict = list()
region_dict = list()


# populate dictionary with key from iso_code and respective value for region and continent
for(i in 1:length(dict_key)) {
  continent_dict[dict_key[i]] <- dict_value_continent[i]
  region_dict[dict_key[i]] <- dict_value_region[i]  
}

# populate continent and region information

add_region_continent_info = function(data, continent_dict, region_dict) {
  
  # Create empty vector to contain continent and region info from the subsequence for loop
  continent_info = c()
  region_info = c()
  
  # for loop throughout rows of data
  for (i in 1:nrow(data)) {
    # populate continent info based on country iso_code and continent dictionary
    continent_info[i] = ifelse(
      is.na(data$iso_code[i]), NA,
      continent_dict[[data$iso_code[i]]]
    )
    # populate region info based on country iso_code and region dictionary
    region_info[i] = ifelse(
      is.na(data$iso_code[i]), NA,
      region_dict[[data$iso_code[i]]]
    )
  }
  
  # Add resulting vector as column in original dataframe
  data = data %>% 
    add_column(
      continent = continent_info,
      region = region_info
    )
}

# add continent and region information
data = add_region_continent_info(data_web, continent_dict, region_dict)


# save data as R object
saveRDS(data, file = "data.rds")



# ghg data per sector
data_ghg = read_csv('historical_ghg_emissions.csv')
data_ghg = data_ghg %>% mutate_at(c(colnames(data_ghg[,6:35])), as.numeric)
data_ghg$sector = forcats::fct_rev(factor(data_ghg$sector))
saveRDS(data_ghg, file = "data_ghg.rds")


