#1.IMPORT MODULES/ LIBRARIES
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import linear_model

#2. TAKE INPUT FILE
df = pd.read_excel('Marks.xlsx')
print(df)

#3. SELECT SUITABLE ALGORITHM
multi = linear_model.LinearRegression()

#4. TRAIN DATA , DEFINE INPUT AND OUTPUT
multi.fit(df[['Study hours','Attendance','Previous scores']],df.Final)

#5. PREDICT THE OUTPUT
# hum = int(input("enter the Humidity (%)  = "))
# ws = int(input("enter the Wind speed = "))
# pre = int(input("enter the Precipitation = "))
# ap = int(input("enter the Atmospheric Pressure = "))

df_output = pd.read_excel('Studata.xlsx')
temp = multi.predict(df_output)
print("The predicted Final score  =",temp)
