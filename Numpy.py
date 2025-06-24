# import numpy as np
# a= np.array([[2,4,6],[3,5,7]])
# print(a)
# # res=a.ndim
# # print(res)
# # op=a.shape
# # print(op)


import pandas as pd
df = pd.read_excel(r'EB.xlsx')
print(df)

#BASIC FUNCTIONS
# print(df.shape)
# print(df.head(2))
# print(df.tail(2))
# print(df.columns)

#READ DATA FUNCTIONS
# df['NAME'][3]
# df.iloc[5]
#
# #FILTERING
# df.loc[df['NAME']=='Aravindh']


#SORTING
# print(df.describe)
# df.sort_values(['JANUARY'], inplace=True, ascending=True)
# print(df)

# df.sort_values(['NAME','JANUARY'],inplace = True, ascending = True)
# print(df)  # Print the updated DataFrame

# #CONDITIONAL STATEMENTS
# df.loc[df['NAME'] == 'Aravindh', 'NAME'] = 'Swetha'
# print(df)

#GROUP BY
# df.groupby(['JANUARY']).sum()
# print(df)

#CHUNK SIZE
df.chunk_size = 3
print(df)

