#! /usr/bin/awk -f

# This script is based on the idea of Andres Camilo Marulanda Bran on July 14 2022.
# Extract relevant data from raw XML files for reactions, donwloaded from Reaxys,
# The script collects reactants, reagents, solvents, catalysts, and years of publication for every reaction:reaction detail pair

BEGIN {
    a="IDE.XRN,IDE.MF,IDE.CHA,IDE.NA,IDE.NE,IDE.NF,IDE.NC,IDE.NI,IDE.INE,IDE.MW,IDE.STYPE,IDE.CCXRN,IDE.AVAIL,IDE.MAXPUB,IDE.NUMREF,IDE.MARKREF,IDE.FULLRXNS,IDE.HASBIO,IDE.ED,IDE.UPD,LIGO.BASE,LIGO.FORM,LIGO.CNT,LIGM.BASE,LIGM.FORM,LIGM.CNT,ALLOY.FORM,ALLOY.W,ALLOY.A,ALLOY.V,ALLOY.X,PSD.L,PSD.PRC,PSD.MARPRN,PSD.ED,SEQ.PEPTIDE,SEQ.SEQUENCE,SEQ.SEQHASH,CALC.LOGP,CALC.HDONOR,CALC.HACCOR,CALC.ROTBND,CALC.TPSA,CALC.LIPINSKI,CALC.VEBER,CAT.L,CAT.CHAR,CAT.SPEC,CAT.CLASS,CAT.REA,CAT.CCXRN,CAT.CCN,CAT.ED,CDER.L,CDER.XRN,CDER.CDER,CDER.MP,CDER.ED,PUR.L,PUR.PUR,PUR.ED,MP.L,MP.MP,MP.SOL,MP.CSOL,MP.AMNT,MP.ED,BP.L,BP.BP,BP.P,BP.ED,SP.L,SP.SP,SP.P,SP.ED,RI.L,RI.RI,RI.W,RI.T,RI.ED,DEN.L,DEN.DEN,DEN.RT,DEN.T,DEN.TYP,DEN.ITYP,DEN.ED,CNF.L,CNF.OBJ,CNF.ED,IDA.L,IDA.KW,IDA.ED,EM.L,EM.KW,EM.EM,EM.T,EM.MET,EM.SOL,EM.ED,ELP.L,ELP.KW,ELP.ED,DFM.L,DFM.KW,DFM.ED,EBC.L,EBC.EBC,EBC.TYP,EBC.SOL,EBC.ED,EDIS.L,EDIS.EDIS,EDIS.TYP,EDIS.ED,IP.L,IP.MET,IP.ED,IP.IP,CIP.L,CIP.KW,CIP.ED,CPD.L,CPD.CPD,CPD.PGROUP,CPD.ED,CRYPH.L,CRYPH.KW,CRYPH.T,CRYPH.ED,CSYS.CSYS,DP.L,DP.SOL,DP.CRSOL,DP.SOLM,DP.ED,DP.DP,TP.L,TP.TP,TP.ED,CPTP.L,CPTP.CPTP,CPTP.CM,CPTP.ED,CSYS.L,CSYS.ED,CSG.L,CSG.ED,CSG.CSG,LIQPH.L,LIQPH.KW,LIQPH.ED,LPTP.L,LPTP.LPTP,LPTP.CM,LPTP.ED,CRT.L,CRT.CRT,CRT.ED,CRP.L,CRP.CRP,CRP.ED,CRD.L,CRD.CRD,CRD.ED,CRV.L,CRV.CRV,CRV.ED,VP.L,VP.VP,VP.T,VP.ED,GP.L,GP.KW,GP.ED,MEC.L,MEC.KW,MEC.ED,COMP.L,COMP.KW,COMP.ED,SOUND.L,SOUND.KW,SOUND.ED,ST.L,ST.ST,ST.T,ST.ED,DV.L,DV.MEA,DV.DV,DV.T,DV.ED,KV.L,KV.MEA,KV.KV,KV.T,KV.ED,BV.L,BV.BV,BV.T,BV.ED,SDIF.L,SDIF.SDIF,SDIF.T,SDIF.ED,CHROMAT.L,CHROMAT.CHROMAT,CHROMAT.CHROMATSTRING,CHROMAT.ED,TD.L,TD.KW,TD.ED,TEXP.L,TEXP.VAL,TEXP.LEC,TEXP.T,TEXP.ED,HCOM.L,HCOM.HCOM,HCOM.T,HCOM.P,HCOM.ED,HFOR.L,HFOR.HFOR,HFOR.T,HFOR.P,HFOR.ED,HHDG.L,HHDG.HHDG,HHDG.XRN,HHDG.CN,HHDG.T,HHDG.ED,HFUS.L,HFUS.HFUS,HFUS.ED,HVAP.L,HVAP.HVAP,HVAP.T,HVAP.P,HVAP.ED,HSP.L,HSP.HSP,HSP.T,HSP.ED,HPTP.L,HPTP.HPTP,HPTP.ED,CP.L,CP.CP,CP.T,CP.ED,CP0.L,CP0.CP0,CP0.T,CP0.ED,CV.L,CV.CV,CV.T,CV.ED,OTHE.L,OTHE.KW,OTHE.ED,OPT.L,OPT.KW,OPT.ED,ORP.L,ORP.TYP,ORP.C,ORP.EE,ORP.LEN,ORP.SOL,ORP.ORP,ORP.W,ORP.T,ORP.ED,MUT.L,MUT.TYP,MUT.C,MUT.LEN,MUT.SOL,MUT.MUT,MUT.W,MUT.T,MUT.TIM,MUT.ED,CDIC.L,CDIC.SOL,CDIC.ED,ORD.L,ORD.SOL,ORD.ED,MSUS.L,MSUS.MSUS,MSUS.T,MSUS.ED,MAG.L,MAG.KW,MAG.T,MAG.MMOM,MAG.ED,SDIC.L,SDIC.SDIC,SDIC.T,SDIC.ED,DIC.L,DIC.DIC,DIC.F,DIC.T,DIC.ED,ELE.L,ELE.KW,ELE.ECVAL,ELE.T,ELE.CRIT,ELE.ED,ELCB.L,ELCB.KW,ELCB.ED,DE.L,DE.DE,DE.GRP,DE.T,DE.SOL,DE.MET,DE.TYP,DE.ED,IEP.L,IEP.IEP,IEP.SOL,IEP.ED,POT.L,POT.KW,POT.SOL,POT.PH,POT.T,POT.PXRN,POT.PRO,POT.ED,ELYC.L,ELYC.KW,ELYC.VAL,ELYC.AEVAL,ELYC.T,ELYC.SOL,ELYC.REM,ELYC.ED,ELCH.L,ELCH.DESCR,ELCH.POT,ELCH.KW,ELCH.ED,XS.L,XS.KW,XS.ED,FLAP.L,FLAP.FLAP,FLAP.TYP,FLAP.ED,AUTI.L,AUTI.T,AUTI.ED,EXPL.L,EXPL.LV,EXPL.ED,SLB.L,SLB.SLB,SLB.SAT,SLB.T,SLB.SOL,SLB.RAT,SLB.ED,SLBP.L,SLBP.SLBP,SLBP.T,SLBP.SOL,SLBP.RAT,SLBP.ED,SOLM.L,SOLM.KW,SOLM.PB,SOLM.PA,SOLM.SOL,SOLM.T,SOLM.P,SOLM.ED,CMC.L,CMC.CMC,CMC.T,CMC.SOL,CMC.ED,HEN.L,HEN.HEN,HEN.LOG,HEN.T,HEN.SOL,HEN.ED,POW.L,POW.POW,POW.LOG,POW.T,POW.PH,POW.ED,LVSM.L,LVSM.KW,LVSM.PB,LVSM.PA,LVSM.SOL,LVSM.T,LVSM.P,LVSM.ED,AZE.L,AZE.PB,AZE.PA,AZE.T,AZE.P,AZE.C,AZE.ED,CPEM.L,CPEM.KW,CPEM.PB,CPEM.PA,CPEM.SOL,CPEM.T,CPEM.P,CPEM.ED,LLSM.L,LLSM.KW,LLSM.PB,LLSM.PA,LLSM.SOL,LLSM.T,LLSM.P,LLSM.ED,LSSM.L,LSSM.KW,LSSM.PB,LSSM.PA,LSSM.SXRN,LSSM.SCOMP,LSSM.SOL,LSSM.T,LSSM.P,LSSM.ED,MECM.L,MECM.KW,MECM.PB,MECM.PA,MECM.SOL,MECM.T,MECM.P,MECM.ED,TRAM.L,TRAM.KW,TRAM.PB,TRAM.PA,TRAM.SOL,TRAM.T,TRAM.P,TRAM.ED,ENEM.L,ENEM.KW,ENEM.PB,ENEM.PA,ENEM.SOL,ENEM.T,ENEM.P,ENEM.ED,EDM.L,EDM.KW,EDM.PB,EDM.PA,EDM.SOL,EDM.T,EDM.P,EDM.ED,ODM.L,ODM.KW,ODM.PB,ODM.PA,ODM.SOL,ODM.T,ODM.P,ODM.ED,BSPM.L,BSPM.KW,BSPM.PB,BSPM.PA,BSPM.SOL,BSPM.T,BSPM.P,BSPM.ED,ADSM.L,ADSM.KW,ADSM.PB,ADSM.PA,ADSM.SOL,ADSM.T,ADSM.P,ADSM.ED,ASSM.L,ASSM.KW,ASSM.PB,ASSM.PA,ASSM.SOL,ASSM.T,ASSM.P,ASSM.ED,NMR.L,NMR.KW,NMR.NUC,NMR.NUI,NMR.SOL,NMR.T,NMR.F,NMR.SIG,NMR.SIGTYP,NMR.INT,NMR.ED,IR.L,IR.KW,IR.SOL,IR.T,IR.SIG,IR.INT,IR.ED,MS.L,MS.KW,MS.SIG,MS.INT,MS.ED,UV.L,UV.KW,UV.SOL,UV.AM,UV.EAC,UV.LOGE,UV.ED,ESR.L,ESR.KW,ESR.NUI,ESR.SOL,ESR.T,ESR.ED,NQR.L,NQR.KW,NQR.NUC,NQR.ED,ROT.L,ROT.KW,ROT.ED,RAMAN.L,RAMAN.KW,RAMAN.SOL,RAMAN.ED,LUM.L,LUM.KW,LUM.ED,FLU.L,FLU.KW,FLU.SOL,FLU.T,FLU.ED,PHO.L,PHO.KW,PHO.SOL,PHO.T,PHO.ED,OSM.L,OSM.KW,OSM.MOENUC,OSM.ED,ECA.L,ECA.HE,ECA.SO,ECA.ED,ECC.L,ECC.SP,ECC.ME,ECC.LO,ECC.CC,ECC.BC,ECC.MR,ECC.ED,ECTD.L,ECTD.TY,ECTD.ME,ECTD.RE,ECTD.MR,ECTD.ED,BIO.L,BIO.SP,BIO.ME,BIO.C,BIO.E,BIO.T,BIO.BC,BIO.LOG,BIO.A,BIO.AR,BIO.H,BIO.ER,BIO.MR,BIO.MAG,BIO.MON,BIO.ED,BIOD.L,BIOD.TY,BIOD.IN,BIOD.C,BIOD.D,BIOD.E,BIOD.T,BIOD.H,BIOD.XRN,BIOD.DP,BIOD.MR,BIOD.ED,ECDH.L,ECDH.TY,ECDH.C,ECDH.D,ECDH.E,ECDH.T,ECDH.RC,ECDH.PH,ECDH.H,ECDH.XRN,ECDH.DP,ECDH.MR,ECDH.ED,ECDP.TY,ECDP.C,ECDP.D,ECDP.E,ECDP.T,ECDP.RC,ECDP.PH,ECDP.H,ECDP.XRN,ECDP.DP,ECDP.MR,ECDP.ED,ECS.L,ECS.TY,ECS.C,ECS.5,ECS.9,ECS.D,ECS.E,ECS.T,ECS.PH,ECS.HU,ECS.OC,ECS.CE,ECS.MB,ECS.MR,ECS.ED,EOD.L,EOD.TY,EOD.RE,EOD.C,EOD.D,EOD.RAT,EOD.MR,EOD.ED,USE.L,USE.LH,USE.PT,USE.ED,INP.L,INP.INP,INP.ED,QUAN.L,QUAN.PROP,QUAN.MET,QUAN.ED"
    split(a,rxdets,",")
    gsub(",","\t",a)
#    print a
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



