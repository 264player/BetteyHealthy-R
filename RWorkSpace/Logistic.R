library(ggplot2)
library(gridExtra)
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CCCT","CVCT")]
str(source)
summary(source)


model <- lm(SoH~.,data=source)
model
saveRDS(model, "my_linear_model1.rds")