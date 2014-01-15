#######################
## ChIP-Seq Analysis ##
#######################
## Define experimental design
targets <- data.frame(Samples=c("Brain", "Brain", "UHR", "UHR"), Fastq=c("SRR037452", "SRR037453", "SRR037459", "SRR037460"))

## Alignment with bowtie
ref <- "/srv/projects/db/tmpgirke/rnaseq/refseq/human_longest_cdna.fa.binary"
fastq <- "/srv/projects/db/tmpgirke/rnaseq/samples/"
out <- "/srv/projects/db/tmpgirke/rnaseq/results/"
runbowtie <- function(ref=ref, fastq=fastq, out=out, sample="SRR037452") {
	bowtiecommand <- paste("bowtie -q ", ref, " ", fastq, sample, ".fastq ", out, sample, ".bowtie", sep="")
	system(bowtiecommand)	
}
rerun <- FALSE # Set to true only to reapeat bowtie alignments. This is already done!
if(rerun==TRUE) sapply(targets$Fastq, function(x) runbowtie(ref=ref, fastq=fastq, out=out, sample=x))

## Process all samples in for loop (takes for all samples about 5 min due to the large size of the alignment files!)
library(ShortRead)
cdna <- read.DNAStringSet("/srv/projects/db/tmpgirke/rnaseq/refseq/human_longest_cdna.fa","fasta")
resultsTable <- data.frame(ID=as.character(names(cdna)), Length=width(cdna))
for(i in as.character(targets$Fastq)) {
	## Import alignments for each sample
	alignedReads <- readAligned("/srv/projects/db/tmpgirke/rnaseq/results", pattern=paste(i, ".bowtie", sep=""), type="Bowtie")
	## Count reads aligned to each transcript
	countsDF <- as.data.frame(table(chromosome(alignedReads)))
	## Compute RPKM values
	resultsTable <- merge(resultsTable, countsDF, by.x=1, by.y=1, all.x = TRUE) 
	resultsTable[is.na(resultsTable[,length(resultsTable[1,])]), length(resultsTable[1,])] <- 0 # replace NAs in last column with 0s
	expressionLevel <- (1000 * resultsTable[,length(resultsTable[1,])] / resultsTable$Length) / (length(alignedReads) / 1000000) # Calculate rpkm values: reads per kilobase of exon model per million mapped reads
	resultsTable <- data.frame(resultsTable, expressionLevel) # Append RPKM values
	colnames(resultsTable)[(length(resultsTable[1,])-1):length(resultsTable[1,])] <- c(paste(i, "Count", sep="_"), paste(i, "RPKM", sep="_"))
}
write.table(resultsTable, file="RPKM.xls", quote=F, row.names=F, sep="\t")

## Import intermediate Results for further processing
resultsTable <- read.delim(file="/srv/projects/db/tmpgirke/rnaseq/results/RPKM.xls", row.names=1)
resultsTable[resultsTable==0] <- 1 # Adds a pseudo count to fields with zero. There are other ways to handle this. 
rpkmDF <- resultsTable[, grep("_RPKM", colnames(resultsTable))]

## Generic way to calculate mean, ratio, t-test, etc. for replicate groups defined in targets data frame
myList <- tapply(colnames(rpkmDF), targets$Samples, list)
names(myList) <- sapply(myList, paste, collapse="_")
mymean <- sapply(myList, function(x) mean(as.data.frame(t(rpkmDF[,x])))) 
myttest <- apply(rpkmDF, 1, function(x) t.test(rpkmDF[, myList[[1]]], rpkmDF[, myList[[2]]])$p.value) # Original t-test is very slow!
filterDF <- data.frame(mymean, logFC=log2(mymean[,1]/mymean[,2]), ttest=myttest) 

## Filter for genes that show a fold change of >= 4 and a p-value of <= 0.01
degDF <- filterDF[(filterDF$lodFC >= 2 | filterDF$lodFC <= -2) & filterDF$ttest <= 0.01, ]
dim(degDF)



