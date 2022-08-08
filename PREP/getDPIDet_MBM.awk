#! /usr/bin/awk -f

# Extract relevant data from raw XML files for DPI, donwloaded from Reaxys,


BEGIN{
	OFS="\t"
	a="<DAT.ID>,<DAT.citation>,<DAT.CIT>,<DAT.CID>,<DAT.CTYPE>,<DAT.MRN>,<DAT.MNAME>,<DAT.MROUTE>,<DAT.MREGIM>,<DAT.MDOSE>,<DAT.CLPHASE>,<DAT.SRN>,<DAT.SNAME>,<DAT.SDOSE>,<DAT.MID>,<DAT.VTYPE>,<DAT.VLIMIT>,<DAT.AID>,<DAT.ANAME>,<DAT.AFTYPE>,<DAT.CATEG>,<DAT.MODEL>,<DAT.PATHO>,<DAT.ACTTRG>,<DAT.ADESC>,<DAT.EFFECT>,<DAT.BID>,<DAT.BCELL>,<DAT.BPART>,<DAT.BTISSUE>,<DAT.BSTATE>,<DAT.BSPECIE>,<DAT.TID>,<DAT.TNAME>,<DAT.TSUBUNIT>,<DAT.TSPECIE>,<DAT.TNATURE>,<DAT.TDETAILS>,<DAT.TKEY>,<DAT.TSKEY>,<DAT.TROLE>,<DAT.TTRANSFECT>,<DAT.ASPECIE>,<DAT.CTL>,<DAT.CFLAG>,<DAT.TEXT>,<DAT.EXACT>,<DAT.VALUE>,<DAT.DEV>,<DAT.UNIT>,<DAT.PAUREUS>,<DAT.PAUORIG>,<DAT.SIGNIF>,<DAT.PVALUE>,<DAT.MCOUNT>,<DAT.ED>,<DAT.BIND>,<DAT.PVD>,<DAT.UPD>,<DAT.SRC>"
	split(a,dpidets,",")
	
	# Header can be printed and then placed in some file. Just for reference
	gsub(",","\t",a)
	print "ID\tDAT.ID\t" a  # Header
}

{
if(match($0,/<dpitem index/)){
	dpi_num=0 # DPI detail number. 
	}

if(match($0,/<DAT.ID.+>/)){
	# Extract DAT ID
	dpiid=gensub(/.*<DAT.ID.+>(.+)<\/DAT.ID>/, "\\1","g",$0)
	}

# Delete every previous reaction detail, whenever <RXD> is found.
if(match($0,/<DAT>/)){
	delete data   
	dpi_num+=1
}

for(i in dpidets){  # Collect data for every field
	field=dpidets[i]
	if(match($0,field)){
		rgx=".*"field"(.+)" 
		data[field]=data[field] ":" gensub(rgx, "\\1","g",$0)  # Concatenate with previous entries found for this reaction detail
	}
}
	
# Dump all the collected data into a single line
if(match($0,/<\/DAT>/)){
	line=dpiid  ":" dpi_num 
	# Add reagents, catalysts, etc...
	for(i in dpidets){ 
		field=dpidets[i]
		sub(":","",data[field]) # Remove first ":" 
		sub("</(.*)>","",data[field]) # Remove the text between </ and >
		line=line "\t" data[field]
	}
	print line

}
# Done :)
}

