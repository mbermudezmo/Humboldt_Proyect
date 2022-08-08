#!/usr/bin/env python3
#The strategy follows as: for each one of the 30 columns we will plot the according interested information.

#To do the tests it is convenient work with few data.
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data=pd.read_csv('complete_columns.tsv', sep='\t')
#data=pd.read_csv('/scr/k70san/eugenio/HOC/Marisol/DATA/DIAGNOSE/bin/Datos/unique_useful_data.tsv', sep='\t')
#headers=df.columns

#this is a plot that shows the differents types of reactions.
# data['IDE.NE'].plot.hist(bins=50).figure.savefig('NE_plot.pdf')
# data['IDE.CHA'].plot.hist(bins=50).figure.savefig('CHA_plot.pdf')
# data['IDE.NA'].plot.hist(bins=50).figure.savefig('NA_plot.pdf')

#data['IDE.STYPE'].value_counts().plot(kind='barh').figure.savefig('STYPE_plot.pdf')

type_of_data=data['IDE.STYPE'].value_counts()

type_of_data.to_csv('types_of_reactios.csv')

#print(data['IDE.STYPE'].value_counts())
# data['IDE.AVAIL'].plot.hist(bins=50).figure.savefig('AVAIL_plot.pdf')
# data['IDE.MAXPUB'].plot.hist(bins=50).figure.savefig('MAXPUB_plot.pdf')
# data['IDE.NUMREF'].plot.hist(bins=50).figure.savefig('NUMREF_plot.pdf')
# data['IDE.FULLRXNS'].plot.hist(bins=50).figure.savefig('FULLRXNS_plot.pdf')
# data['IDE.HASBIO'].plot.hist(bins=50).figure.savefig('HASBIO_plot.pdf')

# for i in headers:
#     dict[i]=df[i].hist()
#     print (dict[i])

# for i in headers:
#     fig=dict[i].get_figure()
#     fig.savefig('figure'=i'.png')

# print (data['IDE.NE'])
#ax=data['IDE.NE'].hist(bins=50)
#fig=ax.get_figure()
#fig.save('p1.pdf')


