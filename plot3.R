#plot3.R creates plot3.png
#image has a width of 480pixels and a height of 480 pixels.
### Plot 3
#image matches with the assignment provided file: ./figure/unnamed-chunk-4.png 
#image description: Engergy Sub Metering by Day (H, F, S) 
# sub groups: 
# Black-Sub Metering 1; kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered)
# Red-Sub Metering 2; laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light
# Blue-Sub Metering 3 / electric water-heater and an air-conditioner
#note: I have purposefully left extra commented out code to go back and experiment/learn further

#test code: 
# source("plot3.R")
#test code provided for all 4 plotx.R scripts all the bottom of plot1.R
#end test code



#main data files:
#hpc: unfiltered household_power_consumption
#hpc_filtered: filter household_power consumption 02/01/2007-02/02/2007

#set working path specific to my work environment
#wdpath <- "C://Users//akeller//Documents//GitHub//ExData_Plotting1"
#wdpath <- "C://Users//akeller.HARDEN//Documents//GitHub//ExData_Plotting1"
#setwd(wdpath)
#getwd()

# note: Steps 0 through 3 below are identical for each of the plotx.R scripts (1-4)

#0) Preliminary - calculate estimated memory needs. done
# #1) Download Data from internet
# the following lines are commented out for testing. they work and can be completed manually
# url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# destfile <- "./data/household_power_consumption.zip"
# download.file(url, destfile)

#note/manual step: need to manually unzip the .txt file from ./data/houshold_power_consumption.zip file 
#this step is manual and is not required to be automated for the assigned but should go back to make more reproducible
# relative to working directorty need ./data/household_power_consumption.txt

#2) Load Data - subset only dates between 2007-02-01 and 2007-02-02. 
#while loading in, change '?' values to 'NA' to address missing values
#hpc: unfiltered household_power_consumption
#inputfilename <- "~/GitHub/ExData_Plotting1/data/household_power_consumption.txt"
inputfilename <- "./data/household_power_consumption.txt"

# read file into a data frame called hpc
hpc <- read.table(inputfilename
                  ,header=TRUE
                  , sep=";"
                  , na.strings = "?"
                  , nrows = 2075259 #not necessary to be exact
                  #, stringsAsFactors = default.stringsAsFactors()
                  #, stringsAsFactors = default.stringsAsFactors()
                  #, stringsAsFactors = FALSE
                  #, row.names = NULL  #force numbers
                )

#View(hpc) #nObs = 2,075,259 record count verified
# summary(hpc)
# str(hpc$time)

#3) Data Transforms
#- convert date and time variables to Date/Time class with strptime() and as.Date()
#colnames(hpc)
# [1] "Date"                  "Time"                  "Global_active_power"  
# [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
# [7] "sub_metering_1"        "sub_metering_2"        "sub_metering_3"  

#change all column names to lower case / best practice 
colnames(hpc) <- tolower(colnames(hpc))

#filter data for selection time period 2007-02-01 and 2007-02-02
hpc_filtered <- hpc[as.character(hpc$date) %in% c('2/2/2007','1/2/2007'),]

rm(hpc) #remove unfiltered hpc data.frame as it is no longer needed.

#convert date and time variables
# class(hpc$date) #"factor"
# class(hpc$time) #"factor"
#use strptime()` and as.Date()
#hpc_filtered$date <- as.Date(hpc_filtered$date, format = "%d/%m/%Y")  #note: Day/Month/Year format

# class(hpc$time) #"factor"
# hpc$time <- as.Date(hpc$time, format = "%H:%M:%S")
# hpc_filtered$time <- strptime(hpc_filtered$time, format = "%H:%M:%S",  tz = "EST5EDT")
hpc_filtered$datetime <- strptime(
  paste(hpc_filtered$date,hpc_filtered$time)
  ,format="%d/%m/%Y %H:%M:%S")

#summary(hpc$date)
#class(hpc$date)
#class(hpc$time)  #POSIXlt  POSIXt
#colnames(hpc_filtered)

#4) Create chart
png(filename="plot3.png"
    ,width=480
    ,height=480
    ,units="px"
    ,bg=NA)

## submeter #1
plot(x=hpc_filtered$datetime
     ,y=hpc_filtered$sub_metering_1
     ,type="l"
     ,col="black"
     ,xlab=""
     ,ylab="Energy sub metering"
)

## submeter #2
lines(x=hpc_filtered$datetime
      ,y=hpc_filtered$sub_metering_2
      ,type="l"
      ,col="red")

## submeter #3
lines(x=hpc_filtered$datetime
      ,y=hpc_filtered$sub_metering_3
      ,type="l"
      ,col="blue")

legend("topright",legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
       ,lwd=1
       ,col=c("black","red","blue"))
dev.off()

#dev.list()

