#1.IMPORT MODULES/LIBRARIES

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import linear_model
import pickle
# from sklearn.externals import joblib


#2.TAKE INPUT FILE

df = pd.read_csv('temperature.csv')
print(df)

#3. SELECT SUITABLE ALGORITHM
model = linear_model.LinearRegression()

#4. TRAIN THE MODULE , DEFINING INPUT AND OUTPUT
model.fit(df[['temp']],df.humidity)

#
# #5. PREDICT THE OUTPUT
# area = int(input(" enter the temperature to be predict the humidity = "))
# res = reg.predict([[area]])
# print(" the prediction result is = " , res)
#
#6. CREATE THE MODEL
fm = open('temperature model','wb')
pickle.dump(model,fm)
fm.close()

