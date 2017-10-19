
# Data exploration on US air pollution

## 1) The task

You must address the following questions and tasks in your exploratory analysis. For each question/task you will need to make a single plot. Unless specified, you can use any plotting system in R to make your plot.

1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.  
2) Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.  
3) Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.  
4) Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?  
5) How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?  
6) Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?  

## 2) The data

### summarySCC_PM25.rds:  
This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. Here are the first few rows.  

fips: A five-digit number (represented as a string) indicating the U.S. county  
SCC: The name of the source as indicated by a digit string (see source code classification table)  
Pollutant: A string indicating the pollutant  
Emissions: Amount of PM2.5 emitted, in tons  
type: The type of source (point, non-point, on-road, or non-road)  
year: The year of emissions recorded  

### Source_Classification_Code.rds:  
This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”.  

## 3) The script

### File overview  

summarySCC_PM25.rds -- PM25 data (needs to be placed one path-layer above the scripts)
Source_Classification_Code.rds -- SCC code information (needs to be placed one path-layer above the scripts)
README.md -- This readme file  
PM25_Script.R -- Contains the codes for all graphs  
plot1.R -- Code for plot 1 (including reading the data)  
plot1.png -- plot 1  
plot2.R -- Code for plot 2 (including reading the data)  
plot2.png -- plot 2  
plot3.R -- Code for plot 3 (including reading the data)  
plot3.png -- plot 3  
plot4.R -- Code for plot 4 (including reading the data)  
plot4.png -- plot 4  
plot5.R -- Code for plot 5 (including reading the data)  
plot5.png -- plot 5  
plot6.R -- Code for plot 6 (including reading the data)  
plot6.png -- plot 6
