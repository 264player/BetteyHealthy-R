library(neuralnet)

source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
cs38 <- subset(source,CS_Name=="CS2_38"&cycle>200&CCCT>4000&CVCT>1600)
source<-subset(source,CCCT>4000&CVCT>1600&CS_Name!="CS2_38")
source <- rbind(cs38,source)
#str(source)
#summary(source)

head(source)

model <- neuralnet(SoH ~ capacity+CVCT+CCCT+resistance,data = source,hidden = c(36,18,9,3),stepmax = 20000)

#plot(model)

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
sourceData <- subset(sourceData,CVCT!=0&CCCT!=0)
#str(sourceData)
testData <- subset(sourceData,SoH != -100)

summary(testData)

result <- predict(model,testData[,c("cycle","capacity","resistance","CVCT","CCCT")])
actual <- testData[,"SoH"]

# 计算均方根误差 RMSE
rmse <- sqrt(mean((actual - result)^2))

# 打印 RMSE
print(paste("RMSE:", rmse))
saveRDS(model, "my_nnet_model1.rds")