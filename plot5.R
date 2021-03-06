## The zip file contains two files:
## PM2.5 Emissions Data (summarySCC_PM25.rds): This file contains a data frame with all of the PM2.5 emissions 
## data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a
## specific type of source for the entire year. Here are the first few rows.
##     fips      SCC Pollutant Emissions  type year
## 4  09001 10100401  PM25-PRI    15.714 POINT 1999
## 8  09001 10100404  PM25-PRI   234.178 POINT 1999
## 12 09001 10100501  PM25-PRI     0.128 POINT 1999
## 16 09001 10200401  PM25-PRI     2.036 POINT 1999
## 20 09001 10200504  PM25-PRI     0.388 POINT 1999
## 24 09001 10200602  PM25-PRI     1.490 POINT 1999
## fips: A five-digit number (represented as a string) indicating the U.S. county
## SCC: The name of the source as indicated by a digit string (see source code classification table)
## Pollutant: A string indicating the pollutant
## Emissions: Amount of PM2.5 emitted, in tons
## type: The type of source (point, non-point, on-road, or non-road)
## year: The year of emissions recorded
## Source Classification Code Table (Source_Classification_Code.rds): 
## This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source "10100101" is known as "Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal".
## You can read each of the two files using the readRDS() function in R. For example, reading in each file can 
## be done with the following code:
## This first line will likely take a few seconds. Be patient!
## NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")
## The overall goal of this assignment is to explore the National Emissions Inventory database and see what it 
## say about fine particulate matter pollution in the United states over the 10-year period 1999-2008. 
## You may use any R package you want to support your analysis.

## Q5 
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Read data sets - I extracted into my data folder
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
SCC.df <- as.data.frame(SCC)

## Subset Baltimore data
NEI.baltimore <- subset(NEI, fips == "24510")
## Subset motor vehicle related SCC sources
SCC.vehicles <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case = T), ]
## Subset NEI where SCC in the list of motor vehicle related matches above
NEI.baltimoreVehicles <- NEI.baltimore[NEI.baltimore$SCC %in% SCC.vehicles$SCC, ]

## Sum total emissions for each year
baltimoreSumVehiclesPerYear <- aggregate(Emissions ~ year, NEI.baltimoreVehicles, FUN=sum)

library(ggplot2)
png(filename = "plot5.png", width = 918, height = 654)
# ggplot(baltimoreSumVehiclesPerYear, aes(x=year, y=Emissions)) +
#   geom_point() + geom_line() +
#   xlab("Year") + ylab("Total Emissions") + ggtitle("Vehicle Emissions in Baltimore")
## Line or bar will do, let's do the line
ggplot(baltimoreSumVehiclesPerYear, aes(x=year, y=Emissions, fill="maroon3")) +
  geom_point(alpha=0.5,size=3, shape=22) + geom_line(col="maroon3") +
  xlab("Year") + ylab("Total Emissions") + ggtitle("Motor vehicle emissions in Baltimore City (1999 - 2008)")+ 
  guides(fill=FALSE)
dev.off()