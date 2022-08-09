#!/usr/bin/env python3
#The strategy follows as: for each one of the 30 columns we will plot the according interested information.

#To do the tests it is convenient work with few data.
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

data=pd.read_csv('complete_columns_100.tsv', sep='\t',skiprows=[1])
#data=pd.read_csv('/scr/k70san/eugenio/HOC/Marisol/DATA/DIAGNOSE/bin/Datos/unique_useful_data.tsv', sep='\t',skiprows=[1])
#headers=df.columns
print('data on')

## 1 Charge IDE.CHA 
charge_of_data=data['IDE.CHA'].value_counts()
charge_of_data.to_csv('charge_of_substances.csv')
data['IDE.CHA'].plot.hist().figure.savefig('1CHA_plot.pdf')
data['IDE.CHA'].plot.bar().figure.savefig('1CHA_Bplot.pdf')
print('charge plotted')

##2 Number of atoms IDE.NA
number_atoms=data['IDE.NA'].value_counts()
number_atoms.to_csv('number_atoms.csv')
bn=len(number_atoms)
data['IDE.NA'].plot.hist(bins=bn).clear()
data['IDE.NA'].plot.hist(bins=bn).figure.savefig('2NA_plot.pdf')
data['IDE.NA'].plot.bar().figure.savefig('2NA_Bplot.pdf')
x=list(data['IDE.NA'].value_counts().index.values)
y=list(data['IDE.NA'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('2NA_plot_bar.pdf')
print('Number of atoms plotted')

## 3 Number of elements IDE.NE
number_elements=data['IDE.NE'].value_counts()
number_elements.to_csv('number_elements.csv')
bn=len(number_elements)
data['IDE.NE'].plot.hist(bins=50).clear()
data['IDE.NE'].plot.hist(bins=bn).figure.savefig('3NE_plot.pdf')
data['IDE.NE'].plot.bar().figure.savefig('3NE_Bplot.pdf')
x=list(data['IDE.NE'].value_counts().index.values)
y=list(data['IDE.NE'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('3NE_plot_bar.pdf')
print('Number of elements plotted')

## 4 Charge IDE.NF
number_fragments=data['IDE.NF'].value_counts()
number_fragments.to_csv('number_fragments.csv')
data['IDE.NF'].plot.hist().clear()
data['IDE.NF'].plot.hist().figure.savefig('4NF_plot.pdf')
data['IDE.NF'].plot.bar().figure.savefig('4NF_Bplot.pdf')
print('number of fragments plotted')

## 5 Charge IDE.NI
number_isotopes=data['IDE.NI'].value_counts()
number_isotopes.to_csv('number_isotopes.csv')
data['IDE.NI'].plot.hist().clear()
data['IDE.NI'].plot.hist().figure.savefig('5NI_plot.pdf')
data['IDE.NI'].plot.bar().figure.savefig('5NI_Bplot.pdf')
print('number of isotopes plotted')

## 6 Charge IDE.INE
number_Elem_isotopes=data['IDE.INE'].value_counts()
number_Elem_isotopes.to_csv('number_Elem_isotopes.csv')
data['IDE.INE'].plot.hist().clear()
data['IDE.INE'].plot.hist().figure.savefig('6INE_plot.pdf')
data['IDE.INE'].plot.bar().figure.savefig('6INE_Bplot.pdf')
print('number of elements isotopes plotted')

## 7 Molecular weight IDE.MW
molecularW=data['IDE.MW'].value_counts()
molecularW.to_csv('7molecularW.csv')
bn=len(molecularW)
data['IDE.MW'].plot.hist(bins=bn).clear()
data['IDE.MW'].plot.hist(bins=bn).figure.savefig('7MW_plot.pdf')
data['IDE.MW'].plot.bar().figure.savefig('7MW_Bplot.pdf')
x=list(data['IDE.MW'].value_counts().index.values)
y=list(data['IDE.MW'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('7MW_plot_bar.pdf')
print('Molecular weight plotted')

## 8 Type of Substance IDE.STYPE
data['IDE.STYPE'].value_counts().plot.bar().clear()
data['IDE.STYPE'].value_counts().plot.bar().figure.savefig('8STYPE_plot.pdf')
type_of_data=data['IDE.STYPE'].value_counts()
type_of_data.to_csv('8types_of_reactios.csv')
print('type of reactions plotted')

## 9 Availability IDE.AVAIL
data['IDE.AVAIL'].value_counts().plot.bar().clear()
data['IDE.AVAIL'].value_counts().plot.bar().figure.savefig('9AVAIL_plot.pdf')
type_of_data=data['IDE.AVAIL'].value_counts()
type_of_data.to_csv('9Availability.csv')
print('Avail plotted')

## 10 Maximum publication year IDE.MAXPUB
max_pub_year=data['IDE.MAXPUB'].value_counts()
max_pub_year.to_csv('10max_pub_year.csv')
bn=len(max_pub_year)
data['IDE.MAXPUB'].plot.hist(bins=bn).clear()
data['IDE.MAXPUB'].plot.hist(bins=bn).figure.savefig('10MAXPUB_plot.pdf')
data['IDE.MAXPUB'].plot.bar().figure.savefig('10MAXPUB_Bplot.pdf')
x=list(data['IDE.MAXPUB'].value_counts().index.values)
y=list(data['IDE.MAXPUB'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('10MAXPUB_plot_bar.pdf')
print('max_pub_year plotted')

## 11 Number of references IDE.NUMREF
num_ref=data['IDE.NUMREF'].value_counts()
num_ref.to_csv('11num_ref.csv')
bn=len(num_ref)
data['IDE.NUMREF'].plot.hist(bins=bn).clear()
data['IDE.NUMREF'].plot.hist(bins=bn).figure.savefig('11NUMREF_plot.pdf')
data['IDE.NUMREF'].plot.bar().figure.savefig('11NUMREF_Bplot.pdf')
x=list(data['IDE.NUMREF'].value_counts().index.values)
y=list(data['IDE.NUMREF'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('11NUMREF_plot_bar.pdf')
print('num_ref plotted')

## 12 Markush Reference Count  IDE.MARKREF
data['IDE.MARKREF'].value_counts().plot.hist().clear()
data['IDE.MARKREF'].value_counts().plot.hist().figure.savefig('12MARKREF_plot.pdf')
data['IDE.MARKREF'].value_counts().plot.bar().figure.savefig('12MARKREF_Bplot.pdf')
type_of_data=data['IDE.MARKREF'].value_counts()
type_of_data.to_csv('12MARKREF.csv')
x=list(data['IDE.MARKREF'].value_counts().index.values)
y=list(data['IDE.MARKREF'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('12MARKREF_plot_bar.pdf')
print('mark ref plotted')

## 13 Full reaction count IDE.FULLRXNS
full_rxn=data['IDE.FULLRXNS'].value_counts()
num_ref.to_csv('13full_rxn.csv')
bn=len(full_rxn)
data['IDE.FULLRXNS'].plot.hist(bins=bn).clear()
data['IDE.FULLRXNS'].plot.hist(bins=bn).figure.savefig('13full_rxn_plot.pdf')
data['IDE.FULLRXNS'].plot.bar().figure.savefig('13full_rxn_Bplot.pdf')
x=list(data['IDE.FULLRXNS'].value_counts().index.values)
y=list(data['IDE.FULLRXNS'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('13full_rxn_plot_bar.pdf')
print('full_rxn plotted')

## 14 Markush Reference Count  IDE.HASBIO
data['IDE.HASBIO'].value_counts().plot.hist().clear()
data['IDE.HASBIO'].value_counts().plot.hist().figure.savefig('14HASBIO_plot.pdf')
data['IDE.HASBIO'].value_counts().plot.bar().figure.savefig('14HASBIO_Bplot.pdf')
type_of_data=data['IDE.HASBIO'].value_counts()
type_of_data.to_csv('14HASBIO.csv')
x=list(data['IDE.HASBIO'].value_counts().index.values)
y=list(data['IDE.HASBIO'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.savefig('14hasbio_plot_bar.pdf')
print('hasbio plotted')
