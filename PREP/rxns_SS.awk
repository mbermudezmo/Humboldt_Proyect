#!/usr/bin/awk -f
#The main idea of this code was proposed by Andres Camilo Marulanda Bran. The former code that he created and used, it is not useful when it is needed to use a bigger list of fields. In order to preprocess the raw data quickly, the algorithm changed. Now the idea is to detect the field and then evaluate if that field belongs to the list of fields that previosly has been selected. With this idea, each line is read only once time.      
#In this version, it was neccesary split the fields in two sets: the set of RX and the set of RXD. This due to the needed to consider the differentes RXD by RX.

BEGIN {
    a="RX.ID,RX.RXRN,RX.PXRN,CIT.PY"
    split(a,rxdets,",")
    gsub(",","\t",a)
    print a 
}

{regex="<.*\\..*>.*<\\/.*\\..*>"
    if (match($0,regex)) {
	pattern=gensub(/.*<\/(.*?)>.*/,"\\1","g",$0)#Detects fields
	if(match(a,pattern)){
	    rgx=".*<"pattern".*>(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
	    data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)	    
	}
    }
    if(match($0,"<RX>")){
	delete data
    }
    if(match($0,"<RXD>")){ # It is necessary indicate the end of the data for each reaction
	sub(":","",data["RX.ID"]) # Remove first ":"
	line=data["RX.ID"] ":" rxd_num
	for(i in rxdets){
	    field=rxdets[i]
#	    sub(":","",data[field]) # Remove first ":"
	    line=line "\t" data[field]
	}
    }
    if(match($0,"</RXD>")){
	print line
    }
}
