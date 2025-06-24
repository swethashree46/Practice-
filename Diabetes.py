from warnings import filterwarnings

import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score
import warnings
warnings.filterwarnings('ignore')

print("Started")

# Load the dataset
df = pd.read_csv("diabetes.csv")
print("Columns in dataset:", df.columns)

# Checking for missing values
print("Missing values:\n", df.isnull().sum())

# Splitting dataset into features and target
X = df.drop("Outcome", axis=1)
y = df["Outcome"]

# Standardizing the dataset
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# Splitting into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# Data visualization
plt.figure(figsize=(8,5))
plt.scatter(df[df.Outcome == 0]['Glucose'], df[df.Outcome == 0]['BMI'], color='green', marker='o', label='No Diabetes')
plt.scatter(df[df.Outcome == 1]['Glucose'], df[df.Outcome == 1]['BMI'], color='red', marker='+', label='Diabetes')
plt.xlabel('Glucose Level')
plt.ylabel('BMI')
plt.legend()
plt.show()

# Model training
model = SVC(kernel='rbf', C=1, gamma='scale')
model.fit(X_train, y_train)

# Model evaluation
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print("Model Accuracy:", accuracy * 100, "%")

#
# # Confusion matrix
# plt.figure(figsize=(5,4))
# plt.imshow(confusion_matrix(y_test, y_pred), cmap='Blues', interpolation='nearest')
# plt.colorbar()
# plt.title("Confusion Matrix")
# plt.xlabel("Predicted")
# plt.ylabel("Actual")
# plt.show()

# Predicting on a new sample data
sample = [[148, 72, 35, 0, 33.6, 0.627, 50]]  # Example input
test_sample_scaled = scaler.transform(sample)
prediction = model.predict(test_sample_scaled)
print("Predicted Outcome:", "Diabetic" if prediction[0] == 1 else "Non-Diabetic")