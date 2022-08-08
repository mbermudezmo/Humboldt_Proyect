#!/usr/bin/env python3
# This scripts give us information about the number of properties of substances published

import pandas as pd
import numpy as np
import matplotlib
from collections import defaultdict
try:
    import cPickle as pickle
except ImportError:  # Python 3.x
    import pickle

# path where is located the data, file with .L columns
df=pd.read_csv('L_columns.tsv', sep='\t' , low_memory=False)
# file to tests
#df=pd.read_csv('L_columns_10.tsv', sep='\t' , low_memory=False)

#Frequency of number of properites reported
#With this line we can count the nonempty cells .L
#conteo=df.count(axis=1)

#The file with that information is
conte=pd.read_csv('number_of_L.csv')

#Histogram
figu=conte.plot.hist(bins=105,log=True,legend=False,xlim=[0,106])
figu.set_xlabel('Number of substances')
figu.set_ylabel('Number of properties')
figu.figure.savefig('histogram_complete.pdf')

fig=conte.plot.hist(bins=105,log=False,xlim=[50,105],ylim=[0,80],legend=False)
fig.set_xlabel('Number of substances')
fig.set_ylabel('Number of properties')
fig.figure.savefig('histogram_tail.pdf')

# conteo=conte.squeeze() #The data is loaded as a dataframe, it is necessary change it to series.pandas
# #print(type(conte))

# #I select the firs 100 substances with more properties published
# primeras10=conteo.sort_values(ascending=False).head(100) 
# indeces=list(primeras10.index.values) # indeces store the location
# prime=list(primeras10) # we have to convert the data to a liste to hadle it better
# #print(primeras10)#indeces,prime)

# #Here we identify the position in the sorted list and the IDE.RXN, as a list
# lista=[]
# for i in range(100):
#   k=indeces[i]
#   j=df.loc[k][0]
#   lista.append((k,j))
# #  print(lista)
#   #mydic[prime[i]]=(k,j)
# #  print(indeces[i],prime[i],df.loc[indeces[i]][0])

# #The information is saved it as a directory wich the key es the number of properties published
# d = defaultdict(list)
# for key, value in zip(prime, lista): 
#     d[key].append(value)

# my_dict=dict(d)

# with open('dictionary_100_first_substances_with_more_properties.p', 'wb') as fp:
#     pickle.dump(my_dict, fp, protocol=pickle.HIGHEST_PROTOCOL)


