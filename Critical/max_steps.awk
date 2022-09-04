#! /bin/awk -f

### This script finds the first date of apparition of every substances reported in the substaces context.
# This information comes from Marisol/PREP/P_SUB/scr_23_Aug_22/heads_unique_all_subds.tsv

BEGIN{
    FS="\t"; 
    OFS="\t"
    a=0 #It is necessary set a variable as number, because AWK doesnt set the type of variable in a good way
}

{
    # if(FNR==1){
    #max=1
#    print max
    # }
    #dom=$3
    if($3>=0+a){#with this we force to the value to be a number
	a=$3
    }

}
 END{
    print a
 }
	
