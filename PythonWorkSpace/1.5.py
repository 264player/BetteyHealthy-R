import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor, VotingRegressor
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split, GridSearchCV, cross_val_score
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import StandardScaler, PolynomialFeatures
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer
from xgboost import XGBRegressor
from lightgbm import LGBMRegressor

# 读取数据
train_data = pd.read_csv('train_data.csv')
dev_data = pd.read_csv('dev_data.csv')
test_data = pd.read_csv('test_data.csv')

# 特征和标签
features = ['cycle', 'capacity', 'resistance', 'CCCT', 'CVCT']
target = 'SoH'

X_train = train_data[features]
y_train = train_data[target]

X_dev = dev_data[features]
y_dev = dev_data[target]

X_test = test_data[features]

# 数据预处理和特征工程
scaler = StandardScaler()
imputer = SimpleImputer(strategy='mean')
poly = PolynomialFeatures(degree=2, include_bias=False)

X_train_scaled = scaler.fit_transform(imputer.fit_transform(X_train))
X_dev_scaled = scaler.transform(imputer.transform(X_dev))
X_test_scaled = scaler.transform(imputer.transform(X_test))

X_train_poly = poly.fit_transform(X_train_scaled)
X_dev_poly = poly.transform(X_dev_scaled)
X_test_poly = poly.transform(X_test_scaled)

# 模型选择和调参
rf = RandomForestRegressor(random_state=42)
gbr = GradientBoostingRegressor(random_state=42)
xgb = XGBRegressor(random_state=42)
lgbm = LGBMRegressor(random_state=42)

param_grid_rf = {
    'n_estimators': [100, 200],
    'max_depth': [10, 20]
}

param_grid_gbr = {
    'n_estimators': [100, 200],
    'learning_rate': [0.1, 0.01],
    'max_depth': [3, 5]
}

param_grid_xgb = {
    'n_estimators': [100, 200],
    'learning_rate': [0.1, 0.01],
    'max_depth': [3, 5]
}

param_grid_lgbm = {
    'n_estimators': [100, 200],
    'learning_rate': [0.1, 0.01],
    'max_depth': [10, 20]
}

grid_search_rf = GridSearchCV(rf, param_grid_rf, cv=5, scoring='neg_mean_squared_error', n_jobs=-1)
grid_search_gbr = GridSearchCV(gbr, param_grid_gbr, cv=5, scoring='neg_mean_squared_error', n_jobs=-1)
grid_search_xgb = GridSearchCV(xgb, param_grid_xgb, cv=5, scoring='neg_mean_squared_error', n_jobs=-1)
grid_search_lgbm = GridSearchCV(lgbm, param_grid_lgbm, cv=5, scoring='neg_mean_squared_error', n_jobs=-1)

grid_search_rf.fit(X_train_poly, y_train)
grid_search_gbr.fit(X_train_poly, y_train)
grid_search_xgb.fit(X_train_poly, y_train)
grid_search_lgbm.fit(X_train_poly, y_train)

best_rf = grid_search_rf.best_estimator_
best_gbr = grid_search_gbr.best_estimator_
best_xgb = grid_search_xgb.best_estimator_
best_lgbm = grid_search_lgbm.best_estimator_

# 模型集成
voting_regressor = VotingRegressor([('rf', best_rf), ('gbr', best_gbr), ('xgb', best_xgb), ('lgbm', best_lgbm)])
voting_regressor.fit(X_train_poly, y_train)

# 交叉验证
cv_scores = cross_val_score(voting_regressor, X_train_poly, y_train, cv=5, scoring='neg_mean_squared_error')
rmse_scores = np.sqrt(-cv_scores)
print(f'Cross-validated RMSE: {rmse_scores.mean()}')

# 对开发集进行预测
pred_dev = voting_regressor.predict(X_dev_poly)
rmse_dev = np.sqrt(mean_squared_error(y_dev, pred_dev))
print(f'Development RMSE: {rmse_dev}')

# 对测试集进行预测
test_pred = voting_regressor.predict(X_test_poly)
test_data['result'] = test_pred

# 生成提交文件
submission = test_data[['cycle', 'CS_Name', 'result']]
submission.to_csv('submission3.csv', index=False)
