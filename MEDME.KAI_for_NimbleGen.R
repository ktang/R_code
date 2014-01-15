##this script is mainly use the Ringo output(procesed by Perl) gff files
# run the modified MEDME package


library(MEDME.Kai)

library(BSgenome.Athaliana.TAIR.06202009)

setwd("/Users/kaitang/Desktop/Nimblegen/real_data/gff_data")
load("try_after_CG.rda")
load("model_for_try.rda")

system("date");load("raw_MEDMESet.rda");system("date")
#########################################################################
#
#          read files use MEDME.readFiles
#
#########################################################################
#########################################################################

system("date")  #Mon Aug  2 15:27:34 PDT 2010

raw_MEDMESet = MEDME.readFiles(,files = c("50446602_preprocessed.gff",
"50446902_preprocessed.gff","50449302_preprocessed.gff","50471602_preprocessed.gff",
"50533302_preprocessed.gff", "50541202_preprocessed.gff","50541502_preprocessed.gff",
"50541802_preprocessed.gff", "50594202_preprocessed.gff", "50606702_preprocessed.gff"),
format="gff",organism="ath")

system("date")  #Mon Aug  2 15:39:09 PDT 2010



raw_MEDMESet=smooth(data = raw_MEDMESet )

system("date");raw_MEDMESet=CGcount(data=raw_MEDMESet); system("date")
Mon Aug  2 15:48:43 PDT 2010
chr1  chr2  chr3  chr4  chr5  
Mon Aug  2 15:52:02 PDT 2010



system("date");model= MEDME(data=raw_MEDMESet,sample=1); system("date");
Mon Aug  2 16:12:30 PDT 2010
Mon Aug  2 16:13:12 PDT 2010


system("date");raw_MEDMESet=predict(data=raw_MEDMESet,MEDMEfit=model); system("date");

#########################################################################
system("date")#Mon Aug  2 21:57:19 PDT 2010
raw_MEDMESet=smooth(data = raw_MEDMESet,wsize=500,wFunction="none" )
system("date")#Mon Aug  2 21:58:26 PDT 2010
raw_MEDMESet=CGcount(data=raw_MEDMESet,wsize=500,wFunction="none")
system("date")#Mon Aug  2 22:01:27 PDT 2010
model= MEDME(data=raw_MEDMESet,sample=2,CGcountThr =10,figName="50446902.jpg")
system("date")#Mon Aug  2 22:02:21 PDT 2010
raw_MEDMESet = predict(data=raw_MEDMESet,MEDMEfit=model,MEDMEextremes=c(-100,100),wsize=500,wFunction="none")
system("date")

#########################################################################
#########################################################################

x=MEDME.readFiles(,files= "50446602_preprocessed.gff",format="gff",organism="ath")
x=smooth(data=x)
x = CGcount(data=x)
m = MEDME(data=x,sample=1)

x=predict(data=x,MEDMEfit=m)



pre = function (data, MEDMEfit, MEDMEextremes = c(1, 32), wsize = 1000, 
wFunction = "linear") 
{
    if (class(data) != "MEDMEset") 
	stop("data needs to be an object of class MEDMEset ..")
    if (class(MEDMEfit)[1] != "drc") 
	stop("MEDMEfit needs to be an object of class drc ..")
    if (class(wsize) != "numeric") 
	stop("wsize needs to be a number ..")
    if (length(wsize) > 1) 
	stop("wsize needs to be 1 number ..")
    wsize = round(wsize)
    if (wFunction != "linear" && wFunction != "exp" && wFunction != 
        "log" && wFunction != "none") 
	stop("wFunction needs to be one of [linear, exp, log or none] ..")
    probeChr = chr(data)
    probePos = pos(data)
    probeCGcounts = CG(data)
    probeMeDIP = logR(data)
    col_name = colnames(logR(data))
    if (wFunction == "linear") 
	wFun = 1
    if (wFunction == "exp") 
	wFun = 2
    if (wFunction == "log") 
	wFun = 3
    if (wFunction == "none") 
	wFun = 0
    chrs = c(paste("chr", 1:5, sep = ""), "chrM", "chrC")
    probeMeDIP = as.data.frame(probeMeDIP)
    AMS = NULL
    RMS = NULL
    MeDIPw = NULL
    for (chr in chrs)
	{
        inds = which(probeChr == chr)
        if (length(inds) == 0) 
		next
        print(chr)
        pos = probePos[inds]
        MeDIP = probeMeDIP[inds, ]
		
		
       
        MeDIP = as.matrix(MeDIP)
        
		
		MeDIP = as.data.frame(MeDIP)
		
		
		rownames(MeDIP) = rownames(probeMeDIP)[inds]
        colnames(MeDIP) = col_name
        CGcount = probeCGcounts[inds]
        sortedInds = sort(pos, index.return = TRUE)$ix
        pos = pos[sortedInds]
        temp_name = rownames(MeDIP)[sortedInds]
        MeDIP = MeDIP[sortedInds, ]
        MeDIP = as.data.frame(MeDIP)
        rownames(MeDIP) = temp_name
        CGcount = CGcount[sortedInds]
        MeDIPwChr = as.data.frame(matrix(, length(pos), ncol(MeDIP)), 
								  stringsAsFactors = FALSE, check.names = FALSE)
        AMSchr = as.data.frame(matrix(, length(pos), ncol(MeDIP)), 
							   stringsAsFactors = FALSE, check.names = FALSE)
        RMSchr = as.data.frame(matrix(, length(pos), ncol(MeDIP)), 
							   stringsAsFactors = FALSE, check.names = FALSE)
        MeDIPwChr[, 1] = chr
        MeDIPwChr[, 2] = pos
        AMSchr[, 1] = chr
        AMSchr[, 2] = pos
        RMSchr[, 1] = chr
        RMSchr[, 2] = pos
		
		
		
		
        for (mcol in 1:ncol(MeDIP)) 
		{
			
			browser();
            res = .C("MEDMEweight", LENGTH = as.integer(length(pos)), 
					 POS = as.double(pos), MeDIP = as.double(MeDIP[, 
															 mcol]), WSIZE = as.double(wsize), WFUN = as.integer(wFun), 
					 BOOLEAN = as.integer(1), CGcount = as.double(CGcount), 
					 AMS = as.double(MeDIP[, mcol]), RMS = as.double(MeDIP[, 
																	 mcol]), as.double(c(coef(MEDMEfit), MEDMEextremes)), 
					 PACKAGE = "MEDME.Kai")
browser();
            MeDIPwChr[, mcol] = res$MeDIP
            AMSchr[, mcol] = res$AMS
            RMStemp = res$RMS
            RMStemp[RMStemp > 4] = 4
            RMSchr[, mcol] = RMStemp
        }
		
		browser()
		
        rownames(MeDIPwChr) = rownames(MeDIP)
        rownames(AMSchr) = rownames(MeDIP)
        rownames(RMSchr) = rownames(MeDIP)
        MeDIPw = rbind(MeDIPw, MeDIPwChr)
        AMS = rbind(AMS, AMSchr)
        RMS = rbind(RMS, RMSchr)
    }
    if (ncol(MeDIP) == 1) {
        m_row_name = rownames(MeDIPw)
        MeDIPw = MeDIPw[, 1]
        MeDIPw = as.data.frame(MeDIPw)
        rownames(MeDIPw) = m_row_name
        a_row_name = rownames(AMS)
        AMS = AMS[, 1]
        AMS = as.data.frame(AMS)
        rownames(AMS) = a_row_name
        r_row_name = rownames(RMS)
        RMS = RMS[, 1]
        RMS = as.data.frame(RMS)
        rownames(RMS) = r_row_name
    }
    colnames(MeDIPw) = colnames(MeDIP)
    colnames(AMS) = colnames(MeDIP)
    colnames(RMS) = colnames(MeDIP)
    MeDIPw = as.matrix(MeDIPw)[rownames(probeMeDIP), ]
    AMS = as.matrix(AMS)[rownames(probeMeDIP), ]
    RMS = as.matrix(RMS)[rownames(probeMeDIP), ]
    cat("done\n")
    MEDMEmsset = new("MEDMEset", chr = probeChr, pos = probePos, 
					 logR = logR(data), smoothed = as.matrix(MeDIPw), AMS = as.matrix(AMS), 
        RMS = as.matrix(RMS), CGcounts = CG(data), organism = org(data))
    return(MEDMEmsset)
}