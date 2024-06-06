
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","CCCT","CVCT")]
str(source)
summary(source)
summary(source[,-3])


saveRDS(model, "my_ling_model1.rds")