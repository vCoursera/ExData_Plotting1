# This function generates plot 4 of the Programming Assignment 1
plot4 <- function(){
# Check if the power consumption text file already exists in the root directory , if not proceed
if(!file.exists('household_power_consumption.txt')){
# Check if the power consumption zip file already exists in the root directory , if not download it from internet
if(!file.exists('household_power_consumption.zip')){
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./household_power_consumption.zip")
}
#unzip the contents of the downloaded zip file
unzip("household_power_consumption.zip")
}

# query to fetch the records for two dates as mentioned in the problem statement
mySql <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"

#The place holder for the file name in the root directory
myfile <- "household_power_consumption.txt"

#load library sqldf to generate the subset
library(sqldf)

#read the data selectively
myData <- read.csv.sql(myfile,mySql,sep=";")

# format the Date column so it is read as type Date and not char
d <- as.Date(myData$Date,'%d/%m/%Y')

myData$Date <- d

# open PNG Device
png(file = "plot4.png", bg = "white",width = 480, height = 480)
# create a par object to show multiple plots on the same device
par(mfrow=c(2,2))
plot(strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Global_active_power,type="l" ,ylab="Global Active Power (kilowatts)", xlab = "")
plot(strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Voltage,type="l" ,ylab="Voltage", xlab = "datetime")
plot( strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Sub_metering_1, type="l", col="black" ,ylab="Energy sub metering", xlab = "")
lines(strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Sub_metering_2 , col="red")
lines(strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Sub_metering_3, col="blue")
# Add the legend for all plots added
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3") , lty=1, col=c('black', 'red', 'blue'), bty='y', cex=.75)
plot(strptime(paste(myData$Date,myData$Time),"%Y-%m-%d %H:%M:%S"),myData$Global_reactive_power,type="l" ,ylab="Global_reactive_power", xlab = "datetime")
#switch off the device
dev.off()
#The file will be copied to the root directory

}