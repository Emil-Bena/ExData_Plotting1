## Load Libraries
library(tidyverse)
library(lubridate)

## Read data from local folder
hpc <- read.table("./household_power_consumption.txt",
                  header=TRUE, sep=";", na.strings = "?",
                  colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Convert character to date
hpc$Date <- hpc$Date %>% as.Date("%d/%m/%Y")

## Filter date 
hpcanalysis <- hpc %>% filter(Date>="2007-2-1", Date<="2007-2-2") %>% drop_na()

## Create new column DateTime
hpcanalysis$DateTime <- paste(as.Date(hpcanalysis$Date), hpcanalysis$Time)
hpcanalysis$DateTime <- as.POSIXct(hpcanalysis$DateTime )


## plot1
hist(hpcanalysis$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
