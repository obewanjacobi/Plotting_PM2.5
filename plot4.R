#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/18/2015
# Title: plot4.R
# Class: Exploratory Data Analysis
# Question:Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?
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

SCC1$EI.Sector <- as.character(SCC1$EI.Sector)
NEI$SCC <- mapvalues(NEI$SCC, SCC1$SCC, SCC1$EI.Sector)

NEI_subset <- NEI[grep("Coal", NEI$SCC), ]
NEI_subset <- NEI_subset[grep("Comb", NEI_subset$SCC), ]

Emissions <- NEI_subset$Emissions
year<- NEI_subset$year
temp <- data.frame(year,Emissions)
temp <- temp %>% group_by(year) %>%
  summarise_each(funs(sum))

p <- qplot(year, Emissions, data = temp, geom = c("point", "smooth"), 
           main = "Emissions from Coal Sources")
ggsave(filename="./plot4.png", plot=p)






