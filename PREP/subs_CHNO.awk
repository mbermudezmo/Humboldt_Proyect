#! /usr/bin/awk -f

# This script is based on the idea of Andres Camilo Marulanda Bran on July 14 2022.
# Extract relevant data from raw XML files for reactions, donwloaded from Reaxys,
# The script collects reactants, reagents, solvents, catalysts, and years of publication for every reaction:reaction detail pair

BEGIN {
    a="IDE.XRN,IDE.MF,IDE.MAXPUB,CIT.PY,CIT.PREPY"
    split(a,rxdets,",")
    gsub(",","\t",a)
#    print a
}

{regx="<.*\\..*>.*<\\/.*\\..*>"
    if (match($0,regex) && !match($0,"response")) { 
	pattern=gensub(/.*<\/(.*?)>.*/,"\\1","g",$0)#Detects fields
	if(match(a,pattern)){
    		if(pattern==rxdets[1]){
		    rgx=".*<"pattern".*>(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
		    data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)
	    }
		if(pattern!=rxdets[1]){
		    rgx=".*<"pattern">(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
		    data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)
	    }

	}
    }
    if(match($0,"</substance>")){ # It is necessary indicate the end of the data for each substance
    	line=""
	for(i in rxdets){
		field=rxdets[i]
		sub(":","",data[field]) # Remove first ":"
		line=line "\t" data[field]		
	    }
	sub("\t","",line)#Remove the first "\t"
      	print line
	delete data # The list have been cleaned
    }
}



