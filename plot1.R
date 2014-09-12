## Coursera
## Exploratory Data Analysis
## Course Project 2 - plot1.R

## set working directory
setwd("~/Data Science/Assignments/ExplDataAnalysis")

## creating a data directory
if (!file.exists("data")) {
        dir.create("data")
}

## download a file and place in "data" directory
if (!file.exists("data/FNEI")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        zipfile="data/projdata.zip"
        download.file(fileUrl, destfile=zipfile)
        unzip(zipfile, exdir="data")
}

        ## read data
        data <- readRDS("./data/summarySCC_PM25.rds", refhook = NULL)
        SCC <- readRDS("./data/Source_Classification_Code.rds")

        dfdata <- data.frame(data)

        ## plot1 = Create Base plot showing total emissions from 1999 to 2008 
        ## from all sources
        plot1 <- hist(dfdata$year, main="Total Emissions by Year", xlab="Year", 
        ylab="Total Emissions (PM2.5)", col="red")

        ## Create png of plot1
        dev.copy(png, width = 480, height = 480, file = "plot1.png")
        dev.off()
## end plot1.R