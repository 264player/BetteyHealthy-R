library(neuralnet)

# 读取并处理训练数据
source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","resistance","CVCT","CCCT")]
source <- subset(source, CVCT != 0 & CCCT != 0)
source <- source[complete.cases(source), ]  # 移除缺失值
str(source)
summary(source)

# 标准化数据
normalize <- function(x) {
  return((x - min(x)) / (max(x) - min(x)))
}
#source[, c("capacity", "resistance", "CVCT", "CCCT")] <- as.data.frame(lapply(source[, c("capacity", "resistance", "CVCT", "CCCT")], normalize))

# 读取并处理测试数据
sourceData <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\test_data.csv")
sourceData <- subset(sourceData, CVCT != 0 & CCCT != 0)
sourceData <- sourceData[complete.cases(sourceData), ]  # 移除缺失值
str(sourceData)
testData <- subset(sourceData, SoH != -100)

# 标准化测试数据
#testData[, c("capacity", "resistance", "CVCT", "CCCT")] <- as.data.frame(lapply(testData[, c("capacity", "resistance", "CVCT", "CCCT")], normalize))

# 设置RMSE阈值
threshold_rmse <- 0.05
current_rmse <- Inf
best_model <- NULL
max_iterations <- 100
iteration <- 0

while (current_rmse > threshold_rmse && iteration < max_iterations) {
  iteration <- iteration + 1
  
  # 构建神经网络模型
  model <- neuralnet(SoH ~ capacity + CVCT + CCCT + resistance,
                     data = source, 
                     hidden = c(3,5,3), 
                     stepmax = 1e6)  # 增加stepmax以允许更多的迭代次数
  
  # 进行预测
  pred_input <- testData[, c("capacity", "resistance", "CVCT", "CCCT")]
  result <- compute(model, pred_input)$net.result
  
  actual <- testData[, "SoH"]
  
  # 计算均方根误差 RMSE
  rmse <- sqrt(mean((actual - result)^2))
  
  # 打印 RMSE
  print(paste("Iteration:", iteration, "RMSE:", rmse))
  
  # 如果当前模型的RMSE更低，则保存该模型
  if (rmse < current_rmse) {
    current_rmse <- rmse
    best_model <- model
  }
}

# 打印最佳RMSE
print(paste("Best RMSE:", current_rmse))

# 可视化最佳模型
if (!is.null(best_model)) {
  plot(best_model)
  saveRDS(best_model, "my_nnet_model2.rds")
} else {
  print("No converged model found.")
}
