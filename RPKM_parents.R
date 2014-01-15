#######################
## ChIP-Seq Analysis ##
#######################
## Define experimental design
targets <- data.frame(Samples=c("Brain", "Brain", "UHR", "UHR"), Fastq=c("flowcell45_lane3", "flowcell45_lane5", "flowcell45_lane7", "flowcell45_lane8" ));


## Process all samples in for loop (takes for all samples about 5 min due to the large size of the alignment files!)
library(ShortRead)
cdna <- read.DNAStringSet("/mnt/disk2/genomes/heterosis/hybrid_RNASeq/C24/Col0_cDNA_longest_soap_index/Col0_cDNA_longest.fa.no_comment","fasta")
resultsTable <- data.frame(ID=as.character(names(cdna)), Length=width(cdna))
for(i in as.character(targets$Fastq)) {
	## Import alignments for each sample
	alignedReads <- readAligned("/mnt/disk4/genomes/heterosis/kai/analysis_parents_May19/soapout_vsCol0/", pattern=paste(i, "_high_quality_vs_Col0_cDNA_logest.soapout", sep=""), type="SOAP")
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
