#! /bin/awk -f

### This script finds the date of publication for every substance in single step reactions as well as group all substances involved in reactions.
# Fields:Q
#3 4 5 6 7 30 36 38 40 42 
#RX.RXRN RX.PXRN RX.BLA RX.BLB RX.BLC RXD.YXRN RXD.SXRN RXD.RGTXRN RXD.CATXRN RXD.SOLXRN RXD.STP CIT.PREPY CIT.PPY CIT.PY
# ID 1 2	RX.RXRN 3	 RX.PXRN 4  RX.BLA 5 RX.BLB 6  RX.BLC 7 RX.YXRN 30 RXD.SXRN 36 RXD.RGTXRN 38  RXD.CATXRN 40	RXD.SOLXRN 42	RXD.STP 28	CIT.PREPY 57	CIT.PPY 58 	CIT.PY	59
# This script takes the substances reportes as substrate reagente, product, solvent, catalizer. 
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
    OFS="\t"#,5,6,7,30,36,38,40,42
    split("2,3",is,",")#the columns are RX.RXRN RX.PXRN RX.BLA RX.BLB RX.BLC RXD.YXRN RXD.SXRN RXD.RGTXRN RXD.CATXRN RXD.SOLXRN from scr_28_Aug
}

{id=$1
    if($21==1){#only single steps reaction 
	for(i in is){
	    if($is[i]!=""){
		sustancias[id]=sustancias[id]":"$is[i]
		gsub(/::/,":",sustancias[id])#Repace :: by : 
	    }
	}
	if($40!=""){
#	    paten[id]=paten[id]":"$40
	    union[id]=union[id]":"$40
	}
	if($41!=""){
#	    jour[id]=jour[id]":"$41
	    union[id]=union[id]":"$41
	}
#	gsub(/::/,":",jour[id])#Repace :: by :
#	gsub(/::/,":",paten[id])#Repace :: by :
	gsub(/::/,":",union[id])#Repace :: by :
    }
}
 END{
     for (i in sustancias){
#	 sub(":","",paten[i])
#	 sub(":","",jour[i])
	 sub(":","",union[i])
	 sub(":","",sustancias[i])	 
	 print i"\t"union[i]"\t"sustancias[i]#paten[i]"\t"jour[i]"\t"union[i]"\t"sustancias[i]
     }
 }
