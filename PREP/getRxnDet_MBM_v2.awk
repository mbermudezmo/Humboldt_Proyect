#!/usr/bin/awk -f
#The main idea of this code was proposed by Andres Camilo Marulanda Bran. The former code that he created and used, it is not useful when it is needed to use a bigger list of fields. In order to preprocess the raw data quickly, the algorithm changed. Now the idea is to detect the field and then evaluate if that field belongs to the list of fields that previosly has been selected. With this idea, each line is read only once time.      

BEGIN {
    a="RX.ID,RX.RXRN,RX.PXRN,RX.BLC,RX.NVAR,RX.BIN,RX.BFREQ,RX.BRANGE,RX.RANK,RX.MYD,RX.TNAME,RX.RAVAIL,RX.PAVAIL,RX.MAXPUB,RX.NUMREF,RX.MAXPMW,RX.ED,RX.UPD,RXD.L,RXD.SCO,RXD.STP,RXD.NYD,RXD.YDO,RXD.SNR,RXD.RGTXRN,RXD.CATXRN,RXD.SOLXRN,RXD.RGTCAT,RXD.SPH,RXD.TIM,RXD.T,RXD.P,RXD.PH,RXD.COND,RXD.TYP,RXD.NAME,RXD.DED,RXD.TAG,CNR.CNR,CIT.PREPY,CIT.PPY,CIT.PY"
    split(a,rxdets,",")
    gsub(",","\t",a)
    print a
}

{regx="<.*\\..*>.*<\\/.*\\..*>"
    if (match($0,regex) && !match($0,"response")) { 
	pattern=gensub(/.*<\/(.*?)>.*/,"\\1","g",$0)#Detects fields
	if(match(a,pattern)){
	        rgx=".*<"pattern".*>(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
		data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)
	}
    }
    if(match($0,"</reaction>")){ # It is necessary indicate the end of the data for each reaction
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
