
#######################################################################################################
## Start script

## Preliminaries
library(ggplot2)

## 1) Read the data
## The data is stored a level above the script-folder (prevents the data from being uploaded to github)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

## Check the structure
head(NEI)
str(NEI)
head(SCC)
str(SCC)

## 2.3) Task 3: Which of the sources have seen decreases/increases in emissions from 1999–2008 for Baltimore City?
## (Subset to Baltimore)
## (Plot sum of emissions from each source separately by year (ggplot))

## 2.3.1) Subset to Baltimore
PM25Baltimore <- subset(NEI, fips == "24510")
PM25Baltimore$year <- as.factor(PM25Baltimore$year)

## 2.3.2) Calculate the values first for faster plotting
### Not possible with ggplot

## 2.3.3) Plot
png("plot3.png")
with(PM25Baltimore, qplot(year,Emissions,geom="col",facets=.~type)+
                    labs(title=expression(paste("Total ",PM[2.5]," emissions by year/source")),
                         subtitle="(Baltimore)",
                         x="Year",y=expression(paste(PM[2.5]," emissions (tons)"))))
dev.off()

## End script
#######################################################################################################
