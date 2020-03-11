library(data.table)
library(lubridate)

# Download the file if it does not exit
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption.zip"
filename <- "household_power_consumption.txt"
if (!file.exists(file)) {
  download.file(url, destfile = file, method = "curl")
  unzip(file)
  print("Data downloaded.")
} else {
  print("Data exist.")
}

# Read the file and filter the only useful data
originaldata <- fread(filename, na.strings = "?")
data <- originaldata[Date == "1/2/2007" | Date == "2/2/2007"]

#Convert the date and time to proper class
data$Time <- dmy_hms(paste(data$Date, data$Time))
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Open the device and output the file and close the device
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(data$Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(data$Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(data$Time, data$Sub_metering_2, type = "l", col = "red")
points(data$Time, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"), col = c("black", "red", "blue"), lty = 1, bty = "n")
plot(data$Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_ractive_power")
dev.off()
