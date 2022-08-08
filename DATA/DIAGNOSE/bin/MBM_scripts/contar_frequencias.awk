#! /bin/awk -f

BEGIN{
	FS="\t"; 
	OFS="\t"
}

{ for(i=1;i<=NF;i++){
	if($i==""){
	    cuentas[i]+=1
#	print $i #cuentas[i]
	}

    }
}
END{
    for(i=1;i<=NF;i++){
	print i "\t" cuentas[i]
    }
}
