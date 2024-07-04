import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
import numpy as np

# 1. 数据加载和预处理
train_data = pd.read_csv('train_data.csv')
test_data = pd.read_csv('test_data.csv')
dev_data = pd.read_csv('dev_data.csv')

# 去除列名中的多余空格
train_data.columns = train_data.columns.str.strip()
test_data.columns = test_data.columns.str.strip()
dev_data.columns = dev_data.columns.str.strip()

# 确认所有必要的列存在
required_columns = ['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT', 'SoH']
for col in required_columns:
    if col not in train_data.columns:
        print(f"Missing column in train_data: {col}")
    if col not in test_data.columns and col != 'SoH':
        print(f"Missing column in test_data: {col}")
    if col not in dev_data.columns and col != 'SoH':
        print(f"Missing column in dev_data: {col}")

# 2. 特征工程
# 选择特征和目标变量
features = ['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT']
target = 'SoH'

X_train = train_data[features]
y_train = train_data[target]

X_test = test_data[features]

# 3. 模型训练
# 划分训练集和验证集
X_train_split, X_val, y_train_split, y_val = train_test_split(X_train, y_train, test_size=0.2, random_state=42)

# 初始化和训练模型
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train_split, y_train_split)

# 4. 模型验证
# 预测验证集
y_val_pred = model.predict(X_val)

# 计算RMSE
rmse = np.sqrt(mean_squared_error(y_val, y_val_pred))
print(f'Validation RMSE: {rmse}')

# 5. 预测
# 预测测试集
test_data['result'] = model.predict(X_test)

# 确保 cycle 数对应
submission = test_data[['cycle', 'CS_Name', 'result']]

# 使用不同的文件名保存，以避免权限问题
submission.to_csv('submission_output.csv', index=False)
