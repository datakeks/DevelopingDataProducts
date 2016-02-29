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
                              # Title Documentation
                              h3("About"),
                              # Documentation referencing the app purpose and the data source with a hyperlink
                              p("The Portal App allows users to interact with the ",
                                a("United Nations High Commissioner for Refugees",
                                  href = "http://data.unhcr.org/wiki/index.php/Get-stats-mediterranean-monthly-arrivals-by-location.html"), 
                                " data to visualize trends and calculate summary statistics dependent on user inputs."),  
                              h3("Refugee Numbers"),
                              strong(textOutput("totalArrive")),
                              br(),
                              strong(textOutput("tableText")),
                              tableOutput("locMean")
                      ),
                      
                      mainPanel(
                              # Main Panel title
                              h3("User Inputs"),
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
                              # Main Plot title
                              h3("Total Number of Mediterranean Sea Arrivals By Location"),
                              
                              # Display the plot of the total arrival values by location
                              plotOutput("mainPanelPlot")
                      )
        )
))