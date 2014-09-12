## Coursera
## Exploratory Data Analysis
## Course Project 2 - plot6.R

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
        ## and Los Angeles County (fips == "06037")
        LA <- data.frame(subset(dfdata, fips == "06037"))


        ##Question 6
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
        Bp6 <- Balt[Balt$SCC %in% sccextract, ]
        LAp6 <- LA[LA$SCC %in% sccextract, ]

        ## Aggregate data by year, calculate sum emissions
        Baltplot6 <- aggregate(Emissions~year + fips, data=Bp6, FUN=sum)
        LAplot6 <- aggregate(Emissions~year + fips, data=LAp6, FUN=sum)
        BLAplot6 <- rbind(Baltplot6, LAplot6)

        ## Create qplot
        qplot(year, Emissions, data = BLAplot6, color = fips, 
                main="Total PM2.5 Motor Vehicles Emissions in Baltimore and Los Angeles")

        ## Create plot6.png
        dev.copy(png, file = "plot6.png")
        dev.off()

## end plot6.R