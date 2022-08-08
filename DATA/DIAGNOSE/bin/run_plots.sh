#!/bin/bash                                                                                                                           
# This scrip run each one of the verification files
# Count number of single step reactions for every year                                                                         
./1numRxnsTime.awk ../../../PREP/P_RXN/scr_21_Jul_22/unique_all_rxds.tsv > 1countRxnsSS.txt
echo 1
# Count number of substances in single step reactions for every year (separated by role in reaction)                           
./2numSubsTime.awk ../../../PREP/P_RXN/scr_21_Jul_22/unique_all_rxds.tsv > 2countSubsSS.txt
echo 2
# Compute density                                                                                                              
./3calcDensity.awk 1countRxnsSS.txt 2countSubsSS.txt > 3density.txt
echo 3
# Count frequency of number of references per reaction and reaction details.                                                   
./4numRefsFreq.awk ../../../PREP/P_RXN/scr_21_Jul_22/unique_all_rxds.tsv > 4countRefsFreqSS.txt
echo 4
# Count frequency of number of references and number of details per reaction.                                                  
./5numVarsRefs.awk ../../../PREP/P_RXN/scr_21_Jul_22/unique_all_rxds.tsv > 5countVarsRefsSS.txt
echo 5
# Compute frequency of number of references per RXID (integrate over number of variations)                                     
awk 'BEGIN{FS="\t";OFS="\t"}{f[$1]+=$3}END{for(i in f) print i,f[i]}' 5countVarsRefsSS.txt >  6numRefsRXID.txt
echo 6
# Compute frequency of number of variations per RXID (integrate over number of references)                                     
awk 'BEGIN{FS="\t";OFS="\t"}{f[$2]+=$3}END{for(i in f) print i,f[i]}' 5countVarsRefsSS.txt >  7numVariationsRXID.txt
echo 7
# Make plots for the above calculations                                                                                        
gnuplot MBMplotRxns.gpi
echo "Plots"

