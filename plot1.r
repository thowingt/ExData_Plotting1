infile="C:/Users/thowingt/My Documents/Code/Coursera_EDA/consumption//household_power_consumption.txt"

# read in the relevant lines of the file
inf<-read.table(infile, 
                sep=";", 
                skip=grep("1/2/2007",readLines(infile)),
                nrows=3000, 
                col.names=c("date","time","global_active_power",
                            "global_reactive_power","voltage",
                            "global_intensity","sub_metering_1",
                            "sub_metering_2","sub_metering_3"))

# exclude the remaining dates that are not relevant
inf2<-subset(inf, date %in% c("1/2/2007","2/2/2007"))

# plot the histogram
hist(inf2$global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="red")

# send plot to png device
dev.copy(png, "plot1.png")
dev.off()


