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


## plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,1,0))
with(hpcanalysis, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
