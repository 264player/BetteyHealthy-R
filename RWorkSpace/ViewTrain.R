library(ggplot2)
library(gridExtra)

source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")
#source<-subset(source,CCCT>4000&CVCT>1600&CS_Name!="CS2_38")
#source<-subset(source,CVCT!=0&CCCT!=0)
cs38 <- subset(source,CS_Name=="CS2_38"&cycle>200&CCCT>4000&CVCT>1600)
source<-subset(source,CCCT>4000&CVCT>1600&CS_Name!="CS2_38")
source <- rbind(cs38,source)
str(source)
summary(source)
summary(source)
str(source)
CS2_35 <- subset(source,CS_Name == "CS2_35")
CS2_36 <- subset(source,CS_Name == "CS2_36")
CS2_37 <- subset(source,CS_Name == "CS2_37")
CS2_38 <- subset(source,CS_Name == "CS2_38")
summary((CS2_38))

ggplot(data = source)+
  geom_point(data = CS2_35,aes(x=cycle,y=capacity,color="CS2_35"))+
  geom_point(data = CS2_36,aes(x=cycle,y=capacity,color="CS2_36"))+
  geom_point(data = CS2_37,aes(x=cycle,y=capacity,color="CS2_37"))+
  geom_point(data = CS2_38,aes(x=cycle,y=capacity,color="CS2_38"))+
  labs(title = "电池容量和充放电循环次数的关系",x="Cycles",y="Capacity",color="CS_Name") +
  scale_color_manual(values = c("CS2_35" = "red", "CS2_36" = "blue", "CS2_37" = "green", "CS2_38" = "black"),
                     labels = c("CS2_35", "CS2_36", "CS2_37", "CS2_38"))

ggplot(data = source)+
  geom_line(data = CS2_35,aes(x=cycle,y=capacity,color="CS2_35"))+
  geom_line(data = CS2_36,aes(x=cycle,y=capacity,color="CS2_36"))+
  geom_line(data = CS2_37,aes(x=cycle,y=capacity,color="CS2_37"))+
  geom_line(data = CS2_38,aes(x=cycle,y=capacity,color="CS2_38"))+
  labs(title = "电池容量和充放电循环次数的关系",x="Cycles",y="Capacity",color="CS_Name") +
  scale_color_manual(values = c("CS2_35" = "red", "CS2_36" = "blue", "CS2_37" = "green", "CS2_38" = "black"),
                     labels = c("CS2_35", "CS2_36", "CS2_37", "CS2_38"))

ggplot(data = source)+
  geom_line(data = CS2_35,aes(x=cycle,y=resistance,color="CS2_35"))+
  geom_line(data = CS2_36,aes(x=cycle,y=resistance,color="CS2_36"))+
  geom_line(data = CS2_37,aes(x=cycle,y=resistance,color="CS2_37"))+
  geom_line(data = CS2_38,aes(x=cycle,y=resistance,color="CS2_38"))+
  labs(title = "电池内阻和充放电循环次数的关系",x="Cycles",y="resistance",color="CS_Name") +
  scale_color_manual(values = c("CS2_35" = "red", "CS2_36" = "blue", "CS2_37" = "green", "CS2_38" = "black"),
                     labels = c("CS2_35", "CS2_36", "CS2_37", "CS2_38"))

ggplot(data = source)+
  geom_line(data = CS2_35,aes(x=cycle,y=CCCT,color="CS2_35"))+
  geom_line(data = CS2_36,aes(x=cycle,y=CCCT,color="CS2_36"))+
  geom_line(data = CS2_37,aes(x=cycle,y=CCCT,color="CS2_37"))+
  geom_line(data = CS2_38,aes(x=cycle,y=CCCT,color="CS2_38"))+
  labs(title = "电池恒定电流充电时间和充放电循环次数的关系",x="Cycles",y="CCCT",color="CS_Name") +
  scale_color_manual(values = c("CS2_35" = "red", "CS2_36" = "blue", "CS2_37" = "green", "CS2_38" = "black"),
                     labels = c("CS2_35", "CS2_36", "CS2_37", "CS2_38"))

ggplot(data = source)+
  geom_line(data = CS2_35,aes(x=cycle,y=CVCT,color="CS2_35"))+
  geom_line(data = CS2_36,aes(x=cycle,y=CVCT,color="CS2_36"))+
  geom_line(data = CS2_37,aes(x=cycle,y=CVCT,color="CS2_37"))+
  geom_line(data = CS2_38,aes(x=cycle,y=CVCT,color="CS2_38"))+
  labs(title = "电池恒定电压充电时间和充放电循环次数的关系",x="Cycles",y="CVCT",color="CS_Name") +
  scale_color_manual(values = c("CS2_35" = "red", "CS2_36" = "blue", "CS2_37" = "green", "CS2_38" = "black"),
                     labels = c("CS2_35", "CS2_36", "CS2_37", "CS2_38"))
