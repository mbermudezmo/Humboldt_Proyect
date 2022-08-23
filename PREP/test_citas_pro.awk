#! /usr/bin/awk -f

# This script is based on the idea of Andres Camilo Marulanda Bran on July 14 2022.
# Extract relevant data from raw XML files for reactions, donwloaded from Reaxys,
# The script collects reactants, reagents, solvents, catalysts, and years of publication for every reaction:reaction detail pair
#
BEGIN {
    a="IDE.XRN,IDE.MF,LIGO.BASE,LIGM.BASE,CALC.LOGP,CALC.HDONOR,CALC.HACCOR,CALC.ROTBND,CALC.TPSA,CALC.LIPINSKI,CALC.VEBER,CAT.L,MP.L,BP.L,SP.L,RI.L,DEN.L,CNF.L,IDA.LEM.L,ELP.L,DFM.L,EBC.L,EDIS.L,IP.L,CIP.L,CPD.L,CRYPH.L,CSYS.L,DP.L,TP.L,CPTP.L,CSYS.L,CSG.L,LIQPH.L,LPTP.L,CRT.L,CRP.L,CRD.L,CRV.L,VP.L,GP.L,MEC.L,COMP.L,SOUND.L,ST.L,DV.L,KV.L,BV.L,SDIF.L,CHROMAT.L,TD.L,TEXP.L,HCOM.L,HFOR.L,HHDG.L,HFUS.L,HVAP.L,HSP.L,HPTP.L,CP.L,CP0.L,CV.L,OTHE.L,OPT.L,ORP.L,MUT.L,CDIC.L,ORD.L,MSUS.L,MAG.L,SDIC.L,DIC.L,ELE.L,ELCB.L,DE.L,IEP.L,POT.L,ELYC.L,ELCH.L,XS.L,FLAP.L,AUTI.L,EXPL.L,SLB.L,SLBP.L,SOLM.L,CMC.L,HEN.L,POW.L,LVSM.L,AZE.L,CPEM.L,LLSM.L,LSSM.L,MECM.L,TRAM.L,ENEM.L,EDM.L,ODM.L,BSPM.L,ADSM.L,ASSM.L,NMR.L,IR.L,MS.L,UV.L,ESR.L,NQR.L,ROT.L,RAMAN.L,LUM.L,FLU.L,PHO.L,OSM.L,ECA.L,ECC.L,ECTD.L,BIO.L,BIOD.L,ECDH.L,ECDP.L,ECS.L,EOD.L,USE.L,INP.L,QUAN.L,CNR.CNR,CIT.PY,CIT.PPY,CIT.PREPY"
    split(a,rxdets,",")
    gsub(",","\t",a)
    print a
}

{regx="<.*\\..*>.*<\\/.*\\..*>"
    if (match($0,regex) && !match($0,"response")) { 
	pattern=gensub(/.*<\/(.*?)>.*/,"\\1","g",$0)#Detects fields
	if(match(a,pattern)){
    		if(pattern==rxdets[1]){
		    rgx=".*<"pattern".*>(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
		    data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)
	    }
		if(pattern!=rxdets[1]){
		    rgx=".*<"pattern">(.+)</"pattern">"#If the field belongs to the list, it value it is storaged
		    data[pattern]=data[pattern] ":" gensub(rgx,"\\1","g",$0)
	    }

	}
    }
    if(match($0,"</substance>")){ # It is necessary indicate the end of the data for each substance
    	line=""
	for(i in rxdets){
		field=rxdets[i]
		sub(":","",data[field]) # Remove first ":"
		line=line "\t" data[field]		
	    }
	sub("\t","",line)#Remove the first "\t"
      	print line
	delete data # The list have been cleaned
    }
}



