Mediterranean Refugee and Migration Portal
========================================================
author: datakeks
date: 29 February 2016
transition: rotate

The number of refugees and migrants arriving to Europe via Mediterranean routes dramatically increased in recent years. Analyzing refugee and migration statistics is key to understanding migration patterns and balancing humanitarian efforts. The Mediterranean Refugee and Migration Portal allows users to interact with the United Nations High Commissioner for Refugees (UNHCR) statistics collected from January 2014 to January 2016.                             

Why Use the Mediterranean Refugee and Migration Portal?
========================================================
Do you want to learn more about the Mediterranean refugee crisis? Are curious about the trends and geography of Mediterranean route migration? Then the Mediterranean Refugee and Migration Portal app is for you!

* The Shiny Application can be found at [Shinyapps.io](https://datakeks.shinyapps.io/Mediterranean_Refugee_Migration_Portal)

* The source codes can be found on [GitHub](https://github.com/datakeks/DevelopingDataProducts)

About the Portal App
========================================================
###### User Inputs: 
- Country (options: Italy, Spain, and Greece)
- Year (options: 2014, 2015, 2016)

###### Application Outputs:
- Plot of Mediterranean Sea arrivals by month for the user input selected country and year
- Calculation of the total number of arrivals country-wide in the user input selected country and year
- Calculation of the average monthly number of arrivals by arrival location for the user input selected country and year

###### Required R Packages are shiny, curl, jsonlite, dplyr, ggplot2

Where does the Information Come From?
========================================================
Data is fetched from the [UNHCR API] (http://data.unhcr.org/wiki/index.php/API_Documentation) using the jsonlite package. Data is reported by UNHCR monthly on the following fields per location:



```r
names(MedArr)
```

```
 [1] "country"            "country_en"         "location"          
 [4] "location_latitude"  "location_longitude" "year"              
 [7] "month"              "month_en"           "value"             
[10] "last_updated"       "location_total"    
```

Interacting With Data in the Portal
========================================================
###### App Instructions:
For use in the portal, the UNHCR Mediterranean Arrival Location information is subset dependent on both the user input selections for year and country. Further data wrangling in the server file, including grouping by location to calculate addition values such as the arrival location yearly totals and monthly averages, is enacted with the dplyr package. To use the tool, select the country of choice with the corresponding radial button and the desired display year from the dropdown. The plot created with the ggplot2 package and the relevant statistic calculations will change to reflect the user selections. 
