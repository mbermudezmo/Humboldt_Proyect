#!/usr/bin/env python3

import pandas as pd
import numpy as np
import matplotlib

# path where is located the data, file with .L columns

df=pd.read_csv('L_columns.tsv', sep='\t' , low_memory=False)

# the strategy is build code in order to obtain differentes plots


#Frequency of number of properites reported
conteo=df.count(axis=1)

conteo.to_csv('number_of_L.csv',index=False)

#print (min(conteo))
#print (max(conteo))

df.count(axis=1).plot.hist(bins=110,log=True).figure.savefig('fig1.pdf')
