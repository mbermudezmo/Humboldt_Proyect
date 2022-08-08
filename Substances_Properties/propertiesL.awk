#! /usr/bin/awk -f

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
