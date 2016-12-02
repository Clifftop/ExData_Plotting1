## 
## Exploratory Data Analysis
## Course Project 1

# This code will produce an output file "plot4.png"



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
png(filename = "./plot4.png", width = 480, height = 480, units ="px")

## Create a 2 x 2 layout - 4 plots to be created.
par(mfcol = c(2,2))  # fill columns first

# Plot position - top left
plot(hpc_data$DateTime, hpc_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Plot position - bottom left
plot(hpc_data$DateTime, hpc_data$Sub_metering_1, type = 'l', ylab = "Energy sub metering", xlab = "")
points(hpc_data$DateTime, hpc_data$Sub_metering_2, type = 'l', col = 'red')
points(hpc_data$DateTime, hpc_data$Sub_metering_3, type = 'l', col = 'blue')
legend("topright", bty = "n", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot position - top right
plot(hpc_data$DateTime, hpc_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Plot position - bottom right
plot(hpc_data$DateTime, hpc_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Shutdown the device (finalise saving the file)
dev.off()
