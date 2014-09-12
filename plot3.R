## Coursera
## Exploratory Data Analysis
## Course Project 2 - plot3.R

## set working directory
setwd("~/Data Science/Assignments/ExplDataAnalysis")

## This code requires the following package:
install.packages("RDS")
library(RDS)

## creating a data directory
if (!file.exists("data")) {
        dir.create("data")
}

## download a file and place in "data" directory
if (!file.exists("data")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        zipfile="data/projdata.zip"
        download.file(fileUrl, destfile=zipfile)
        unzip(zipfile, exdir="data")
}

        ## read data
        data <- readRDS("./data/summarySCC_PM25.rds", refhook = NULL)
        SCC <- readRDS("./data/Source_Classification_Code.rds")

        dfdata <- data.frame(data)

        ## Subset data by Baltimore City (fips == "24510")
        Balt <- data.frame(subset(dfdata, fips == "24510"))

        ## plot3 = ggplot2 plotting system to make a plot answer question 3.
        ## subset the data by types
        Bpt <- data.frame(subset(Balt, type == "POINT"))
        Bnonpt <- data.frame(subset(Balt, type == "NONPOINT"))
        Bonrd <- data.frame(subset(Balt, type == "ON-ROAD"))
        Bnonrd <- data.frame(subset(Balt, type == "NON-ROAD"))

        ## create four plots using qplots for each type
        Bptplot <- qplot(year, Emissions, data=Bpt, xlab="Year", 
                ylab="Emissions (PM2.5)", main="Year vs Emissions by point",
                geom=c("point", "smooth"), method="lm")
        Bnonptplot <- qplot(year, Emissions, data=Bnonpt, xlab="Year", 
                ylab="Emissions (PM2.5)", main="Year vs Emissions by non-point",
                geom=c("point", "smooth"), method="lm")
        Bonrdplot <- qplot(year, Emissions, data=Bonrd, xlab="Year", 
                ylab="Emissions (PM2.5)", main="Year vs Emissions by on-road",
                geom=c("point", "smooth"), method="lm")
        Bnonrdplot <- qplot(year, Emissions, data=Bnonrd, xlab="Year", 
                ylab="Emissions (PM2.5)", main="Year vs Emissions by non-road",
                geom=c("point", "smooth"), method="lm")

        ## arrange four plots (2x2)
        grid.arrange(main="Baltimore", Bptplot, Bnonptplot, Bonrdplot, Bnonrdplot, ncol=2)

        ## Create png of plot3
        dev.copy(png, width = 480, height = 480, file = "plot3.png")
        dev.off()
##end plot3.R