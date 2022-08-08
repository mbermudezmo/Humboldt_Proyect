#! /bin/awk -f
function min(arr){
	if(arr[1]!=""){ # For a list of data non empty
		m=arr[1] # set the firts value
		for(i in arr){ # compares each value with the next one 
			if(arr[i]<m) m=arr[i] #and if this value is less than the before, replace with the new value
		}
		return m
	}
	else return 4000
}

BEGIN{
	FS="\t"; 
	OFS="\t"
	mppy=4000
	mpy=4000
}

{#if(!match($21,1)){
split($41,ppy,":")
split($42,py,":")
ppyrxd[min(ppy)]+=1
pyrxd[min(py)]+=1

}

END{
	for(y=1771;y<=2022;y++){
	    print y, ppyrxd[y], pyrxd[y], ppyrxd[y]+pyrxd[y]
	}
}
	
