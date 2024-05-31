library(ggplot2)
library(gridExtra)
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CCCT","CVCT")]
str(source)
summary(source)

p1<-ggplot(data=source,mapping=aes(x=cycle,y=SoH))+geom_point(fill='steelblue')+labs(x='周期数',y='电池健康程度')
p2<-ggplot(data=source,mapping=aes(x=capacity,y=SoH))+geom_point(fill='steelblue')+labs(x='电池容量',y='电池健康程度')
p3<-ggplot(data=source,mapping=aes(x=resistance,y=SoH))+geom_point(fill='steelblue')+labs(x='电池内阻',y='电池健康程度')
p4<-ggplot(data=source,mapping=aes(x=CCCT,y=SoH))+geom_point(fill='steelblue')+labs(x='恒定电压充电时间',y='电池健康程度')
p5<-ggplot(data=source,mapping=aes(x=CVCT,y=SoH))+geom_point(fill='steelblue')+labs(x='恒定电流充电时间',y='电池健康程度')

grid.arrange(p1,p2)
grid.arrange(p3)
grid.arrange(p4)
grid.arrange(p5)

model <- lm(SoH~.,data=source)
model
saveRDS(model, "my_linear_model1.rds")