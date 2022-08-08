#!/bin/bash

###############
## This code executes all steps for download of raw data from Reaxys, to produce of usable csv files.
###############

pre_rxn=''
pre_sub=''
pre_cit=''
pre_dpi=''
date=$(date +%d_%b_%y)	# Store date as a variable

print_usage() {
  printf "\n\nUsage %s:\n\n" $0 
  echo "	[-r] Preprocess downloaded Reaction data"
  echo "	[-s] Preprocess downloaded Substance data"
  echo "	[-c] Preprocess downloaded Citation data"
  echo "	[-b] Preprocess downloaded DPI data"  
}

# Parse arguments
while getopts 'rscb' flag; do
  case "${flag}" in
    r) preproc_rxn=1 ;;
    s) preproc_sub=1 ;;
    c) preproc_cit=1 ;;
    b) preproc_dpi=1 ;;
    ?) print_usage
       exit 1 ;;
  esac
done


## Run preprocessing and routinary results on these data

# Extract rxn ID, reactants, reagents, etc..., dates. from rxn data
if [ -n "$preproc_rxn" ]; then
# Run getRxnDet.awk in parallel for all files in RXNs/p*
	mkdir "PREP/P_RXN/scr_$date"
	for i in $(seq 1 20) # Iterate over directories (and parallel process each) so that argument list for parallel is short enough. The 20 comes from the number of folders selected in the download.
	do
		d=$(echo $i-1 | bc -l)	# compute $i - 1
		parallel -j20 "PREP/getRxnDet_MBM_v3.awk {} >> PREP/scr_$date/rxds{%}.tsv" ::: $(ls DATA/RXN/p$d/n*xml)
	done

	# Concatenate results of previous script
	cat PREP/P_RXN/scr_$date/* > PREP/P_RXN/scr_$date/all_rxds.tsv

	# Extract date from RXN for each substance in SS reactions (from file all_rxds.tsv)
#	./PREP/getSubsDates.awk PREP/scr_$date/all_rxds.tsv > PREP/Data/subs_dates.tsv
fi

# Extract rxn ID, reactants, reagents, etc..., dates. from rxn data
if [ -n "$preproc_sub" ]; then
	mkdir "PREP/P_SUB/scr_$date"
	for i in $(seq 1 20) # Iterate over directories (and parallel process each) so that argument list for parallel is short enough
	do
	    echo $i
	    d=$(echo $i-1 | bc -l)	# compute $i - 1
	    parallel -j20 "PREP/getSubDet_MBM_v2.awk {} >> PREP/P_SUB/scr_$date/subds{%}.tsv" ::: $(ls DATA/SUB/p$d/n*xml)
	done
	# Concatenate results of previous script
	cat PREP/P_SUB/scr_$date/* > PREP/P_SUB/scr_$date/all_subds.tsv
	awk '!x[$0]++' PREP/P_SUB/scr_$date/all_subds.tsv > PREP/P_SUB/scr_$date/unique_all_subds.tsv
	cat PREP/P_SUB/head_subs.tsv PREP/P_SUB/scr_$date/unique_all_subds.tsv > PREP/P_SUB/scr_$date/heads_unique_all_subds.tsv
fi

### Produce some routinary plots (sanity check)
if [ -n "$describe" ]; then
	diag_bin="DATA/DIAGNOSE/bin"		# Dir with code to produce diagnostic results
	diag_results="DATA/DIAGNOSE/Results"	# Dir to dump diagnostic results
	
	# Count number of single step reactions for every year
	./$diag_bin/numRxnsTime.awk PREP/scr_$date/all_rxds.tsv > $diag_results/countRxnsSS_$date.txt
	# Count number of substances in single step reactions for every year (separated by role in reaction)
	./$diag_bin/numSubsTime.awk PREP/scr_$date/all_rxds.tsv > $diag_results/countSubsSS_$date.txt
	# Compute density 
	./$diag_bin/calcDensity.awk $diag_results/countRxnsSS_$date.txt $diag_results/countSubsSS_$date.txt > $diag_results/density_$date.txt
	# Count frequency of number of references per reaction and reaction details.
	./$diag_bin/numRefsFreq.awk PREP/scr_$date/all_rxds.tsv > $diag_results/countRefsFreqSS_$date.txt
	# Count frequency of number of references and number of details per reaction.
	./$diag_bin/numVarsRefs.awk PREP/scr_$date/all_rxds.tsv > $diag_results/countVarsRefsSS_$date.txt
	# Compute frequency of number of references per RXID (integrate over number of variations)
	awk 'BEGIN{FS="\t";OFS="\t"}{f[$1]+=$3}END{for(i in f) print i,f[i]}' $diag_results/countVarsRefsSS_$date.txt > $diag_results/numRefsRXID_$date.txt
	# Compute frequency of number of variations per RXID (integrate over number of references)
	awk 'BEGIN{FS="\t";OFS="\t"}{f[$2]+=$3}END{for(i in f) print i,f[i]}' $diag_results/countVarsRefsSS_$date.txt > $diag_results/numVariationsRXID_$date.txt
	
	# Make plots for the above calculations
	gnuplot -e "date='$date'" "$diag_bin/plotRxns.gpi" > _gnuplot_
	rm _gnuplot_
fi 


##########
### Extracting data for PeriodSys project
##########

if [ -n "$preproc_PS" ]; then 
	# Extract MFs from substance data, and merge with Dates found above
	# This time, run parallel on the directories, as otherwise we'd have to load the dates file for every small file.
	parallel "./PREP/getMFs.awk PREP/Data/subs_dates.tsv DATA/SUB/{}/* > PREP/scr_$date/id_mf_py{%}.tsv" ::: $(ls DATA/SUB/ -l | grep "^d" | awk '{print $NF}')
	
	# Concatenate all these results
	cat PREP/scr_$date/id_mf_py* > PREP/scr_$date/all_id_mf_py.tsv
	
	# Further process this data to produce final usable file for project
	./PREP/cleanMFs_final.awk PREP/scr_$date/all_id_mf_py.tsv > PREP/Data/MFs_ids_year.tsv
fi

if [ -n "$run_PS" ]; then
	# Execute extraction of similarities for periodSys project
	cd periodSys
	./run_pipe.sh -RSPH
	
	######################
	## To run everything for a custom CS. e.g. CS of only organic substances, etc. Use pip_customCS.sh
	## First argument is datafile (already formated with Perl script)
	## Second argument is output dir. Here, a whole file system will be created to host results, scr, etc.
	######################

	#./run_pipe.sh -pi SplitOrgInorg/org_subs.tsv -o SplitOrgInorg/RunOrg -RSPH
fi



##########
### Extracting data for reaction_template project
##########

#./PREP/getSetsRxn.awk PREP/scr_$date/all_rxds.tsv > PREP/Data/reaction_sets.tsv

