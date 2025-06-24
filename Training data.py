import pandas as pd
import pickle
# from sklearn.externals import joblib
import warnings
warnings.filterwarnings('ignore')

#SINGLE VARIABLE LINEAR REGRESSION

# fm = open('temperature model','rb')
# trainedmodel = pickle.load(fm)
# fm.close()
# op = trainedmodel.predict([[33]])
# print("Temperature - " , op)

#MULTI VARIABLE LINEAR REGRESSION

fmodel = open('weather_model','rb')
trainedmodel = pickle.load(fmodel)
fmodel.close()
df_op = pd.read_excel('Find.xlsx')
res = trainedmodel.predict(df_op)
print("The predicted Temperature is =",res)




