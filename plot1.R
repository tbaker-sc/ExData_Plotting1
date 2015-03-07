plot1 <- function () {
	
	#First block of code confirms the file is present
	#If not, it pulls down the file from the URL & unzips
	#Function return immediately if file still isn't present after trying to load it from URL

	if (!file.exists("household_power_consumption.txt")) {
		fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip", method = "curl")
		unzip("exdata-data-household_power_consumption.zip")
		if (!file.exists("household_power_consumption.txt")) {
			print("ERROR: Cannot open file. Please check for an internet connection & that a zip utility is installed.")
			return()
		} 
	}
	#Read in data file
	#Include values for seperator (;) and  na (?)   from original dataset
	#Have it not convert the dates & times to factor. (as.is = TRUE)
	full_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?", as.is=TRUE)
	
	#Subset the full_data data frame so we're only dealng with the 2 dates needed for this project
	sub_data <- full_data[(full_data$Date == "2/2/2007" | full_data$Date == "1/2/2007"),]
	
	#Open the png graphics device that we'll be writing to
	png("plot1.png")
	
	#Create histogram for plot 1, using the following options
	#col=red -- fills the bars with red
	#main = "<>" -- changes the title of the graph from the default
	#xlab = "<>"  -- changes the values of the label on the x-axis from the default
	hist(sub$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
	
	#Close graphics device
	dev.off()
}