#!/usr/bin/env python3
# This code counts the number of properties reported by each substance. It is important consider the IDE.RX columns and, hence, we have to substact one of the final counting.
import pandas as pd
import numpy as np
import matplotlib

#Doing the preprocessing on Aug 19 2022, it is not necessary to extract the columns L
# path where is located the data, file with .L columns
#df=pd.read_csv('L_columns.tsv', sep='\t' , low_memory=False)

#This script uses directly the file on PREP/P_SUB/scr_19_agu_2022
#df=pd.read_csv('test23.tsv',sep='\t',low_memory=False)
df=pd.read_csv('/scr/k70san/eugenio/HOC/Marisol/PREP/P_SUB/scr_23_Aug_22/heads_unique_all_subds.tsv',sep='\t',low_memory=False)

#Tiene caracter ligante?
df['LIG_Cha']=str(df['LIGO.BASE'])+str(df['LIGO.FORM'])+str(df['LIGO.CNT'])+str(df['LIGM.BASE'])+str(df['LIGM.FORM'])+str(df['LIGM.CNT'])
#Tiene caracter alloy?
df['Alloy_Cha']=str(df['ALLOY.FORM'])+str(df['ALLOY.W'])+str(df['ALLOY.A'])+str(df['ALLOY.V'])+str(df['ALLOY.X'])
#Tiene caracter PEPTIDE?
df['Pep_Cha']=str(df['SEQ.PEPTIDE'])+str(df['SEQ.SEQUENCE'])+str(df['SEQ.SEQHASH'])

#Inserta la nueva columna en la posicion 4
df.insert(loc=16,column='PoLIG_Cha',value=df['LIG_Cha'])
df.insert(loc=17,column='PoAll_Cha',value=df['Alloy_Cha'])
df.insert(loc=18,column='PoPep_Cha',value=df['Pep_Cha'])

#Counting of all properties
print (df.columns[16:141])
conteo_Total=df.iloc[:,16:141].count(axis=1).value_counts()
print ("conteo total de propiedades")
print (conteo_Total)
conteo_Total.to_csv('number_of_properTotal.csv')

#Counting of chemical properties
print (df.columns[16:27])
conteo_Chem=df.iloc[:,16:27].count(axis=1).value_counts()
print ("counting chemical properties")
print (conteo_Chem)
conteo_Chem.to_csv('number_of_properChem.csv')

#Counting of physical properties
print (df.columns[27:117])
conteo_Phys=df.iloc[:,27:117].count(axis=1).value_counts()
print ("counting physical properties")
print (conteo_Phys)
conteo_Phys.to_csv('number_of_properPhys.csv')

#Counting of spectroscopy properties
print (df.columns[117:129])
conteo_Spec=df.iloc[:,117:129].count(axis=1).value_counts()
print ("counting spectroscopical properties")
print (conteo_Spec)
conteo_Spec.to_csv('number_of_properSpec.csv')

#Counting of Ecological and other  properties
print (df.columns[129:141])
conteo_Eco=df.iloc[:,129:141].count(axis=1).value_counts()
print ("counting Ecological and other properties")
print (conteo_Eco)
conteo_Eco.to_csv('number_of_properEco.csv')

#Frequency of number of properites reported
#conteo=df.counts(["IDE.XRN","IDE.MF"])

#print (min(conteo))
#print (max(conteo))

#df.count(axis=1).plot.hist(bins=110,log=True).figure.savefig('fig1.pdf')
