## plot4.R  outputs file plot4.png showing a comparative grid of power use plots
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

# load a much better date/time library than strptime() and as.Date() functions.
library(lubridate)    

# use to create handy new datetime column
hpc_df$datetime<- dmy_hms(paste(hpc_df$Date,hpc_df$Time))

hpc_df$Date <- NULL  # drop unused columns, be tidy.
hpc_df$Time <- NULL

png("plot4.png", width = 480, height = 480,
    units = "px", pointsize = 12,
    bg = "white", res=NA)               # png can be iffy with a transparent background

par(mfrow = c(2, 2))
with(hpc_df, {
    plot(datetime, Global_active_power, xlab="", ylab="Global Active Power", type="l") #CORRECT, COMPLETE
    plot(datetime, Voltage, xlab="datetime", type="l") #CORRECT, COMPLETE
    with(hpc_df, {
        plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type = "n", bg="white")
        points(datetime, Sub_metering_2, col="red", type="l")
        points(datetime, Sub_metering_1, col="black", type="l")
        points(datetime, Sub_metering_3, col="blue", type="l")
        legend("topright", bty="n", lty =1, pch=NA, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    })
    plot(datetime, Global_reactive_power, xlab="datetime", type="l")
})

dev.off()

