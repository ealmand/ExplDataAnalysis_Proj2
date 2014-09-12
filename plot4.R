## Coursera
## Exploratory Data Analysis
## Course Project 2 - plot4.R

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

## Question 4 plot
        ## Extract "Coal" from SCC
        coal1 <- SCC[grepl("Coal",SCC$EI.Sector),]
        coal2 <- SCC[grepl("Coal",SCC$SCC.Level.Three),]

        ## combine and resolve unique rows
        coaltot <- rbind(coal1,coal2)
        scc <- coaltot$SCC
        coal <- unique(scc)

        ## Extract unique rows from dfdata
        P4 <- dfdata[dfdata$SCC %in% coal, ]
        unique(P4$year)
        p4data <- aggregate(Emissions~year,data=P4,FUN=sum)

        ## plot using ggplot
        ggplot(p4data, aes(x = year, y = Emissions)) +
        geom_point(alpha=1, size=4) +
        geom_line(stat="identity") +
        ggtitle("Total PM2.5 Coal Combustion Emissions in the US")

## Create plot4.png
dev.copy(png, file = "plot4.png")
dev.off()
## end plot4.R