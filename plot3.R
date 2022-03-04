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


## plot3
with(hpcanalysis,
     {plot(Sub_metering_1~DateTime, type="l",
           ylab="Global Active Power (kilowatts)", xlab="")
       lines(Sub_metering_2~DateTime,col='Red')
       lines(Sub_metering_3~DateTime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()