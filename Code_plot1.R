## Read the txt file and transform it into a data frame
data<-readLines("household_power_consumption.txt")
data2<-strsplit(data,";")

## Name the columns correctly
data2<-do.call(rbind.data.frame,data2)
colnames(data2)<-data2[1,]
data2<-data2[-1,]

## Convert the Date variable to Date classe in R 
data2$Date<-as.Date(data2$Date,"%e/%m/%Y")

## Extract only the subsets from the dates 2007-02-01 and 2007-02-02
data3<-data2[data2$Date=="2007-2-2",]
data4<-data2[data2$Date=="2007-2-1",]
finaldata<-rbind(data4,data3)

## Create a new columns with Date + Time with the correct format
finaldata$DateTime<-paste(finaldata$Date,finaldata$Time)
library(lubridate)
finaldata$DateTime<-ymd_hms(finaldata$DateTime)

#Creating the first plot
finaldata$Global_active_power<-as.numeric(finaldata$Global_active_power)
hist(finaldata$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power", col="red",ylim=c(0,1200))
dev.copy(png,"plot1.png",width=480,height=480)
dev.off()
