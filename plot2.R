## 
## Exploratory Data Analysis
## Course Project 1

# This code will produce an output file "plot2.png"



# Read in the file
# Notes:
# 1. Assumes the text file "household_power_consumption.txt" is in the same directory
#    as where this file is run (via "source ("plot1.R"))
# 2. To save time, reads in only the data from the dates 2007-02-01 and 2007-02-02.
#    (This is per a suggestion in the problem Instructions)
#    Achieved by skipping the first 66,637 rows, and reading in only the next 2,880 rows
# 3. colClasses & col.names specificed explictly - keeps it simple.

hpc_data <- read.table("./household_power_consumption.txt",
                       header = FALSE,
                       sep = ";",
                       colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
                       skip = 66637,
                       nrows = 2880,
                       col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
)

# Construct a new column which combines Date & Time information
hpc_data$DateTime <- as.POSIXct(strptime(paste(hpc_data$Date, hpc_data$Time), "%d/%m/%Y %H:%M:%S"))

# Specify a png file as the graphics device for this plot
png(filename = "./plot2.png", width = 480, height = 480, units ="px")

# Perform the plot
plot(hpc_data$DateTime, hpc_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# Shutdown the device (finalise saving the file)
dev.off()
