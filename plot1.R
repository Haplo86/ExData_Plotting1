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

#plot1

png(filename = 'plot1.png', width = 480, height = 480)
hist(HPC2$Global_active_power, col = 'red', main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency')
dev.off()
