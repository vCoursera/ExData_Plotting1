# This function generates the plot 1 of the Programming Assignment 1
plot1 <- function(){
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
png(file = "plot1.png", bg = "white",width = 480, height = 480)
# plot the graph
hist(myData$Global_active_power,col = "red",main = "Global Active Power",xlab="Global Active Power (kilowatts)")
#switch off the device
dev.off()
#The file will be copied to the root directory

}