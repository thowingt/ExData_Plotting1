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

# find the location of tick marks on the x-axis
number_of_thursdays<-nrow(inf2[which(inf2$date=="1/2/2007"),])
total_records=nrow(inf2)

# plot the line without the x-axis
plot(inf2$global_active_power, type="l", ylab="Global Active power (kilowatts)", xlab=NA,  
     xaxp=c(1, 2889, 2), xaxt="n")

# add the x-axis
axis(side=1, at=c(1, number_of_thursdays+1, total_records), labels=c("Thu","Fri","Sat"))

# send result to png device
dev.copy(png, "plot2.png")
dev.off()