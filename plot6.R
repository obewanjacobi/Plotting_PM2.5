#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/18/2015
# Title: plot6.R
# Class: Exploratory Data Analysis
# Question:Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). Which city has seen greater changes over 
# time in motor vehicle emissions?
#---------------------------------------------------------------------------

require(plyr)
require(dplyr)
require(ggplot2)

## Reading in the data

if(exists("NEI") == FALSE){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
if(exists("SCC1") == FALSE){
  SCC1 <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}

## Making the plot

Baltimore <- NEI[(NEI$fips == "24510" | NEI$fips == "06037"),]

SCC1$EI.Sector <- as.character(SCC1$EI.Sector)
Baltimore$SCC <- mapvalues(Baltimore$SCC, SCC1$SCC, SCC1$EI.Sector)
Baltimore$fips <- mapvalues(Baltimore$fips, c("24510", "06037"),
                            c("Baltimore City", "Los Angeles"))
NEI_subset <- Baltimore[grep("Vehicles", Baltimore$SCC), ]

Emissions <- NEI_subset$Emissions
year<- NEI_subset$year
place <- NEI_subset$fips
temp <- data.frame(year,Emissions, place)
temp <- temp %>% group_by(year, place) %>%
  summarise_each(funs(sum))
temp$place <- as.factor(temp$place)

p <- qplot(year, Emissions, data = temp, geom = c("point", "smooth"),
           main = "Vehicle Emissions in Baltimore vs LA", facets = .~place)
ggsave(filename="./plot6.png", plot=p)






