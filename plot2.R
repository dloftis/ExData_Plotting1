plot2 <- function () {
  ## Create date class for conversion of dates in file
  setClass("consDate")
  setAs("character","consDate", function(from) as.Date(from, format="%m/%d/%Y") )
  
  ## Read data
  consuption_data <- read.table("household_power_consumption.txt", header = TRUE, 
                                sep = ";", na.strings = "?", 
                                colClasses = c('consDate','factor','character','character','character',
                                               'character','character','character','character'))
  
  feb_data <- subset(consuption_data, Date %in% c(as.Date('2007-02-01'), as.Date('2007-02-02')))
  
  feb_data$Global_active_power <- as.numeric(as.character(feb_data$Global_active_power))
  png(file = "plot2.png")
  with(feb_data, plot(Time, Global_active_power, xaxt="n", ylab="Global Active Power (kilowats)"))
  axis(1, at = c(0,700,1400), c("Thurs", "Fri", "Sat"))
  dev.off()
  
}