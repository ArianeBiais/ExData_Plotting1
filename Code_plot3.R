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

#Creating the third plot
data2$Sub_metering_1<-as.numeric(data2$Sub_metering_1)
data2$Sub_metering_2<-as.numeric(data2$Sub_metering_2)
data2$Sub_metering_3<-as.numeric(data2$Sub_metering_3)
with(finaldata,plot(DateTime,Sub_metering_1,xlab="",ylab="Energy sub metering",type='l'))
points(finaldata$DateTime,finaldata$Sub_metering_3,col="blue",type="l")
points(finaldata$DateTime,finaldata$Sub_metering_2,col="red",type="l")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2,cex=0.5)
dev.copy(png,"plot3.png",width=480,height=480)
dev.off()
