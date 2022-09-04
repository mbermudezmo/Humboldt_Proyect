#!/usr/bin/awk -f
#The main idea of this code was proposed by Andres Camilo Marulanda Bran. The former code that he created and used, it is not useful when it is needed to use a bigger list of fields. In order to preprocess the raw data quickly, the algorithm changed. Now the idea is to detect the field and then evaluate if that field belongs to the list of fields that previosly has been selected. With this idea, each line is read only once time.      
#In this version, it was neccesary split the fields in two sets: the set of RX and the set of RXD. This due to the needed to consider the differentes RXD by RX.

BEGIN {
    a="RX.ID,RX.RXRN,RX.PXRN,RX.BLA,RX.BLB,RX.BLC,RX.NVAR,RX.BIN,RX.BFREQ,RX.BRANGE,RX.RANK,RX.MYD,RX.SKW,RX.RTYP,RX.RAVAIL,RX.PAVAIL,RX.MAXPUB,RX.NUMREF,RX.MAXPMW,RX.ED,RX.UPD"
    b="RXD.L,RXD.SOURCE,RXD.CL,RXD.SCO,RXD.LB,RXD.STP,RXD.MID,RXD.YXRN,RXD.YPRO,RXD.NYD,RXD.YDO,RXD.SNR,RXD.STG,RXD.SXRN,RXD.SRCT,RXD.RGTXRN,RXD.RGT,RXD.CATXRN,RXD.CAT,RXD.SOLXRN,RXD.SOL,RXD.SPH,RXD.TIM,RXD.T,RXD.P,RXD.PH,RXD.COND,RXD.TYP,RXD.SUB,RXD.PRT,RXD.PARENTLINK,RXD.RXDES,RXD.DED,CNR.CNR,CIT.PREPY,CIT.PPY,CIT.PY"
    split(a,rxdets,",")
    gsub(",","\t",a)
    split(b,rxdetsb,",")
    gsub(",","\t",b)
    print "num" "\t" a "\t" b
}
