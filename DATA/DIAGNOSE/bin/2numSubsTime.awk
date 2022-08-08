#! /bin/awk -f

### This script finds the date of publication for every substance in single step reactions.
# Fields:
# ID	RX.RXRN	 RXD.RGTXRN	RXD.CATXRN	RXD.SOLXRN	RXD.STP	CIT.PREPY	CIT.PPY	CIT.PY	RX.PXRN
# This script takes the substances reportes as substrate reagente, product, solvent, catalizer. I forget RXD.SXRN.                
# This information comes from Marisol/PREP/P_RXN/scr_21_Jul_22/Head_Unique_all_rxds.tsv
function min(arr){
	if(arr[1]!=""){
		m=arr[1]
		for(i in arr){
			if(arr[i]<m) m=arr[i]
		}
		return m
	}
	else return 4000
}

BEGIN{
	FS="\t"; 
	OFS="\t"
	split("3,4,26,27,28",is,",")#the columns are:RXRN,PXRN,RGTXRN,CATRXN,SOLXRN from the file Head_Unique_all_rxds.tsv
}

{
if($22==1){ #RXD.STP column
# Obtain dates. Work only with academic year (py) as ppy has problems.
split($43,py,":")#column
mpy=min(py)
## Extract all substances in line
# Substances are in $3, $4, $26, $27 $28
for(i in is){ # Columns where substances are
	delete subs
	split($is[i],subs,":") # Create arrays of substances for each of $3, $4, ...
	for(s in subs){	# each substance in reaction role $is[i]
		if(y[subs[s] ":" i]){	# If an entry exists for this substance in this role
			if(mpy<y[subs[s] ":" i])	y[subs[s] ":" i]=mpy # Update only if date is older
			# If already exists but date is larger, do nothing
		}
		else{
			y[subs[s] ":" i]=mpy
		}
		g[subs[s]] # Add subs to list of substances
	}
}
}
}

END{
# Loop through all substances checking what they've been reported as, and in what year
for(s in g){
	for(i=1;i<=5;i++)	arr[i]=y[s ":" i]
	# Find which of these is minimum
	m=4000
	am=1
	for(i in arr){
		if(arr[i] && arr[i]<m){	m=arr[i];	am=i	}
	}
	# Increase this year's count, for this role.
	c[m ":" am]+=1
	yrs[m]
}

print "#####\n"
for(yr in yrs){
	line=yr
	sum=0
	for(i=1;i<=5;i++){
		line=line "\t" c[yr ":" i]
		sum+=c[yr ":" i]
	}
	print line, sum
	# Fields:
	#	year	RX.RXRN	RXD.RGTXRN	RXD.CATXRN	RXD.SOLXRN	RX.PXRN	Sum
}
}
	
