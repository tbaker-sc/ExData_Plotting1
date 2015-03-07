plot3 <- function () {
	
	#First block of code confirms the file is present
	#If not, it pulls down the file from the URL & unzips
  #Function return immediately if file still isn't present after trying to load it from URL

	if (!file.exists("household_power_consumption.txt")) {
		fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(fileUrl, destfile = "exdata-data-household_power_consumption.zip", method = "curl")
		unzip("exdata-data-household_power_consumption.zip")
		if (!file.exists("household_power_consumption.txt")) {
			print("ERROR: Cannot open file")
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
	png("plot3.png")
	
	#Create the plot using the following options
	#type = "l"  -- Change the type of graph from the default (scatterplot) to a line graph
	#xlab = "<>"  -- changes the values of the label on the x-axis from the default	
	#ylab = "<>"  -- changes the values of the label on the y-axis from the default
	#col=<> -changes theline color from default (black) to the color specified
	with(sub, plot(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"), Sub_metering_1, 
		type = "l", ylab = "Energy sub metering", xlab = ""))
	
	#The next two steps use lines(), rather than plot(), so the data is added to the same plot created in step 1
	with(sub, lines(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"), Sub_metering_2, 
		type = "l", col="red"))	
	with(sub, lines(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"), Sub_metering_3, 
		type = "l", col="blue"))
	
	#Add a legend to explain the 3 lines in the plot
	legend("topright", col=c("black", "red", "blue"), lty = 1,
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	
	#Close graphics device
	dev.off()
}