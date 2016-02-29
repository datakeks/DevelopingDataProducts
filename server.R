# Load libraries
library(shiny) # to create the app
library(curl) # dependency
library(jsonlite) # to fetch the data from the UNHCR API
library(dplyr) # to wrangle the data and calculate additional values
library(ggplot2) # to display the data

# Shiny app output calculations
shinyServer(function(input, output) {
        # Getting the data through the UNHCR API
        MedArr <- fromJSON ("http://data.unhcr.org/api/stats/mediterranean/monthly_arrivals_by_location.json?")
        
        # Subsetting the MedArr data by country, determined by user's the radio button selection
         MedSelect <- reactive({
                 subset(MedArr, country_en==input$radioSel)
         })
        
        # Subsetting the MedArr data by the second subset of year, determined by the user's drop down selection
        MedSelYr <- reactive({
                subset(MedSelect(), year==input$yearArr)
        })
        
        # Creating two new column values: LocTot calculates the Total Value by location while Proportion calculates the 
        # percentage of the Total Value for the country at each location.
        MedArrLoc <- reactive({
                MedSelYr() %>% group_by(location) %>% mutate(LocTot=sum(value))  
        })
        
        # Creating the Plot to display
        output$mainPanelPlot <-renderPlot({
                # Use ggplot2 to plot the total arrival values by location (y-axis shown in thousands make easier to read
                # without trailing zeros on the numbers). The point labels help differentiate between changes in value that might be
                # difficult for the naked eye to determine. The number labels are rounded to one decimal point. 
                ggplot(data = MedArrLoc(), aes(x = location, y = LocTot/1000, label = round(LocTot, digits = 1))) + geom_point() + 
                        geom_point(colour = "aquamarine3", size = 0.75) + geom_text(hjust= 0.45, vjust = -0.75) + 
                        labs(title = input$radioSel, x = "Arrival Location", y = "Total Number of Refugee Arrivals (in Thousands)")
        })
        
        # Sidebar statistics calculating and displaying the yearly total numer of arrivals for the selected country
        output$totalArrive <- renderText({
                #span("groups of words", style = "color:blue"),
                paste(sum(unique(MedArrLoc()$LocTot))," total number of arrivals to ", input$radioSel,
                 "in", input$yearArr, ".")
        })
        
        # Sidebar statistics calculating and displaying the year's average total number of arrivals for each location location
        output$tableText = renderText({
                paste("Average monthly number of arrivals for ", input$yearArr, "by arrival location in", input$radioSel, ":") 
        })
        output$locMean = renderTable({
                MedArrLoc() %>% summarise(average = mean(value))
        })
})
