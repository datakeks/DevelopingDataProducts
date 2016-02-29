# Load libraries
library(shiny)
library(jsonlite)

# Getting the data through the UNHCR API
MedArr <- fromJSON ("http://data.unhcr.org/api/stats/mediterranean/monthly_arrivals_by_location.json?")

# Shiny app user interface structure
shinyUI(fluidPage(
        titlePanel("Mediterranean Refugee and Migration Portal"),
        # Sidebar created to display title and the summary statistics for the refugees in the selected country and year 
        sidebarLayout(position = "right",
                      sidebarPanel(
                              h3("Refugees Arrivals in Numbers"),
                              strong(textOutput("totalArrive")),
                              br(),
                              strong(textOutput("tableText")),
                              tableOutput("locMean")
                      ),
                      
                      mainPanel(
                              # Referencing the data source with a hyperlink
                              p("Population statistics provided by the ",
                                a("United Nations High Commissioner for Refugees.", 
                                  href = "http://data.unhcr.org/wiki/index.php/Get-stats-mediterranean-monthly-arrivals-by-location.html")),
                              # Main Panel title
                              h3("Mediterranean Sea Arrivals By Location"),
                              # User input widgets
                              fluidRow(
                                      column(6,
                                             radioButtons("radioSel", label = h5("Please choose country to display:"),
                                                          choices = unique(MedArr$country_en))
                                      ),               
                                      column(6,
                                             selectInput("yearArr",
                                                                label = h5("Please choose years to display:"),
                                                                choices = unique(MedArr$year), selected = 2015)
                                      )  
                              ),
                              # Display the plot of the total arrival values by location
                              plotOutput("mainPanelPlot")
                      )
        )
))