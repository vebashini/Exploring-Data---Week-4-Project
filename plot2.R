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

## Q2 
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
## 1999 to 2008? Use the base plotting system to make a plot answering this question.
## Read data sets - I extracted into my data folder
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Subset the Baltimore data
baltimoreNEI <- subset(NEI, fips == "24510")

## Sum total emissions for each year for the Baltimore, Maryland area
baltimoreSumPerYear <- aggregate(Emissions ~ year, baltimoreNEI, FUN=sum)

## Have emissions decreased? You can see from the graph, that the trend is NOT strictly decreasing
## 2005 > 2002, however 2008 is the lowest to date
png(filename = "plot2.png", width = 480, height = 480)
barplot(baltimoreSumPerYear$Emissions, names.arg=baltimoreSumPerYear$year, col = "lightblue",
        xlab = "Year", ylab = "Total PM2.5 Emissions",
        main = "Total PM2.5 emissions for Baltimore City, Maryland (1999 - 2008)")
dev.off()

## Line plot showing the same
# png(filename = "plot2b.png", width = 480, height = 480)
# plot(baltimorePerYear, type = "l", col = "maroon3",
#      xlab = "Year", ylab = "Total Emissions",
#      main = "Total PM2.5 emissions for Baltimore City, Maryland (1999 - 2008)")
# dev.off()