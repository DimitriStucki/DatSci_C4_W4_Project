
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

## 2.4) Task 4: How have emissions from coal combustion-related sources changed?
## (Subset to coal cumbustion related sources)
## (Plot sum of emissions)

## 2.4.1) Subset to coal combustion
## Find SCCs for coal combustion and subset
CoalCombSCCs <- SCC[intersect(grep("[Cc]ombustion",apply(SCC[,c(3,7:10)],1,paste,collapse=" ")),
                              grep("[Cc]oal",apply(SCC[,c(3,7:10)],1,paste,collapse=" "))),"SCC"]

PM25CoalComb <- NEI[NEI$SCC %in% CoalCombSCCs,]
dim(PM25CoalComb)

## 2.4.2) Calculate the values first for faster plotting
TotalPM25ByYearCoalComb <- with(PM25CoalComb, tapply(Emissions,year,sum,na.rm=TRUE))

## 2.4.3) Plot
png("plot4.png")
par(oma=c(0,2,1,0))
barplot(TotalPM25ByYearCoalComb,main=expression(paste("Total ",PM[2.5]," emissions by year")),las=1,cex.main=1.6)
mtext("Coal combustion related sources")
mtext(side=2,line=4,cex=1.6,text=expression(paste(PM[2.5]," emissions (tons)")))
dev.off()

## End script
#######################################################################################################
