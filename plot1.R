library(dplyr)

# read in the data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")

# correct the date column to be in date format and obtain only the dates I need (2007-02-01 and 2007-02-02)
df <- data %>% mutate(Date = as.Date(Date,format="%d/%m/%Y")) %>% filter(Date=="2007-02-01"|Date=="2007-02-02")

# make the histogram
hist(df$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

# copy histogram to png file
dev.copy(png,"plot1.png",width=480,height=480)
dev.off()



