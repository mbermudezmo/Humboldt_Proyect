#! /bin/awk -f

# Compute frequency plot of number of references per reaction detail.
# Fields:
# ID	RX.RXRN	RXD.SXRN	RXD.RGTXRN	RXD.CATXRN	RXD.SOLXRN	RXD.STP	CIT.PREPY	CIT.PPY	CIT.PY	RX.PXRN

BEGIN{
	FS="\t"; 
	OFS="\t"
}

{
# Compute number of references as total number of entries in CIT.PPY and CIT.PY together.

if($22==1){  # Count only single step reactions
	n=split($42,ppy,":") + split($43,py,":")	# Total number of references for this rxn detail

	if(!idlist[id]){	# Check if this ID has been counted before
		f[n]+=1	# If not counted before, count in frequency
		idlist[id]	# Add id to list
	}
}
}

END{
for(i in f)	print i,f[i]
}
	
