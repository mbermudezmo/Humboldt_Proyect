#! /bin/awk -f
# Extract number of single step reactions, both in academic journals and patents yearly from output of getRxnDet.awk.
# This script return a file with seven columns:
#	1. year
#	2. number of reactions published in patents
#	3. number of reactions published in articles
#	4. sum of 2 and 3
#	5. number of reactions details published in patents
#	6. number of reactions details published in articles
#	7. sum of 5 and 6
# All of this considering only single step reactions. This is because the multiple step reactions take into account the single steps and are counte double. 
# The file source is the Marisol/PREP/P_RXN/scr_21_Jul_22/Head_Unique_all_rxds.tsv which the column $22 is the RXD.STP, $42 CIT.PPY and $43 CIT.PY
function min(arr){
	if(arr[1]!=""){ # For a list of data non empty
		m=arr[1] # set the firts value
		for(i in arr){ # compares each value with the next one 
			if(arr[i]<m) m=arr[i] #and if this value is less than the before, replace with the new value
		}
		return m
	}
	else return 4000
}

BEGIN{
	FS="\t"; 
	OFS="\t"
	mppy=4000
	mpy=4000
}

{
split($1,id_rxd,":")
if(FNR==1)	id=id_rxd[1] #Initialization of id value

# We have RXID:RXD. Count only reactions on one side, and reactions+rxds in parallel
if($22==1){  # Count only single step
	# Get years
	split($42,ppy,":")
	split($43,py,":")
	if(id_rxd[1]!=id){	# New reaction scheme. 
		# Write years for previous RXID
	    if(mppy<mpy && mppy!=4000){
		ypp[mppy]+=1 # this is the counter. Each time that finds this date, increase its value		
	    }
	    else if(mpy!=4000){		yp[mpy]+=1}
		# Extract year from this rxid:rxd
		mppy=min(ppy)
		mpy=min(py)
		id=id_rxd[1]
	}
	else{	# If this is an additional rxd to the same reaction
		# Compare this entrie's years against previously collected
		currppy=min(ppy)
		currpy=min(py)
		if(currppy<mppy)	mppy=currppy
		if(currpy<mpy)		mpy=currpy
	}
	# Write rxn+rxd dates
	ppyrxd[min(ppy)]+=1
	pyrxd[min(py)]+=1
}
}

END{
	for(y=1771;y<=2022;y++){
		print y, ypp[y], yp[y], ypp[y]+yp[y], ppyrxd[y], pyrxd[y], ppyrxd[y]+pyrxd[y]
	}
}
	
