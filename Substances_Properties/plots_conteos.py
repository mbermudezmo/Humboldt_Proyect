#!/usr/bin/env python3   
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict
import ujson

#Charge
charge=pd.read_csv('number_of_properTotal.csv',sep=',',names=['Total number of properties','Frequency'])
charge.plot.scatter(x='Charge',y='Frequency',xlim=(-60,80),logy=True,logx=False,figsize=(15, 10),xticks=range(-60,80,5),grid=True)
charge.plot.scatter(x='Charge',y='Frequency',xlim=(-414,9999),logy=True,logx=False,figsize=(15, 10),xticks=range(-500,9999,500),grid=True)
charge.plot.scatter(x='Charge',y='Frequency',xlim=(-414,3000),logy=True,logx=False,figsize=(15, 10),xticks=range(-500,3000,250),grid=True)
