#plot1.R creates plot1.png
#PNG file with a width of 480pixels and a height of 480 pixels.
#to match to the assignment provided file: ./figure/unnamed-chunk-2.png 

#wdpath <- "C://Users//akeller//Documents//GitHub//ExData_Plotting1"
wdpath <- "C://Users//akeller.HARDEN//Documents//GitHub//ExData_Plotting1"
setwd(wdpath)
#getwd()

#image description: Histogram of Frequency by Global Active Power (k) in groups of .5.
#Red color bands

### Plot 1
#![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2.png) 

# note: Steps 0 through 3 below will be identical for each of the plotx.R scripts (1-4)

#0) Preliminary - calculate estimated memory needs

#1) Download Data  

#2) Load Data - subset only dates between 2007-02-01 and 2007-02-02. 
#while loading in, change '?' values to 'NA' to address missing values
#hpc: household_power_consumption
#inputfilename <- "~/GitHub/ExData_Plotting1/data/household_power_consumption.txt"
inputfilename <- "./data/household_power_consumption.txt"

# read file into a data frame called hpc
# rm(hpc)
hpc <- read.table(inputfilename
                ,header=TRUE
                , sep=";"
                , na.strings = "?"
                , nrows = 2075259
                #, stringsAsFactors = default.stringsAsFactors()
                , stringsAsFactors = FALSE
                , row.names = NULL  #force numbers
                )

#View(hpc) #nObs = 2,075,259 record count verified
summary(hpc)
str(hpc$time)

#3) Data Transforms
#- convert date and time variables to Date/Time class with strptime() and as.Date()
#colnames(hpc)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"  

#change all column names to lower case
colnames(hpc) <- tolower(colnames(hpc))

#filter data for selection time period 2007-02-01 and 2007-02-02
hpc_filtered <- hpc[as.character(hpc$date) %in% c('2/2/2007','1/2/2007'),]

#convert date and time variables
# class(hpc$date) #"factor"
# class(hpc$time) #"factor"
#use strptime()` and as.Date()
hpc_filtered$date <- as.Date(hpc_filtered$date, format = "%d/%m/%Y")  #note: Day/Month/Year format

# class(hpc$time) #"factor"
# hpc$time <- as.Date(hpc$time, format = "%H:%M:%S")
hpc_filtered$time <- strptime(hpc_filtered$time, format = "%H:%M:%S",  tz = "EST5EDT")
hpc_filtered$datetime <- strptime(
    paste(hpc_filtered$date,hpc_filtered$time)
    ,format="%d/%m/%Y %H:%M:%S")
                                  
#summary(hpc$date)
#class(hpc$date)
#class(hpc$time)  #POSIXlt  POSIXt

#4) Create chart
png(filename="plot1.png"
      ,width=480
      ,height=480
      ,units="px"
      ,bg=NA)
hist(x=hpc_filtered$global_active_power
           ,col="red"
           ,main="Global Active Power"
           ,xlab="Global Active Power (kilowats)")
dev.off()


