#! /bin/awk -f
# Extract number of single step reactions, both in academic journals and patents yearly from output of getRxnDet.awk.
# Fields:
# ID	RX.RXRN	RXD.SXRN	RXD.RGTXRN	RXD.CATXRN	RXD.SOLXRN	RXD.STP	CIT.PREPY	CIT.PPY	CIT.PY
#  1       2     3                4                 5              6               7         8           9      10
#RX.ID	RX.RXRN	RX.PXRN	RX.BLC	RX.NVAR	RX.BIN	RX.BFREQ	RX.BRANGE	RX.RANK	RX.MYD	RX.TNAME	RX.RAVAIL
# 1      2       3        4       5       6       7                 8            9         10      11             12
#RX.PAVAIL	RX.MAXPUB	RX.NUMREF	RX.MAXPMW	RX.ED	RX.UPD	RXD.L	RXD.SCO	RXD.STP	RXD.NYD	RXD.YDO	RXD.SNR
#  13              14               15             16             17        18   19     20        21     22        23    24
#RXD.RGTXRN	RXD.CATXRN	RXD.SOLXRN	RXD.RGTCAT	RXD.SPH	RXD.TIM	RXD.T	RXD.P	RXD.PH	RXD.COND	RXD.TYP
#   25            26             27              28             29       30     31       32      33          34           35
#RXD.NAME	RXD.DED RXD.TAG	CNR.CNR	CIT.PREPY	CIT.PPY	CIT.PY
#  36            37      38       39    40                 41   42

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

{#split($1,id_rxd,":")
#if(FNR==1)	id=$1
# We have RXID:RXD. Count only reactions on one side, and reactions+rxds in parallel
#if($21==1){  # Count only single step
	# Get years
if(!match($21,1)){
split($41,ppy,":")
split($42,py,":")
		# Write years for previous RXID
#if(mppy<mpy && mppy!=4000){ypp[mppy]+=1 # this is the counter. Each time that finds this date, increase its value		
#	    }
#else if(mpy!=4000){yp[mpy]+=1}
		# Extract year from this rxid:rxd
#mppy=min(ppy)
#mpy=min(py)
# Write rxn+rxd dates
ppyrxd[min(ppy)]+=1
pyrxd[min(py)]+=1
}
}

END{
	for(y=1771;y<=2022;y++){
	    print y, ppyrxd[y], pyrxd[y], ppyrxd[y]+pyrxd[y]
	}
}
	
