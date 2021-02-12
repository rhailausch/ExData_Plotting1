library(dplyr)
library(chron)

# read in the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# correct the date and times column to be in correct format and obtain only the dates I need (2007-02-01 and 2007-02-02)
df <- data %>% mutate(Date = as.Date(Date,format="%d/%m/%Y"),Time=times(Time)) %>%
  filter(Date=="2007-02-01"|Date=="2007-02-02") %>% 
  mutate(Time_numeric = c(as.numeric(Time[1:1440]),as.numeric(Time[1441:2880]) +  0.9993056))

# create space for 4 plots
par(mfcol=c(2,2))

#add plot 1
with(df,plot(Time_numeric,Global_active_power,type="l",xaxt = "n",xlab="",ylab="Global Active Power"))
axis(1, at=c(0,1,2), labels=c("Thu","Fri","Sat"))

#add plot 2
with(df,plot(Time_numeric,Sub_metering_1,type="l",xaxt = "n", ylab="Energy sub metering",xlab=""))
axis(1, at=c(0,1,2), labels=c("Thu","Fri","Sat"))
lines(df$Time_numeric,df$Sub_metering_2,col="red")
lines(df$Time_numeric,df$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1,col = c("black","red","blue"))

#add plot 3
with(df,plot(Time_numeric,Voltage,type="l",xlab="datetime",xaxt = "n"))
axis(1, at=c(0,1,2), labels=c("Thu","Fri","Sat"))

#add plot 4
with(df,plot(Time_numeric,Global_reactive_power,type="l",xlab="datetime",xaxt = "n"))
axis(1, at=c(0,1,2), labels=c("Thu","Fri","Sat"))

# copy histogram to png file
dev.copy(png,"plot4.png",width=480,height=480)
dev.off()