library(dplyr)
library(lubridate)

hpc <- read.table("household_power_consumption.txt"
                  ,sep = ";"
                  ,header=T
                  ,na.strings = "?"
                )
hpcsub <- filter(hpc, hpc$Date %in% c("1/2/2007", "2/2/2007")) %>%
          mutate(newdatetime = paste(Date,Time )) %>%
          mutate(datetime = as.POSIXct(strptime(newdatetime, "%d/%m/%Y %H:%M")))  %>%
          select(-newdatetime)
        

png(filename = "plot3.png")
with(hpcsub, { 
        plot(datetime,Sub_metering_1,type="l",col="black",ylab = "Energy sub metering", xlab="")
        points(datetime,Sub_metering_2,type="l",col="red")
        points(datetime,Sub_metering_3,type="l",col="blue")
        legend("topright", lty=1,col= c("black","red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        
})
dev.off()
