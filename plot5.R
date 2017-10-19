
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

## 2.5) Task 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
## (Subset to Baltimore)
## (Subset to motor vehicle related sources)
## (Plot sum of emissions)

## 2.5.1) Subset to Baltimore
PM25Baltimore <- subset(NEI, fips == "24510")

## 2.5.2) Subset to motor vehicle
## Find SCCs for motor vehicle
MotVecSCCs <- SCC[intersect(grep("[Mm]otor",apply(SCC[,c(3,7:10)],1,paste,collapse=" ")),
                            grep("[Vv]ehicle",apply(SCC[,c(3,7:10)],1,paste,collapse=" "))),"SCC"]

PM25MotVec <- PM25Baltimore[PM25Baltimore$SCC %in% MotVecSCCs,]

TotalPM25ByYearBaltMotVec <- with(PM25MotVec, tapply(Emissions,year,sum,na.rm=TRUE))

## 2.5.3) Plot
png("plot5.png")
par(oma=c(0,2,1,0))
barplot(TotalPM25ByYearBaltMotVec,main=expression(paste("Total ",PM[2.5]," emissions by year")),las=1,cex.main=1.6)
mtext("Motor vehicle related sources (Baltimore)")
mtext(side=2,line=4,cex=1.6,text=expression(paste(PM[2.5]," emissions (tons)")))
dev.off()

## End script
#######################################################################################################
