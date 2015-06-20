#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/18/2015
# Title: plot5.R
# Class: Exploratory Data Analysis
# Question:How have emissions from motor vehicle sources changed from 
# 1999–2008 in Baltimore City?
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

Baltimore <- NEI[NEI$fips == "24510",]

SCC1$EI.Sector <- as.character(SCC1$EI.Sector)
Baltimore$SCC <- mapvalues(Baltimore$SCC, SCC1$SCC, SCC1$EI.Sector)

NEI_subset <- Baltimore[grep("Vehicles", Baltimore$SCC), ]

Emissions <- NEI_subset$Emissions
year<- NEI_subset$year
temp <- data.frame(year,Emissions)
temp <- temp %>% group_by(year) %>%
  summarise_each(funs(sum))

p <- qplot(year, Emissions, data = temp, geom = c("point", "smooth"),
           main = "Vehicle Emissions in Baltimore")
ggsave(filename="./plot5.png", plot=p)






