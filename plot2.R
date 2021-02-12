library(dplyr)
library(chron)

# read in the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# correct the date and times column to be in correct format and obtain only the dates I need (2007-02-01 and 2007-02-02)
df <- data %>% mutate(Date = as.Date(Date,format="%d/%m/%Y"),Time=times(Time)) %>%
  filter(Date=="2007-02-01"|Date=="2007-02-02") %>% 
  mutate(Time_numeric = c(as.numeric(Time[1:1440]),as.numeric(Time[1441:2880]) +  0.9993056))

# create the plot
with(df,plot(Time_numeric,Global_active_power,type="l", xaxt = "n", ylab="Global Active Power (kilowatts)",xlab=""))
axis(1, at=c(0,1,2), labels=c("Thu","Fri","Sat"))

# copy plot to a png file
dev.copy(png,"plot2.png",width=480,height=480)
dev.off()