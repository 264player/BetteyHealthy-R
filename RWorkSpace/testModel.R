# model <- readRDS("my_linear_model1.rds")
b1 <- readRDS("b1.rds")
b2 <- readRDS("b2.rds")
b3 <- readRDS("b3.rds")
b4 <- readRDS("b4.rds")

sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
str(sourceData)
testData <- subset(sourceData,SoH == -100)
tcs35<-subset(testData,CS_Name=="CS2_35")
tcs36<-subset(testData,CS_Name=="CS2_36")
tcs37<-subset(testData,CS_Name=="CS2_37")
tcs38<-subset(testData,CS_Name=="CS2_38")



result1 <- predict(b1,tcs35[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0683
print(result1)
result2 <- predict(b2,tcs36[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0995
result3 <- predict(b3,tcs37[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0812
result4 <- predict(b4,tcs38[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.065

o1 <- cbind(tcs35[,c("X","cycle","CS_Name")],result1)
o2 <- cbind(tcs36[,c("X","cycle","CS_Name")],result2)
o3 <- cbind(tcs37[,c("X","cycle","CS_Name")],result3)
o4 <- cbind(tcs38[,c("X","cycle","CS_Name")],result4)

# 合并成一个列
result <- cbind(o1,o2,o3,o4)


summary(testData)
summary(result1)
summary(result2)
summary(result3)
summary(result4)

write.csv(result,"submission2.csv",row.names = FALSE)