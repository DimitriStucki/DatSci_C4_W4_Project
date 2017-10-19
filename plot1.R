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

## 2) Data exploration
## 2.1) Task 1: Have emissions decreased?
## (Plot sum of emissions from all sources combined by year)

## 2.1.1) Calculate the values first for faster plotting
TotalPM25ByYear <- with(NEI, tapply(Emissions,year,sum,na.rm=TRUE))

## 2.1.2) Plot
png("plot1.png")
par(oma=c(0,2,1,0))
barplot(TotalPM25ByYear,main=expression(paste("Total ",PM[2.5]," emissions by year")),las=1,cex.main=1.6)
mtext(side=2,line=4,cex=1.6,text=expression(paste(PM[2.5]," emissions (tons)")))
dev.off()

## End script
#######################################################################################################
