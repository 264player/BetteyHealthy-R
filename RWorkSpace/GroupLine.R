library(ggplot2)
library(gridExtra)
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
cs35<-subset(source,CS_Name=="CS2_35")
cs36<-subset(source,CS_Name=="CS2_36")
cs37<-subset(source,CS_Name=="CS2_37")
cs38 <- subset(source,CS_Name=="CS2_38"&cycle>200&CCCT>4000&CVCT>1600)

devsource <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
dcs35<-subset(devsource,CS_Name=="CS2_35")
dcs36<-subset(devsource,CS_Name=="CS2_36")
dcs37<-subset(devsource,CS_Name=="CS2_37")
dcs38 <- subset(devsource,CS_Name=="CS2_38")

cs35<-rbind(cs35,dcs35)
cs36<-rbind(cs36,dcs36)
cs37<-rbind(cs37,dcs37)
cs38<-rbind(cs38,dcs38)


#model <- lm(SoH~cycle+capacity+resistance+CVCT+CCCT,data=source)
#model

b1<-lm(SoH~cycle*capacity+cycle:resistance+cycle:CVCT+cycle:CCCT,data=cs35)
b2<-lm(SoH~cycle*capacity+cycle:resistance+cycle:CVCT+cycle:CCCT,data=cs36)
b3<-lm(SoH~cycle*capacity+cycle:resistance+cycle:CVCT+cycle:CCCT,data=cs37)
b4<-lm(SoH~cycle*capacity+cycle:resistance+cycle:CVCT+cycle:CCCT,data=cs38)


sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\dev_data.csv")
sourceData <- subset(sourceData,CVCT!=0&CCCT!=0)
tcs35<-subset(sourceData,CS_Name=="CS2_35"&SoH != -100)
tcs36<-subset(sourceData,CS_Name=="CS2_36"&SoH != -100)
tcs37<-subset(sourceData,CS_Name=="CS2_37"&SoH != -100)
tcs38 <- subset(sourceData,CS_Name=="CS2_38"&SoH != -100)


result1 <- predict(b1,tcs35[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0383
result2 <- predict(b2,tcs36[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0395
result3 <- predict(b3,tcs37[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.0212
result4 <- predict(b4,tcs38[,c("cycle","capacity","resistance","CVCT","CCCT")])-0.035


actual1 <- tcs35[,"SoH"]
actual2 <- tcs36[,"SoH"]
actual3 <- tcs37[,"SoH"]
actual4 <- tcs38[,"SoH"]


# 计算均方根误差 RMSE
rmse1 <- sqrt(mean((actual1 - result1)^2))
rmse2 <- sqrt(mean((actual2 - result2)^2))
rmse3 <- sqrt(mean((actual3 - result3)^2))
rmse4 <- sqrt(mean((actual4 - result4)^2))


print(paste("RMSE1:", rmse1))
print(paste("RMSE2:", rmse2))
print(paste("RMSE3:", rmse3))
print(paste("RMSE4:", rmse4))

saveRDS(b1, "b1.rds")
saveRDS(b2, "b2.rds")
saveRDS(b3, "b3.rds")
saveRDS(b4, "b4.rds")