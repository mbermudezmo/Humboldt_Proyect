#! /bin/awk -f

BEGIN{
	FS="\t"; 
	OFS="\t"
	a="10,14,15,16,18,19,20,21,25,26,27,28,29,30,31,32,47,54,55,56,57,58,59,60,83,144,535,545,553"
	n=split(a,colums,",")
}

{line=$1
    for(i=1;i<=n;i++){
	line=line "\t" $colums[i] 

    }
    	print line
}
# END{
#     for(i=1;i<=NF;i++){
 
 #    }

