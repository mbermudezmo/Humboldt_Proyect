#!/usr/bin/env python3
#The strategy follows as: for each one of the 30 columns we will plot the according interested information.

#To do the tests it is convenient work with few data.
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#data=pd.read_csv('complete_columns_100.tsv', sep='\t',skiprows=[1])
#data=pd.read_csv('30col.tsv', sep='\t',skiprows=[1])
data=pd.read_csv('/scr/k70san/eugenio/HOC/Marisol/DATA/DIAGNOSE/bin/Datos/unique_useful_data.tsv', sep='\t',skiprows=[1],low_memory=False)
#headers=df.columns
print('data on')

# ## 1 Charge IDE.CHA 
# charge_of_data=data['IDE.CHA'].value_counts()
# charge_of_data.to_csv('1charge_of_substances.csv')
# #plt.title("Substances' charge histogram")
# plt.xlabel("Charge")
# data['IDE.CHA'].plot.hist().figure.savefig('1CHA_plot.pdf') #Preferible
# data['IDE.CHA'].plot.hist().clear() #Always is necessary clear
# print('1charge plotted')

# ##2 Number of atoms IDE.NA
# number_atoms=data['IDE.NA'].value_counts()
# number_atoms.to_csv('2number_atoms.csv')
# bn=len(number_atoms)
# plt.xlabel("Number of atoms per substance")
# data['IDE.NA'].plot.hist(bins=bn).figure.savefig('2CHA_plotH.pdf') #Preferible
# data['IDE.NA'].plot.hist().clear() #Always is necessary clear
# x=list(data['IDE.NA'].value_counts().index.values)
# y=list(data['IDE.NA'].value_counts())
# lista=list(zip(x,y))
# x1, y1 = zip(*lista)
# plt.scatter(*zip(*lista))
# plt.xlabel("Number of atoms per substance")
# plt.savefig('2NA_plot_bar.pdf') #preferible
# plt.clf()
# print('2Number of atoms plotted')

# #3 Number of elements IDE.NE
# number_elements=data['IDE.NE'].value_counts()
# number_elements.to_csv('3number_elements.csv')
# bn=len(number_elements)
# plt.xlabel("Number of elements per substance")
# data['IDE.NE'].plot.hist(bins=bn).figure.savefig('3NE_plotH.pdf') #Preferible
# data['IDE.NE'].plot.hist().clear() #Always is necessary clear
# x=list(data['IDE.NE'].value_counts().index.values)
# y=list(data['IDE.NE'].value_counts())
# lista=list(zip(x,y))
# x1, y1 = zip(*lista)
# plt.bar(*zip(*lista))
# #plt.title("Number of elements per substance histogram")
# plt.xlabel("Number of elements per substance")
# plt.savefig('3NE_plot_bar.pdf')
# plt.clf()
# print('3Number of elements plotted')

# ## 4 Charge IDE.NF
# number_fragments=data['IDE.NF'].value_counts()
# number_fragments.to_csv('4number_fragments.csv')
# #plt.title("Number of fragments per substance histogram")
# plt.xlabel("Number of fragments per substance")
# data['IDE.NF'].plot.hist().figure.savefig('4NF_plot.pdf')
# data['IDE.NF'].plot.hist().clear()
# print('4number of fragments plotted')

# ## 5 Charge IDE.NI
# number_isotopes=data['IDE.NI'].value_counts()
# number_isotopes.to_csv('5number_isotopes.csv')
# #plt.title("Number of elements per substance histogram")
# plt.xlabel("Number of elements per substance")
# data['IDE.NI'].plot.hist().figure.savefig('5NI_plot.pdf')
# data['IDE.NI'].plot.hist().clear()
# print('5number of isotopes plotted')

# ## 6 Charge IDE.INE
# number_Elem_isotopes=data['IDE.INE'].value_counts()
# number_Elem_isotopes.to_csv('6number_Elem_isotopes.csv')
# bn=len(number_Elem_isotopes)
# plt.xlabel("Number of elements with isotopes per substance")
# data['IDE.INE'].plot.hist(bins=bn).figure.savefig('6INE_plotH.pdf') #Preferible
# data['IDE.INE'].plot.hist().clear()
# x=list(data['IDE.INE'].value_counts().index.values)
# y=list(data['IDE.INE'].value_counts())
# lista=list(zip(x,y))
# x1, y1 = zip(*lista)
# plt.bar(*zip(*lista))
# #plt.title("Number of elements with isotopes per substance histogram")
# plt.xlabel("Number of elements with isotopes per substance")
# plt.savefig('6INE_plot_bar.pdf')
# plt.clf()
# print('6number of elements isotopes plotted')

# ## 7 Molecular weight IDE.MW
# molecularW=data['IDE.MW'].value_counts()
# molecularW.to_csv('7molecularW.csv')
# bn=len(molecularW)
# plt.xlabel("Molecular weight per substance")
# data['IDE.MW'].plot.hist(bins=bn).figure.savefig('7MW_plot.pdf')
# data['IDE.MW'].plot.hist().clear()
# plt.xlabel("Molecular weight per substance")
# data['IDE.MW'].plot.hist(bins=bn, rwidth=0.5).figure.savefig('7MW_plot_1.pdf')
# data['IDE.MW'].plot.hist().clear()
# print('7Molecular weight plotted')

# ## 8 Type of Substance IDE.STYPE
# plt.ylabel("Type of substance")
# data['IDE.STYPE'].value_counts().plot.barh().figure.savefig('8STYPE_plot.pdf')
# data['IDE.STYPE'].value_counts().plot.barh().clear()
# type_of_data=data['IDE.STYPE'].value_counts()
# type_of_data.to_csv('8types_of_reactios.csv')
# print('8type of reactions plotted')

## 9 Availability IDE.AVAIL
plt.xlabel("Availability?")
data['IDE.AVAIL'].value_counts().plot.bar().figure.savefig('9AVAIL_plot.pdf')
data['IDE.AVAIL'].value_counts().plot.bar().clear()
type_of_data=data['IDE.AVAIL'].value_counts()
type_of_data.to_csv('9Availability.csv')
print('9Avail plotted')

## 10 Maximum publication year IDE.MAXPUB
max_pub_year=data['IDE.MAXPUB'].value_counts()
max_pub_year.to_csv('10max_pub_year.csv')
bn=len(max_pub_year)
plt.xlabel("Maximum publication year")
data['IDE.MAXPUB'].plot.hist(bins=bn, rwidth=0.5).figure.savefig('10MAXPUB_plot.pdf')
data['IDE.MAXPUB'].plot.hist(bins=bn).clear()
print('10max_pub_year plotted')

## 11 Number of references IDE.NUMREF
num_ref=data['IDE.NUMREF'].value_counts()
num_ref.to_csv('11num_ref.csv')
x=list(data['IDE.NUMREF'].value_counts().index.values)
y=list(data['IDE.NUMREF'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.xlabel("Number of references")
plt.savefig('11NUMREF_plot_bar.pdf')
plt.clf()
print('11num_ref plotted')

## 12 Markush Reference Count  IDE.MARKREF
plt.xlabel("Markush Reference Count")
data['IDE.MARKREF'].value_counts().plot.bar().figure.savefig('12MARKREF_Bplot.pdf')
data['IDE.MARKREF'].value_counts().plot.bar().clear()
type_of_data=data['IDE.MARKREF'].value_counts()
type_of_data.to_csv('12MARKREF.csv')
print('12mark ref plotted')

## 13 Full reaction count IDE.FULLRXNS
full_rxn=data['IDE.FULLRXNS'].value_counts()
num_ref.to_csv('13full_rxn.csv')
x=list(data['IDE.FULLRXNS'].value_counts().index.values)
y=list(data['IDE.FULLRXNS'].value_counts())
lista=list(zip(x,y))
x1, y1 = zip(*lista)
plt.bar(*zip(*lista))
plt.xlabel("Full reaction count")
plt.savefig('13full_rxn_plot_bar.pdf')
plt.clf()
print('13full_rxn plotted')

## 14 Bioactivity presence  IDE.HASBIO
plt.xlabel("Bioactivity presence")
data['IDE.HASBIO'].value_counts().plot.bar().figure.savefig('14HASBIO_Bplot.pdf')
data['IDE.HASBIO'].value_counts().plot.bar().clear()
type_of_data=data['IDE.HASBIO'].value_counts()
type_of_data.to_csv('14HASBIO.csv')
print('14hasbio plotted')
