#######################
## RNA-Seq Analysis ##
#######################
## (1) Define experimental design
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

## (2) Process all samples in for loop (takes for all samples about 5 min due to the large size of the alignment files!)
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

## (3) DEG analysis
## (3.1) Import intermediate Results for further processing
resultsTable <- read.delim(file="/srv/projects/db/tmpgirke/rnaseq/results/RPKM.xls", row.names=1)
targets <- data.frame(Samples=c("Brain", "Brain", "UHR", "UHR"), Fastq=c("SRR037452", "SRR037453", "SRR037459", "SRR037460"))
resultsTable[resultsTable==0] <- 1 # Adds a pseudo count to fields with zero. There are other ways to handle this. 
rpkmDF <- resultsTable[, grep("_RPKM", colnames(resultsTable))]

## (3.2) Generic way to calculate mean, ratio, t-test, etc. for replicate groups defined in targets data frame
myList <- tapply(colnames(rpkmDF), targets$Samples, list)
names(myList) <- sapply(myList, paste, collapse="_")
mymean <- sapply(myList, function(x) mean(as.data.frame(t(rpkmDF[,x])))) 
myttest <- apply(rpkmDF, 1, function(x) if(all(x[1:2] == x[3:4])) NA else t.test(x[1:2], x[3:4], omit.na=T)$p.value)
filterDF <- data.frame(mymean, logFC=log2(mymean[,1]/mymean[,2]), ttest=myttest) 

## (3.3) Filter for genes that show a fold change of >= 4 and a p-value of <= 0.01
degDF <- filterDF[(filterDF$logFC >= 2 | filterDF$logFC <= -2) & filterDF$ttest <= 0.01, ]
dim(degDF)

## (3.4) Add annotation information from Homo sapiens annotation libarary (org.Hs.eg.db)
library(org.Hs.eg.db)
# library(help=org.Hs.eg.db) # Shows how to list annotation features

## Mappings for Enseml gene IDs to entrez gene IDs 
ensemblids <- org.Hs.egENSEMBL; ensemblids_mapped <- mappedkeys(ensemblids); ensemblids_mapped <- as.list(ensemblids[ensemblids_mapped]) 
ensemblDF <- data.frame(Entrez_ID=rep(names(ensemblids_mapped), sapply(ensemblids_mapped, length)), ENSEMBL_ID=as.character(unlist(ensemblids_mapped)))
g17 <- merge(g17, ensemblDF, by.x=1, by.y=2, all.x=T)

## Entrez gene IDs to gene name mappings 
entrezids <- org.Hs.egGENENAME; entrezids_mapped <- mappedkeys(entrezids); entrezids_mapped <- as.list(entrezids[entrezids_mapped]) 
entrezDF <- data.frame(Entrez_ID=rep(names(entrezids_mapped), sapply(entrezids_mapped, length)), Name=as.character(unlist(entrezids_mapped)))
g17 <- merge(g17, entrezDF, by.x=7, by.y=1, all.x=T)



## Entrez gene IDs to GO mappings (not used in following steps)
goids <- org.Hs.egGO; goids_mapped <- mappedkeys(goids); goids_mapped <- as.list(goids[goids_mapped]) 

## (4) GO term enrichment analysis
library(GOstats); library(GO.db); library(org.Hs.eg.db); library(annotate)  
geneSample <- unique(as.character(g17$Entrez_ID))
geneUniverse <- names(ensemblids_mapped)
params <- new("GOHyperGParams", geneIds = geneSample, universeGeneIds = geneUniverse, annotation="org.Hs.eg", ontology = "MF", pvalueCutoff = 0.5, conditional = FALSE, testDirection = "over")
    # Warning message can be ignored.
    # Repeat the previous step for all three ontologies: "MF", "BP" and "CC"
hgOver <- hyperGTest(params)
summary(hgOver)[1:20,] # Shows result summary for first 20 rows. Rows are sorted by p-value column. 
htmlReport(hgOver, file = "MyhyperGresult.html") # Creates summary in html format. Move the output file MyhyperGresult.html to your local computer for viewing.





