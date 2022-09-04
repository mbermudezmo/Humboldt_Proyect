#! /bin/awk -f

### This script finds the first date of apparition of every reaction reported in the reaction context without consider each reaction details, published on patents or journal. Also asign the first date or apparition of the substances envolved in reactions
# This information comes from Marisol/PREP/P_RXN/scr_28_Aug_22/Head_Unique_all_rxds.tsv
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
}

{id=$1
    #patentes
    split($2,ppy,":")
    mppy=min(ppy)
    yppy[mppy]+=1
    #journals
    split($3,py,":")
    mpy=min(py)
    ypy[mpy]+=1
    #union
    split($4,inter,":")
    minter=min(inter)
    yinter[minter]+=1
    #Age of substances
    delete subs
    split($5,subs,":") # Create arrays of substances for each of $3, $4, ...
    for(s in subs){	# each substance in reaction role $is[i]
	if(y[subs[s]]){#If an entry exists for this substance in this role i
	    if(minter<y[subs[s]]){
		y[subs[s]]=minter # Update only if date is older
	    }
	    # If already exists but date is larger, do nothing
	}
	else{
	    y[subs[s]]=minter#Assign a year to a substance with role i
	}
	g[subs[s]] # Add subs to list of substances
    }
}

END{
    for (i in g){
	year[y[i]]+=1
#	  print i "\t"y[i]# y[subs[i]]
    }
    for(a=1771;a<=2022;a++){
	print a, year[a],yppy[a],ypy[a],yinter[a]
	#year  substances patente journal intersection
    }
}
	
