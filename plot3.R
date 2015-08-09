plot3 <- function () {
  ## Create date class for conversion of dates in file
  setClass("consDate")
  setAs("character","consDate", function(from) as.Date(from, format="%m/%d/%Y") )
  
  ## Read data
  consuption_data <- read.table("household_power_consumption.txt", header = TRUE, 
                                sep = ";", na.strings = "?", 
                                colClasses = c('consDate','factor','character','character','character',
                                               'character','character','character','character'))
  
  feb_data <- subset(consuption_data, Date %in% c(as.Date('2007-02-01'), as.Date('2007-02-02')))
  
  png(file = "plot3.png")
  with(feb_data, plot(Time, Sub_metering_1, type="l", col="black", xaxt="n", ylab="Energy Sub Metering"))
  axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
  points(feb_data$Sub_metering_2, type="l", col="red")
  points(feb_data$Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1), lwd = c(2,2,2))

  dev.off()
  
}