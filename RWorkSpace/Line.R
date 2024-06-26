library(ggplot2)
library(gridExtra)
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CVCT","CCCT")]
source<-subset(source,CVCT!=0&CCCT!=0)
str(source)
summary(source)





model <- lm(SoH~capacity*resistance*CVCT+CCCT,data=source)
model

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\dev_data.csv")
sourceData <- subset(sourceData,CVCT!=0&CCCT!=0)
str(sourceData)
testData <- subset(sourceData,SoH != -100)

summary(testData)

result <- predict(model,testData[,c("capacity","resistance","CVCT","CCCT")])
actual <- testData[,"SoH"]

# 计算均方根误差 RMSE
rmse <- sqrt(mean((actual - result)^2))

# 打印 RMSE
print(paste("RMSE:", rmse))

saveRDS(model, "my_linear_model1.rds")