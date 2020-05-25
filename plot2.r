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

png(filename = "plot2.png")
plot(hpcsub$datetime,hpcsub$Global_active_power,type="l",ylab = "Global Active Power(kilowatts)",xlab="")
dev.off()

