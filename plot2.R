#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/18/2015
# Title: plot2.R
# Class: Exploratory Data Analysis
# Question:Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting 
# system to make a plot answering this question
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

Baltimore <- NEI[NEI$fips == "24510",]

Emissions <- Baltimore$Emissions
year<- Baltimore$year
temp <- data.frame(year,Emissions)
temp <- temp %>% group_by(year) %>%
  summarise_each(funs(sum))

png("./plot2.png")

plot(Emissions~year, data = temp, type = "b",
     ylab = "sum of measured emissions", xlab = "year measured",
     main = "Total Emissions in Baltimore City by Year")

dev.off()



