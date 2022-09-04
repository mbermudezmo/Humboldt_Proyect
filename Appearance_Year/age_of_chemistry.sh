#!/bin/bash

#year  reacciones_patente reacciones_journal  reacciones_interseccion	sustancias_reaccion	sustancias_propiedades_journal sustancias_propiedades_patentes sustancias_propiedades_interseccion

#Selecting the context

rxn=''
subs=''
join=''

while getopts 'rsj' flag; do
    case "${flag}" in
	r) A_rxn=1 ;;
	s) A_subs=1 ;;
	j) A_join=1 ;;
    esac
done

if [ -n "$A_subs" ]; then
    echo "reading substances"
#    ./SUBS_year_contextSUB.awk  ../PREP/P_SUB/scr_23_Aug_22/pruebita.tsv > output1.tsv
    ./SUBS_year_contextSUB.awk  ../PREP/P_SUB/scr_23_Aug_22/heads_unique_all_subds.tsv > output1.tsv
    #year  sustancias_propiedades_journal sustancias_propiedades_patentes sustancias_propiedades_interseccion
    echo "output 1 done"
fi

if [ -n "$A_rxn" ]; then
    echo "reading reactions"
    ./RXN_SS__SUBS_journal_patent_intersection_year_contextRXN.awk ../PREP/P_RXN/scr_28_Aug_22/heads_unique_all_rxds.tsv > output2.tsv
    #./RXN_SS__SUBS_journal_patent_intersection_year_contextRXN.awk ../PREP/P_RXN/scr_28_Aug_22/pruebis.tsv > output2.tsv
    echo "output 2 done"    
    ./SS_rxnsIDE_years.awk output2.tsv > output3.tsv
    ##year  substances_reaccion reaccione_patente reaccione_journal intersection
    echo "output 3 done"
fi

if [ -n "$A_join" ]; then
    echo "joining"
    echo "year  sustancias_propiedades_journal sustancias_propiedades_patentes sustancias_propiedades_interseccion  sustancias_reaccion  reacciones_patente   reacciones_journal    reacciones_interseccion" >> output4.tsv
    echo "output 4 done"
    paste <(cut  -f 1,2,3,4 output1.tsv) <(cut  -f 2,3,4,5 output3.tsv) > output5.tsv
    echo "output 5 done"
    cat output4.tsv output5.tsv > edades.tsv
    echo "final output  done"
    rm output*
fi
echo ":)"
