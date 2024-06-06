library(neuralnet)

source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CVCT","CCCT")]
source<-subset(source,CVCT!=0&CCCT!=0)
str(source)
summary(source)

head(source)

model <- neuralnet(SoH ~ cycle+capacity+CVCT+CCCT+resistance,data = source,hidden = c(7,5,3),stepmax = 20000,algorithm = "rprop+")

plot(model)

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
sourceData <- subset(sourceData,CVCT!=0&CCCT!=0)
str(sourceData)
testData <- subset(sourceData,SoH != -100)

summary(testData)

result <- predict(model,testData[,c("cycle","capacity","resistance","CVCT","CCCT")])
actual <- testData[,"SoH"]

# 计算均方根误差 RMSE
rmse <- sqrt(mean((actual - result)^2))

# 打印 RMSE
print(paste("RMSE:", rmse))
saveRDS(model, "my_nnet_model1.rds")