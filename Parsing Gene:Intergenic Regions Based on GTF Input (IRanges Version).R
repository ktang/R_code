########################################
## Coordinates for Intergenic Regions ##
########################################
## (A.1) Import/parsing of GTF containing only the start and end positions for each gene of all chromosomes.
## The GTF file needs to be downloaded from http://uswest.ensembl.org/info/data/ftp/index.html
library(Biostrings); library(IRanges)
gtf2genePos <- function(myfile="Homo_sapiens.GRCh37.57.gtf") {
        gtf <- read.delim(myfile, header=FALSE)
        colnames(gtf) <- c("seqname", "source", "feature", "start", "end", "score", "strand", "frame",      
        "attributes")
        chronly <- c(1:22, "X", "Y", "MT")
        gtf <- gtf[as.character(gtf$seqname) %in% chronly, ] # Cleanup to remove non-chromosome rows
        gtf[, length(gtf[1,])] <- gsub(" {1,}|gene_id|;.*", "", gtf$attributes)
        gtf1 <- gtf[order(gtf$seqname, gtf$start), ] 
        gtf1 <- gtf1[!duplicated(gtf1$attributes), ] # Returns only rows with most left gene positions.
        gtf2 <- gtf[order(gtf$seqname, -gtf$start), ] 
        gtf2 <- gtf2[!duplicated(gtf2$attributes), ] # Returns only rows with most right gene positions.
        gtf1 <- gtf1[order(gtf1$attributes), ]
        gtf2 <- gtf2[order(gtf2$attributes), ]
        gtf1[,5] <- gtf2[,5] # Assigns proper end postions
        gtfgenepos <- gtf1 # Returns gtf containing only start/end positions for entire genes
        gtfgenepos <- gtfgenepos[order(gtfgenepos$seqname, gtfgenepos$start), ]
        return(gtfgenepos)
}
genepos <- gtf2genePos(myfile="Homo_sapiens.GRCh37.57.gtf") # This will take some time due to the large size of the GTF file for human.

## (A.2) Download and import chromosome sequence (here chr 1 from human)
system("wget ftp://ftp.ensembl.org/pub/current_fasta/homo_sapiens/dna/Homo_sapiens.GRCh37.57.dna.chromosome.1.fa.gz") # Note: system commands only relevant for Linux OSs.
system("gunzip Homo_sapiens.GRCh37.57.dna.chromosome.1.fa.gz")
chr1 <- read.DNAStringSet(file="Homo_sapiens.GRCh37.57.dna.chromosome.1.fa" , "fasta")
unlink("Homo_sapiens.GRCh37.57.dna.chromosome.1.fa")

## (B.1) Parsing of gene sequences
chrgenepos <- genepos[genepos$seqname==1,] # Selects entries for chr 1.
ir <- IRanges(start=chrgenepos$start, end=chrgenepos$end, names=chrgenepos$attributes) # Creates IRanges object from GTF entries for chr 1.
geneschr1 <- Views(chr1[[1]], start=start(ir), end=end(ir)) # Returns gene sequences in Views object.
geneschr1 <- DNAStringSet(geneschr1); names(geneschr1) <- names(ir) # Returns sequences as DNAStringSet object. 


## (B.2) Parsing of intergenic sequences
## (B.2.1) Collapse overlapping gene positions to continuous ranges.
irred <- reduce(ir) # Collapses ranges of overlapping genes to continuous range.
ol <- findOverlaps(ir, irred) # Identifies overlaps among initial and reduced range data sets.
names(irred) <- tapply(names(ir), as.matrix(ol)[,2], paste, collapse="_") # Assigns proper names to reduced data set.

## (B.2.2) Convert gene positions to intergenic positions
intergenic <- irred
start(intergenic) <- c(1, end(irred)[-length(irred)]+1)
end(intergenic) <- start(irred) - 1
names(intergenic) <- c("start", paste(names(irred)[-length(irred)], names(irred)[-1], sep="_:_"))
mywidth <- 100 # Note: mywidth needs to be set to distance from end of last gene to chromosome end!
intergenic <- c(intergenic, IRanges(start=end(irred)[length(irred)]+1, width=mywidth, names="end"))

## (B.2.3) Parsing of intergenic regions 
interchr1 <- Views(chr1[[1]], start=start(intergenic), end=end(intergenic))
interchr1 <- DNAStringSet(interchr1)
names(interchr1) <- names(intergenic)