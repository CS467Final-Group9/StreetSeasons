rm(list=ls())
setwd('~/Downloads/')
library(dplyr)
data <- read.csv2('./msft - msft.csv', header = TRUE, sep = ',') 
data <- as.data.frame(data)

data$Symbol <- "MSFT"
data$Topic1 <- NA
data$Topic2 <- NA
data$Topic3 <- NA

data2 <- read.csv2('./msft_topic.csv', header = TRUE, sep = ',') 

#reversing data
data <- arrange(data, -row_number())


first <- data2$Date[1][1]
first <-as.Date(as.character(first), "%m/%d/%Y")
j = 1

while(as.Date(data$Date[j],"%m/%d/%Y")< first){
  j = j+1
  #data$Topic1[j] <- as.character("replace CEO")
  #data$Topic2[j] <- as.character("Mortgage")
  #data$Topic3[j] <- as.character("Steps Down")
}
for(i in 1:nrow(data2)-1){
  second <- data2$Date[i+1][1]
  second <- as.Date(as.character(second), "%m/%d/%Y")
  while(as.Date(data$Date[j],"%m/%d/%Y")<second){
    data$Topic1[j] <- as.character(data2$Topic1[i])
    data$Topic2[j] <- as.character(data2$Topic2[i])
    data$Topic3[j] <- as.character(data2$Topic3[i])
    j = j+1
  }
}

while(j <= nrow(data)){
  data$Topic1[j] <- as.character(data2$Topic1[nrow(data2)])
  data$Topic2[j] <- as.character(data2$Topic2[nrow(data2)])
  data$Topic3[j] <- as.character(data2$Topic3[nrow(data2)])
  j = j+1
}
data$Open <- NULL
data$High <- NULL
data$Low <- NULL

data <- as.matrix(data)

write.csv(data,na = "no topic", file = "./msft_done.csv",eol="\r")

