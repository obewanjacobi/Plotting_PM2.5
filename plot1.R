#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/19/2015
# Title: plot1.R
# Class: Exploratory Data Analysis
# Question:Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot showing 
# the total PM2.5 emission from all sources for each of the years 1999, 
# 2002, 2005, and 2008.
#---------------------------------------------------------------------------

require(dplyr)

## Reading in the data

if(exists("NEI") == FALSE){
    NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
if(exists("SCC") == FALSE){
    SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Making the plot

Emissions <- NEI$Emissions
year<- NEI$year
temp <- data.frame(year,Emissions)
temp <- temp %>% group_by(year) %>%
  summarise_each(funs(sum))

png("./plot1.png")

plot(Emissions~year, data = temp, type = "b",
     ylab = "sum of measured emissions", xlab = "year measured",
     main = "Total Emissions by Year")

dev.off()





