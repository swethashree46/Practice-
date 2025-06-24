import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.datasets import load_iris
from sklearn.svm import SVC
from matplotlib import pyplot as plt

print("started")
irisdf = load_iris()
print("Input column names of the iris dataframe - " , irisdf.feature_names)
print("actual data of the iris data frame - " , irisdf.data)
print("output column names of iris dataframe - " , irisdf.target_names)


print(" \n =========================================   \n")
# creating Dataframe for IRIS featurenames
df = pd.DataFrame(irisdf.data,columns=irisdf.feature_names)
# print(df)
# adding target to the dataframe
df['target'] = irisdf.target
print(df)

# print only the target value one fields or rows
# print(df[df.target == 1])




# # # # adding flower names derived from target column to the dataframe using pandas apply menthod
#
# #
print("0 is = > " , irisdf.target_names[0])
print("1 is = > " ,irisdf.target_names[1])
print("2 is = > " ,irisdf.target_names[2])

df['flowername'] = df.target.apply(lambda x:irisdf.target_names[x])
print(df)
# df.to_csv(r'flowersdataset.csv')




# # # # # Now lets have a code which will display the data in graph so that we can see the boundary line

df0 = df[df['target'] == 0]
df1 = df[df['target'] == 1]
df2 = df[df['target'] == 2]

plt.xlabel('sepal length (cm)')
plt.ylabel('sepal width (cm)')

plt.scatter(df0['sepal length (cm)'],df0['sepal width (cm)'],color="green",marker="*")
plt.scatter(df1['sepal length (cm)'],df1['sepal width (cm)'],color="red",marker="+")
plt.scatter(df2['sepal length (cm)'],df2['sepal width (cm)'],color="blue",marker="o")
plt.show()


plt.xlabel('petal length (cm)')
plt.ylabel('petal width (cm)')

plt.scatter(df0['petal length (cm)'],df0['petal width (cm)'],color="green",marker="*")
plt.scatter(df1['petal length (cm)'],df1['petal width (cm)'],color="red",marker="+")
plt.show()


##### Model creation process will start here



X = df.drop(df[['target','flowername']],axis="columns")
Y = df['target']

X_train,X_test,Y_train,Y_test = train_test_split(X,Y,test_size=0.2)

model = SVC()
model.fit(X_train,Y_train)

scr = model.score(X_test,Y_test)
print(" Score of model = " , scr * 100 , " percent accuracte ")


res = model.predict([[7.0,3.8,6.0,2.9]])
print(res)
print("flower name is = > " ,irisdf.target_names[res])

