library(ggplot2)
library(gridExtra)
library(readxl)


info <- read_xlsx("D:\\studyDay\\RWorkSpace\\data\\battery\\Raw_data\\CALCE_Batteries\\CS2_35\\CS2_35_1_10_11.xlsx",1)
channel <- read_xlsx("D:\\studyDay\\RWorkSpace\\data\\battery\\Raw_data\\CALCE_Batteries\\CS2_35\\CS2_35_1_10_11.xlsx",2)
statistic <- read_xlsx("D:\\studyDay\\RWorkSpace\\data\\battery\\Raw_data\\CALCE_Batteries\\CS2_35\\CS2_35_1_10_11.xlsx",3)
summary(info)
str(info)
summary(channel)
str(channel)
summary(statistic)
str(statistic)

ggplot(data = statistic,aes(x=Cycle_Index,y=`Current(A)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="电流")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Voltage(V)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="电压")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Charge_Capacity(Ah)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="充电容量")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Discharge_Capacity(Ah)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="放电容量")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Charge_Energy(Wh)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="充电能量")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Discharge_Energy(Wh)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="放电能量")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Internal_Resistance(Ohm)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="电池内阻")

ggplot(data = statistic,aes(x=Cycle_Index,y=`Charge_Time(s)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="充电时间")

ggplot(data = statistic,aes(x=Cycle_Index,y=`DisCharge_Time(s)`))+
  geom_point()+
  labs(title = "汇总",x="cycle",y="放电时间")