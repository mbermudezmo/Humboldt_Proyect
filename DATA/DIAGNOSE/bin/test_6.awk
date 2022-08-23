#! /bin/awk -f

BEGIN{FS="\t";OFS="\t"}

{
    f[$1]+=$3
}

END{for(i in f) print i,f[i]}
