plot4 <- function () {
  ## Create date class for conversion of dates in file
  setClass("consDate")
  setAs("character","consDate", function(from) as.Date(from, format="%m/%d/%Y") )
  
  ## Read data
  consuption_data <- read.table("household_power_consumption.txt", header = TRUE, 
                                sep = ";", na.strings = "?", 
                                colClasses = c('consDate','factor','character','character','character',
                                               'character','character','character','character'))
  
  feb_data <- subset(consuption_data, Date %in% c(as.Date('2007-02-01'), as.Date('2007-02-02')))
  
  ##feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))
  ##feb_data$Voltage <- as.numeric(as.character(feb_data$Voltage))
  ##feb_data$Sub_metering_1 <- as.numeric(as.character(feb_data$Sub_metering_1))
  ##feb_data$Sub_metering_2 <- as.numeric(as.character(feb_data$Sub_metering_2))
  ##feb_data$Sub_metering_3 <- as.numeric(as.character(feb_data$Sub_metering_3))
  
  png(file = "plot4.png")
  par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
  with(feb_data, {
    # Plot topright
    with(feb_data, plot(Time, Global_active_power, type = "l", xaxt="n", xlab="datetime", ylab="Global Active Power (kilowats)"))
    axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
    
    #Plot topleft
    with(feb_data, plot(Time, Voltage, type = "l", xaxt="n", ylab="Voltage", xlab="datetime"))
    axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
    
    #Plot bottom right
    with(feb_data, plot(Time, Sub_metering_1, type="l", col="black", xaxt="n", xlab="datetime", ylab="Energy Sub Metering"))
    axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
    points(feb_data$Sub_metering_2, type="l", col="red")
    points(feb_data$Sub_metering_3, type="l", col="blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1), lwd = c(2,2,2))
    
    #Plot bottom left
    with(feb_data, plot(Time, Global_reactive_power, type = "l", xaxt="n", xlab="datetime", ylab="Global_reactive_power"))
    axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
  })
  dev.off()
}