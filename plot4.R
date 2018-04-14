#libraries and settings

library(dplyr)
Sys.setlocale("LC_TIME", "C")

#memory usage

MBmemory <- (9*2075260*8)/2^20

#data loading and exploring

HPC <- read.table('household_power_consumption.txt', sep = ';', header = T)
#str(HPC)
#tbl_df(HPC)

#subsetting and cleaning data

HPC2 <- HPC
HPC2 <- HPC2[HPC2$Date %in% c('1/2/2007', '2/2/2007'),]
HPC2[,1:2] <- apply(HPC2[,1:2], 2, as.character)
HPC2[,1] <- with(HPC2, paste(Date, Time, sep = ' '))
HPC2[,2] <- NULL
HPC2[,1] <- as.POSIXct(strptime(HPC2$Date, format = '%d/%m/%Y %H:%M:%S'))
HPC2[,2:8] <- apply(HPC2[,2:8], 2, as.numeric, as.character)

#str(HPC2)
#tbl_df(HPC2)

#plot4

png(filename = 'plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
plot(HPC2$Date, HPC2$Global_active_power, type = 'l', xlab = (''),
     ylab = 'Global Active Power (kilowatts)')
plot(HPC2$Date, HPC2$Voltage, type = 'l', xlab = ('datetime'),
     ylab = 'Voltage')
plot(HPC2$Date, HPC2$Sub_metering_1, type = 'l', xlab = (''),
     ylab = 'Energy sub metering')
lines(HPC2$Date, HPC2$Sub_metering_2, type = 'l', col = 'red')
lines(HPC2$Date, HPC2$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = 1, cex = 0.8)
plot(HPC2$Date, HPC2$Global_reactive_power, type = 'l', xlab = ('datetime'),
     ylab = 'Global_reactive_power')
dev.off()
