library(sqldf)
gdata <- function(){
    # Source file
    f <- "household_power_consumption.txt"
    
    # To get required Data
    sel <- "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
    
    #read data required into variable
    hdata <- read.csv.sql(f, sql=sel, sep=";")
    
    #Convert date and time columns
    hdata$DateTime <- as.POSIXct(strptime(paste(hdata$Date,hdata$Time), "%d/%m/%Y %H:%M:%S"))
    
    return(hdata)
}

pdata <- gdata()

#open png graphics device
png(filename = "plot3.png",
    width = 480, height = 480, units = "px")

plot(x=pdata$DateTime,y=pdata$Sub_metering_1,type="l",
     xlab="",ylab="Energy Sub Meetering")
lines(x=pdata$DateTime,y=pdata$Sub_metering_2, type="l",col="red")
lines(x=pdata$DateTime,y=pdata$Sub_metering_3, type="l",col="blue")
legendTxt <-c("Sub Meetering 1","Sub Meetering 2", "Sub Meetering 3")
legend("topright",c("Sub Metering 1","Sub Metering 2", "Sub Metering 3"),lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","blue","red"))


dev.off()