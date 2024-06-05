import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt

# 加载数据
train_data = pd.read_csv('train_data.csv')
dev_data = pd.read_csv('dev_data.csv')
test_data = pd.read_csv('test_data.csv')

# 查看数据格式
print(train_data.head())
print(dev_data.head())
print(test_data.head())

# 数据预处理
# 删除异常值行（SoH == -100）
train_data = train_data[train_data['SoH'] != -100]
dev_data = dev_data[dev_data['SoH'] != -100]

# 提取特征和目标值
X_train = train_data[['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT']]
y_train = train_data['SoH']

X_dev = dev_data[['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT']]
y_dev = dev_data['SoH']

X_test = test_data[['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT']]

# 构建并训练模型
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# 验证模型
y_dev_pred = model.predict(X_dev)
rmse = np.sqrt(mean_squared_error(y_dev, y_dev_pred))
print(f'Validation RMSE: {rmse}')

# 可视化预测结果与真实值的对比
plt.figure(figsize=(10, 6))
plt.plot(y_dev.values, label='True SoH')
plt.plot(y_dev_pred, label='Predicted SoH')
plt.legend()
plt.xlabel('Sample index')
plt.ylabel('SoH')
plt.title('True vs Predicted SoH on Validation Set')
plt.show()

# 在测试集上预测SoH
test_data['SoH'] = model.predict(X_test)

# 保存预测结果
test_data.to_csv('test_data_with_predictions.csv', index=False)
