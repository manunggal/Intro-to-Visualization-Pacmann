library(plotly)
library(shiny)
library(bs4Dash)
library(shinyWidgets)
library(rclipboard)
source("plotting_function.r")

header = dashboardHeader(
  "World CO2 & GHG Data Visualization",
  skin = "dark",
  status = "dark",
  span(style = "color: white; font-size: 28px, font-weight: bold;")
)

sidebar = dashboardSidebar(
  skin = "dark", status = "info", collapsed = FALSE,

  # sidebarUserPanel(
  #   name = "Select Countries"
  # ),
  selectizeInput(
    "select_data",
    label = "Select Data (Max 4)",
    choices = unique(data %>% select(country)), # %>% filter(!is.na(iso_code)) if non-country data to be removed
    selected = NULL,
    multiple = TRUE,
    options = list(
      onType = I('text => Shiny.setInputValue("input1_searchText", text)'),
      maxItems = 4
      )
    ),
  
  sidebarMenu(
    id = "sidebarmenu",
    menuItem(
      "CO2 Emissions",
      tabName = "co2_emissions",
      icon = icon("fa-solid fa-industry")
    ),
    menuItem(
      "Total Greenhouse Gasses",
      tabName = "ghg",
      icon = icon("cloud", lib = "glyphicon")
    ),
    menuItem(
      "Energy",
      tabName = "energy",
      icon = icon("fa-solid fa-bolt")
    )
  )
  
 
)

body = dashboardBody(
  tabItems(
    tabItem(
      tabName = "co2_emissions",
      fluidRow(
        box(
          title = "Annual CO2 Emissions",
          # width = 4,
          plotlyOutput("annual")
        ),
        box(
          title = "Cumulative CO2 Emissions",
          # width = 4,
          plotlyOutput("cumulative")
        ),
        box(
          title = "Per Capita CO2 Emissions",
          plotlyOutput("percapita")
        ),
        box(
          title = "Per GDP CO2 Emissions",
          plotlyOutput("pergdp")
        )
      )
    ),
    
    tabItem(
      tabName = "ghg",
      fluidRow(
        box(
          title = "Total Greenhouse Gas Emissions",
          # width = 4,
          plotlyOutput("total_ghg")
        ),
        box(
          title = "Total Greenhouse Gas Emissions per Capita",
          # width = 4,
          plotlyOutput("ghg_per_capita")
        ),
        box(
          title = "Total Greenhouse Gas Emissions per Sector",
          # width = 4,
          plotlyOutput("ghg_per_sector"),
          sliderInput("ghg_year", "Select Year", min = 1990, max = 2019, value = 2019, step = 1, sep = "")
        )
      )
    ),
    
    tabItem(
      tabName = "energy",
      fluidRow(
        box(
          title = "Primary Energy Consumption",
          # width = 4,
          plotlyOutput("primary_energy_consumption")
        ),
        box(
          title = "CO2 per Unit Energy",
          # width = 4,
          plotlyOutput("co2_per_unit_energy")
        ),
        box(
          title = "Energy per Capita",
          # width = 4,
          plotlyOutput("energy_per_capita")
        ),
        box(
          title = "Energy per GDP",
          # width = 4,
          plotlyOutput("energy_per_gdp")
        )
      )
    )
  )
)

dashboardPage(
  dark = TRUE,
  header, sidebar, body
  )

