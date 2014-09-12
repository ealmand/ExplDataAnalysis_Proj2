## Coursera
## Exploratory Data Analysis
## Course Project 2 - plot5.R

## This code requires the following package:
install.packages("ggplot2")
library(ggplot2)

## set working directory
setwd("~/Data Science/Assignments/ExplDataAnalysis")

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

##Question 5
        ## extract vehicles from SCC
        v1 <- SCC[grepl("Vehicles",SCC$EI.Sector),]
        v2 <- SCC[grepl("Vehicles",SCC$SCC.Level.Two),]
        v3 <- SCC[grepl("Vehicles",SCC$SCC.Level.Three),]
        v4 <- SCC[grepl("Vehicles",SCC$Short.Name),]

        ## Combine all vehicle emission sources, extract unique sources
        vtot <- rbind(v1, v2, v3, v4)
        scc <- vtot$SCC
        sccextract <- unique(scc)

        ## Reduce the subset vehicle emission from Baltimore data
        p5 <- Balt[Balt$SCC %in% sccextract, ]
        unique(p5$year)

        ## Aggregate data by year, calculate sum emissions
        plot5 <- aggregate(Emissions~year,data=p5,FUN=sum)

        ## Create ggplot
        ggplot(plot5, aes(x = year, y = Emissions)) +
                geom_point(alpha=1, size=4) +
                geom_smooth(alpha=.5, size=1) +
                ggtitle("Total PM2.5 Motor Vehicles Emissions in Baltimore")
        
        ## Create plot5.png
        dev.copy(png, file = "plot5.png")
        dev.off()

## end plot5.R