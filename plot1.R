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
png(filename = "plot1.png",
    width = 480, height = 480, units = "px")

hist(pdata$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (Kilowatts)",col="red",ylim=lim)
dev.off()