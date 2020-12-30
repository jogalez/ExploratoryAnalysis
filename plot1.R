plot1 <- function(){
        # List of packages for session
        .packages = c("sqldf", "dplyr")
        
        # Install CRAN packages (if not already installed)
        .inst <- .packages %in% installed.packages()
        if(length(.packages[!.inst]) > 0) install.packages(.packages[!.inst])
        
        # Load packages into session 
        lapply(.packages, require, character.only=TRUE)
        
        # setwd 
        setwd("~/Documents/jonathan/learning/r/Exploratory Data Analysis/project01")
        
        # Loading Individual household electric power consumption Data Set
        ## Didnt work. Couldnt cast the date column to date type
                #ff <- base::file("household_power_consumption.txt")  # Create an explicit connection.
                #df <- sqldf::read.csv.sql(sql="SELECT *, strftime('%s',Date) newDate FROM ff WHERE Date >= '1/2/2007' ", sep=";", header = TRUE) 
                #base::close(ff)
        
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
        
        # Reseting graphical parameters
        dev.off()
        
        #Creating the graph
        hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = 'red')
        
        #saving to png
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        
        cat("Plot1.png was generated and saved in ", getwd())
        
        #return(df)
}