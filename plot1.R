## plot1.R  outputs file plot1.png showing Global Active Power histogram over time period
##
## Read in household energy use data for 2007-02-01 and 2007-02-02
## (having found the correct start and end lines in the file using the Unix command grep)
##
hpc_df <- read.table("household_power_consumption.txt", 
                     col.names=c("Date", "Time",
                         "Global_active_power", "Global_reactive_power",
                         "Voltage", "Global_intensity",
                         "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                     na.strings="?",
                     sep = ";",
                     skip=66637,  ## Start reading at line 66638
                     nrows = 2880 ## ending at line  69517
                     )

png("plot1.png", width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white", res=NA)

hist(hpc_df$Global_active_power, col = "red",
     main= "Global Active Power", xlab="Global Active Power (kilowatts)") 
dev.off()
