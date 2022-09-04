#! /bin/awk -f

### This script finds the first date of apparition of every substances reported in the substaces context.
# This information comes from Marisol/PREP/P_SUB/scr_23_Aug_22/heads_unique_all_subds.tsv
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

{
    split($140,py,":")#column CIT.PY publication year on journals
    mpy=min(py)
    lista[1]=mpy
    ypy[mpy]+=1

    split($141,ppy,":")#column CIT.PPY publication year on patents
    mppy=min(ppy)
    lista[2]=mppy
    yppy[mppy]+=1

    first=min(lista)
    conteoT[first]+=1 #select the early date between journal or patent
#print $1,mpy,mppy,first
}
END{
    for(y=1771;y<=2022;y++){
	print y, ypy[y],yppy[y],conteoT[y]
	#year   journal patente early_date
    }
}
	
