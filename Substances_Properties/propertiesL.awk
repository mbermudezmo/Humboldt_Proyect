#! /usr/bin/awk -f
#This script detect the position (column) the all fields with .L pattern. This script is run over the header file of the substances. The output is converted into a .sh script. The .sh script is named extract_columns.sh 
BEGIN{FS="\t"
}
{lista=""
    for (j=1;j<=678;j++){	
	if (match($j,/\w\.L$/)){ #Sometimes I think well :)
	    print j "\t" $j
	    lista = lista ","j
	}
    }
    print lista
    sub(",","",lista) # Remove first ":"
    print lista
#    split(lista,campos,",")
#    for (i in campos)

}
