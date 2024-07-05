library(ggplot2)
library(gridExtra)
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
cs38 <- subset(source,CS_Name=="CS2_38"&cycle>200&CCCT>4000&CVCT>1600)
source<-subset(source,CCCT>4000&CVCT>1600&CS_Name!="CS2_38")
source <- rbind(cs38,source)
devsource <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
source <- rbind(devsource,source)
str(source)
summary(source)


#model <- lm(SoH~cycle+capacity+resistance+CVCT+CCCT,data=source)
#model
#model <- lm(SoH~cycle*capacity+cycle:resistance+cycle:CVCT+cycle:CCCT+CS_Name,data=source)

model <- lm(SoH~capacity+resistance+CVCT+CCCT+CS_Name,data=source)
model
#plot(model)

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\dev_data.csv")
sourceData <- subset(sourceData,CVCT!=0&CCCT!=0)
str(sourceData)
testData <- subset(sourceData,SoH != -100)

summary(testData)

result <- predict(model,testData[,c("cycle","capacity","resistance","CVCT","CCCT","CS_Name")])-0.07
actual <- testData[,"SoH"]

# 计算均方根误差 RMSE
rmse <- sqrt(mean((actual - result)^2))

print(paste("RMSE:", rmse))

saveRDS(model, "my_linear_model1.rds")