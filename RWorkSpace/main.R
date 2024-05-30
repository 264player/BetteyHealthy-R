# start program
d = read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")
str(d)
plot(d$cycle,d$SoH)
plot(d$capacity,d$SoH)
plot(d$resistance,d$SoH)
plot(d$CCCT,d$SoH)
plot(d$CVCT,d$SoH)

lmfit0 <- lm(cycle~SoH,d)
lmfit1 <- lm(capacity~SoH,d)
lmfit2 <- lm(resistance~SoH,d)
lmfit3 <- lm(CCCT~SoH,d)
lmfit4 <- lm(CVCT~SoH,d)

abline(lmfit0,col="red")
abline(lmfit1,col="red")
abline(lmfit2,col="red")
abline(lmfit3,col="red")
abline(lmfit4,col="red")

lmfit1
