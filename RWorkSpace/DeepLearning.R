#install.packages("reticulate")
#install.packages("tensorflow")
#install.packages("keras")
library(reticulate)
library(tensorflow)
library(keras)

# 使用系统Python
use_python("D:/Python3.11", required = TRUE)

# 验证TensorFlow安装
tf$constant("Hello, TensorFlow!")

source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
cs38 <- subset(source,CS_Name=="CS2_38"&cycle>200&CCCT>4000&CVCT>1600)
source<-subset(source,CCCT>4000&CVCT>1600&CS_Name!="CS2_38")
source <- rbind(cs38,source)
devsource <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")#[,c("cycle","capacity","SoH","resistance","CVCT","CCCT","CS_Name")]
source <- rbind(devsource,source)

str(source)
summary(source)


# 分离特征和目标变量
x_train <- as.matrix(source[, c("capacity", "resistance", "CVCT", "CCCT")])
y_train <- as.matrix(source[, "SoH"])

# 读取测试数据
sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
sourceData <- subset(sourceData, CVCT != 0 & CCCT != 0)
sourceData <- sourceData[complete.cases(sourceData), ]  # 移除缺失值
testData <- subset(sourceData, SoH != -100)

# 分离特征和目标变量
x_test <- as.matrix(testData[, c("capacity", "resistance", "CVCT", "CCCT")])
y_test <- as.matrix(testData[, "SoH"])

# 标准化数据
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}

x_train <- apply(x_train, 2, normalize)
x_test <- apply(x_test, 2, normalize)

# 定义模型
model <- keras_model_sequential() 
model %>% 
  layer_input(shape = c(ncol(x_train))) %>%
  layer_dense(units = 64, activation = "relu") %>%
  layer_dense(units = 32, activation = "relu") %>%
  layer_dense(units = 1)

# 编译模型
model %>% compile(
  loss = "mean_squared_error",
  optimizer = optimizer_adam(),
  metrics = list("mean_squared_error")
)

# 训练模型
history <- model %>% fit(
  x_train, y_train,
  epochs = 100,
  batch_size = 32,
  validation_split = 0.2
)

# 评估模型
model %>% evaluate(x_test, y_test)

# 进行预测
predictions <- model %>% predict(x_test)

# 计算均方根误差 RMSE
rmse <- sqrt(mean((y_test - predictions)^2))

# 打印 RMSE
print(paste("RMSE:", rmse))
