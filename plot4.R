plot4 <- function(){
        # List of packages for session
        .packages = c("dplyr")
        
        # Install CRAN packages (if not already installed)
        .inst <- .packages %in% installed.packages()
        if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
        
        # Load packages into session 
        lapply(.packages, require, character.only=TRUE)
        
        # setwd 
        setwd("~/Documents/jonathan/learning/r/Exploratory Data Analysis/project01")
        
        # Loading Individual household electric power consumption Data Set
        df <- read.csv("household_power_consumption.txt"
                       , sep=";"
                       , header = TRUE
                       , stringsAsFactors = FALSE
                       , na.strings = '?'
                       , colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric",
                                      "numeric", "numeric", "numeric")
        )
        # Filter dates
        df <- df %>% 
                filter(Date %in% c("1/2/2007", "2/2/2007"))
        
        #Formatting dates
        df$timestamp <- strptime(paste(df$Date, df$Time), format = "%d/%m/%Y %H:%M:%S")
        
        # Reseting graphical parameters
        dev.off()
        
        #Creating the graph
        par(mfrow=c(2,2))
        
        #plot 1
        with(df, plot(timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
        
        #plot 2
        with(df, plot(timestamp, Voltage, type="l", xlab="", ylab="Voltage"))
        
        #plot 3
        with(df, plot(timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
        lines(df$timestamp,df$Sub_metering_2,col="red")
        lines(df$timestamp,df$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty = c(1,1), cex = .5, bty = "n")
        
        #plot 4
        with(df, plot(timestamp, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
        
        #saving to png
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        
        cat("Plot4.png was generated and saved in ", getwd())
        
        #return(df)
}