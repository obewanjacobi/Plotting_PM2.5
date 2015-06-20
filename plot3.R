#---------------------------------------------------------------------------
# Author: Jacob Townson
# Date : 06/18/2015
# Title: plot3.R
# Class: Exploratory Data Analysis
# Question:Of the four types of sources indicated by the type (point, 
# nonpoint, onroad, nonroad) variable, which of these four sources have 
# seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
# system to make a plot answer this question.
#---------------------------------------------------------------------------

require(dplyr)
require(ggplot2)

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
type <- Baltimore$type
temp <- data.frame(year,Emissions, type)
temp <- temp %>% group_by(year,type) %>%
  summarise_each(funs(sum))
temp$type <- as.factor(temp$type)

p <- qplot(year, Emissions, data = temp, geom = c("point", "smooth"), facets = .~type)
ggsave(filename="./plot3.png", plot=p)





