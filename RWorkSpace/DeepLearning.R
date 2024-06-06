library(keras)
library(tensorflow)


source <- read.csv("D:\\studyDay\\RWorkSpace\\data\\battery\\train_data.csv")[,c("cycle","capacity","SoH","CCCT")]
str(source)
summary(source)

x_train <- source[,-3]
y_train <- source[,3]



model <- keras_model_sequential() %>%
  layer_dense(units = 64, activation = 'linear', input_shape = 5) %>%
  layer_dense(units = 32, activation = 'linear') %>%
  layer_dense(units = 1)

# 编译模型
model %>% compile(
  loss = 'mean_squared_error',
  optimizer = optimizer_adam(),
  metrics = c('mean_absolute_error')
)

# 训练模型
history <- model %>% fit(
  x_train, y_train,
  epochs = 100,
  batch_size = 128,
  validation_split = 0.2
)

# 输出训练过程中的指标
plot(history)