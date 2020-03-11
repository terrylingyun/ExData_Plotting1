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
png("plot2.png", width=480, height=480)
plot(data$Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
