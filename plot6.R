
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

## End script
#######################################################################################################
