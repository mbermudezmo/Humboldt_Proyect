#! /usr/bin/awk -f

# Extract relevant data from raw XML files for reactions, donwloaded from Reaxys,
# The script collects reactants, reagents, solvents, catalysts, and years of publication for every reaction:reaction detail pair

BEGIN{
	OFS="\t"
	a="RX.BLC,RX.NVAR,RX.BIN,RX.BFREQ,RX.BRANGE,RX.RANK,RX.MYD,RX.TNAME,RX.RAVAIL,RX.PAVAIL,RX.MAXPUB,RX.NUMREF,RX.MAXPMW,RX.ED,RX.UPD"
	b="RXD.L,RXD.SCO,RXD.STP,RXD.NYD,RXD.YDO,RXD.SNR,RXD.RGTXRN,RXD.CATXRN,RXD.SOLXRN,RXD.RGTCAT,RXD.SPH,RXD.TIM,RXD.T,RXD.P,RXD.PH,RXD.COND,RXD.TYP,RXD.NAME,RXD.DED,RXD.TAG,CNR.CNR"
	split(a,rx_dets,",")
	split(b,rxd_dets,",")
	# Header can be printed and then placed in some file. Just for reference
	gsub(",","\t",a)
	gsub(",","\t",b)
	print "ID\tRX.RXRN\t" a "\t" b "\tRX.PXRN"  # Header
}

{
if(match($0,/<reaction index/)){
	rxd_num=0 # Reaction detail number. For creating unique ID for each RXN,RXD pair
	rctn=""
	prds=""
	}

if(match($0,/<RX.ID.+>/)){
	# Extract RX ID
	rxid=gensub(/.*<RX.ID.+>(.+)<\/RX.ID>/, "\\1","g",$0)
	}

if(match($0,/<RX.RXRN>/)){ # Concatenate all reactants
	rctn=rctn ":" gensub(/.*<RX.RXRN>(.+)<\/RX.RXRN>/, "\\1","g",$0)
}

if(match($0,/<RX.PXRN>/)){ # Concatenate all products
	prds=prds ":" gensub(/.*<RX.PXRN>(.+)<\/RX.PXRN>/, "\\1","g",$0)
}

# Delete every previous reaction detail, whenever <RXD> is found.
if(match($0,/<\/reaction>/)){
        delete dataRX
#        rxd_num+=1
}
for(i in rx_dets){  # Collect data for every field
	field=rx_dets[i]
	if(match($0,"<" field ">")){
		rgx=".*<" field ">(.+)</" field ">"
		dataRX[field]=dataRX[field] ":" gensub(rgx, "\\1","g",$0)  # Concatenate with previous entries found for this reaction detail
	}
}

if(match($0,/<RXD>/)){
	delete data   
	rxd_num+=1
}

for(i in rxd_dets){  # Collect data for every field
	field=rxd_dets[i]
	if(match($0,"<" field ">")){
		rgx=".*<" field ">(.+)</" field ">"
		data[field]=data[field] ":" gensub(rgx, "\\1","g",$0)  # Concatenate with previous entries found for this reaction detail
	}
}
	
# Dump all the collected data into a single line
if(match($0,/<\/RXD>/)){
	sub(":","",rctn) # Remove first ":"
        line=rxid ":" rxd_num "\t" rctn
	for(i in rx_dets){
	    field=rx_dets[i]
#	    sub(":","",dataRX[field]) # Remove first ":" 
	    line=line "\t" dataRX[field]
	}
        # Add reagents, catalysts, etc...
	for(i in rxd_dets){ 
		field=rxd_dets[i]
		sub(":","",data[field]) # Remove first ":" 
		line=line "\t" data[field]
	}
	sub(":","",prds) # Remove first ":"
	print line, prds

}
# Done :)
}

