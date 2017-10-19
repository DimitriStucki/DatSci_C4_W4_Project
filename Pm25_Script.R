
                                        # Script for Data Exploration on US air pollution

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

## 2.2) Task 2: Have total emissions from PM2.5 decreased in the Baltimore City?
## (Subset to Baltimore)
## (Plot sum of emissions from all sources combined by year)

## 2.2.1) Subset to Baltimore
PM25Baltimore <- subset(NEI, fips == "24510")

## 2.2.2) Calculate the values first for faster plotting
TotalPM25ByYear <- with(PM25Baltimore, tapply(Emissions,year,sum,na.rm=TRUE))

## 2.2.3) Plot
png("plot2.png")
par(oma=c(0,2,1,0))
barplot(TotalPM25ByYear,main=expression(paste("Total ",PM[2.5]," emissions by year")),las=1,cex.main=1.6)
mtext("(Baltimore)")
mtext(side=2,line=4,cex=1.6,text=expression(paste(PM[2.5]," emissions (tons)")))
dev.off()

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

## 2.6) Task 6: Compare emissions from motor vehicle sources between Baltimore City and Los Angeles?
## (Subset to Baltimore & LA)
## (Subset to motor vehicle related sources)
## (Plot sum of emissions)

## 2.6.1) Subset to Baltimore
PM25BaltLA <- subset(NEI, (fips == "24510" | fips == "06037"))

## 2.6.2) Subset to motor vehicle
## Find SCCs for motor vehicle
MotVecSCCs <- SCC[intersect(grep("[Mm]otor",apply(SCC[,c(3,7:10)],1,paste,collapse=" ")),
                            grep("[Vv]ehicle",apply(SCC[,c(3,7:10)],1,paste,collapse=" "))),"SCC"]

PM25MotVecComp <- PM25BaltLA[PM25BaltLA$SCC %in% MotVecSCCs,]

TotalPM25ByYearBaltLAMotVec <- with(PM25MotVecComp, tapply(Emissions,list(year,fips),sum,na.rm=TRUE))

## 2.6.3) Plot
png("plot6.png")
par(oma=c(0,2,1,0))
barplot(TotalPM25ByYearBaltLAMotVec,beside=TRUE,main=expression(paste("Total ",PM[2.5]," emissions by year")),
        las=1,cex.main=1.6,names.arg=c("Los Angeles","Baltimore"))
mtext("Motor vehicle related sources (Baltimore vs LA)")
mtext(side=2,line=4,cex=1.6,text=expression(paste(PM[2.5]," emissions (tons)")))
dev.off()
