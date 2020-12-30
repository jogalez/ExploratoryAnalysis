plot2 <- function(){
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
        with(df, plot(timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
        
        #saving to png
        dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
        
        cat("Plot2.png was generated and saved in ", getwd())
        
        #return(df)
}