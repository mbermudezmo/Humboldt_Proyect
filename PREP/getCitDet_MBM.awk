#! /usr/bin/awk -f

# Extract relevant data from raw XML files for citations, donwloaded from Reaxys,


BEGIN{
	OFS="\t"
	a="<CNR.CNR>,<CNR.CED>,<CNR.CUPD>,<CIT.DT>,<CIT.AU>,<CIT.PA>,<CIT.ABPR>,<CIT.IMPACT>,<CIT.PNX>,<CIT.PREPY>,<CIT.PAGES>,<CIT.PUI>,<CIT.PCC>,<CIT.PN>,<CIT.PPY>,<CIT.PK>,<CIT.PLA>,<CIT.CO>,<CIT.JT>,<CIT.JTS>,<CIT.JTW>,<CIT.ISB>,<CIT.CC>,<CIT.LA>,<CIT.EDT>,<CIT.PUB>,<CIT.LO>,<CIT.VL>,<CIT.NB>,<CIT.PY>,<CIT.PAG>,<CIT.URES>,<CIT.DOI>,<CIT.ARTNO>,<CIT.ISSN>,<CIT.SCOPUS>,<CIT.CITBY>,<CIT.DOCQ>,<CIT.HASBIO>"
	split(a,citdets,",")
	# Header can be printed and then placed in some file. Just for reference
	gsub(",","\t",a)
	print "CIT.ID\tCNR.CNR\t" a   # Header
}

{
# if(match($0,/<citation index/)){
# 	cit_num=0 # Citation detail number. For creating unique ID for each citation
# 	}

if(match($0,/<CNR.CNR.+>/)){
	# Extract RX ID
	citid=gensub(/.*<CNR.CNR.+>(.+)<\/CNR.CNR>/, "\\1","g",$0)
	}

# Delete every previous reaction detail, whenever <RXD> is found.
if(match($0,/<CIT>/)){
	delete data   
#	cit_num+=1
}

for(i in citdets){  # Collect data for every field
	field=citdets[i]
	if(match($0,field)){
		rgx=".*"field"(.+)" 
		data[field]=data[field] ":" gensub(rgx, "\\1","g",$0)  # Concatenate with previous entries found for this reaction detail
	}
}

	
# Dump all the collected data into a single line
if(match($0,/<\/CIT>/)){
	line=citid 
	# Add reagents, catalysts, etc...
	for(i in citdets){ 
		field=citdets[i]
		sub(":","",data[field]) # Remove first ":" 
		sub("</(.*)>","",data[field]) # Remove the text between </ and >
		line=line "\t" data[field]
	}
	print line

}
# Done :)
}

