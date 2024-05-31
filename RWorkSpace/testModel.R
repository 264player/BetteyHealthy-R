model <- readRDS("my_linear_model1.rds")

Data <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
testData <- subset(Data,SoH == -100)
str(testData)
summary(testData)

result <- predict(model,testData[,c("cycle","capacity","resistance","CCCT","CVCT")])

output_values <- cbind(testData[,c("cycle","CS_Name")],result)

write.csv(output_values,"submission.csv",row.names = TRUE)