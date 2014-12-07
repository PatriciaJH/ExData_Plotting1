## plot2.R  outputs file plot2.png showing Global Active Power usage over the time period
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

png("plot2.png", width = 480, height = 480,
    units = "px", pointsize = 12,
    bg = "white", res=NA)               # png can be iffy with a transparent background

plot(hpc_df$datetime, hpc_df$Global_active_power, # nice datetime column gives nice weekday labels
     xlab="", ylab="Global Active Power (kilowats)", type="l") 

dev.off()

