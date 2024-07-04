# model <- readRDS("my_linear_model1.rds")
model <- readRDS("my_linear_model1.rds")

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
str(sourceData)
testData <- subset(sourceData,SoH == -100)
str(testData)
summary(testData)

result <- predict(model,testData[,c("capacity","resistance","CVCT","CCCT")])-0.113



output_values <- cbind(testData[,c("X","cycle","CS_Name")],result)

write.csv(output_values,"submission.csv",row.names = FALSE)