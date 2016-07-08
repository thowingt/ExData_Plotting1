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


# find max y-value of sub_metering_1
max_y=max(inf2$sub_metering_1)

# plot the line without the x-axis
plot(inf2$sub_metering_1, type="l", ylab="Energy sub metering", xlab=NA,  
     xaxp=c(1, 2889, 2), col="black", xaxt="n")
par(new=TRUE)
plot(inf2$sub_metering_2, type="l", ylab="", xlab="", col="red", ylim=c(0,max_y), xaxt="n")
par(new=TRUE)
plot(inf2$sub_metering_3, type="l", ylab="", xlab="", col="blue", ylim=c(0,max_y), xaxt="n")

# add the x-axis
axis(side=1, at=c(1, number_of_thursdays+1, total_records), labels=c("Thu","Fri","Sat"))

# determine width of text in legend
leg_text_width=strwidth("sub_metering_3)")*1.1

# add legend
legend("topright", col=c("black","red","blue"), lty=1, 
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), text.width=leg_text_width)

# send result to png device
dev.copy(png, "plot3.png")
dev.off()
