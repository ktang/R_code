#######################
## ChIP-Seq Analysis ##
#######################
## Define experimental design from Kaufmann et al, 2010
targets <- data.frame(Samples=c("AP1UIND1", "AP1UIND1", "AP1UIND2", "AP1UIND2", "AP1IND1", "AP1IND2", "AP1IND2"),
                      Fastq=c("SRR038848", "SRR038849", "SRR038850", "SRR038851", "SRR038845", "SRR038846", "SRR038847"))
targets <- targets[!duplicated(targets[,1]),] # Use only one lane per replicate sample

## Alignment with bowtie
ref <- "/srv/projects/db/tmpgirke/chipseq/refseq/TAIR9_chr_all.binary"
fastq <- "/srv/projects/db/tmpgirke/chipseq/samples/"
out <- "/srv/projects/db/tmpgirke/chipseq/results/"
runbowtie <- function(ref=ref, fastq=fastq, out=out, sample="SRR038846") {
	bowtiecommand <- paste("bowtie -q ", ref, " ", fastq, sample, ".fastq ", out, sample, ".bowtie", sep="")
	system(bowtiecommand)	
}
sapply(targets$Fastq, function(x) runbowtie(ref=ref, fastq=fastq, out=out, sample=x))

## Import alignment and chromosome data 
library(ShortRead); library(chipseq);library(lattice)
mychr <- read.DNAStringSet("/srv/projects/db/tmpgirke/chipseq/refseq/TAIR9_chr_all.fas","fasta")
names(mychr) <- c("1", "2", "3", "4", "5", "chloroplast", "mitochondria")
mychrlength <- width(mychr); names(mychrlength) <- names(mychr)
chip_signal <- readAligned("/srv/projects/db/tmpgirke/chipseq/results", pattern="SRR038846.bowtie", type="Bowtie")
data.frame(ID=sapply(as.list(id(chip_signal)[1:4]), toString), Pos=position(chip_signal)[1:4], Chr=chromosome(chip_signal)[1:4], Strand=strand(chip_signal)[1:4], Seq=sapply(as.list(sread(chip_signal)[1:4]), toString))
	## Access data slots of AlignedRead object
		## names(attributes(chip_signal)) # returns slots
		## id(chip_signal) # returns IDs
		## sread(chip_signal) # returns sequences as DNAStringSet object
		## position(chip_signal) # returns mapping positions
		## chromosome(chip_signal) # returns chromosome info
		## strand(chip_signal) # returns strand info

## Peak calling (simple version)
extend <- 160 # Parameter used to be 160 to extend to 200bp reads!
chrnames <- as.character(sort(unique(chromosome(chip_signal))))
names(mychrlength) <- chrnames # Required for coverage
chrranges <- sapply(chrnames, function(x) IRanges(start=position(chip_signal)[chromosome(chip_signal) %in% x], width=40+extend))
chrstrand <- sapply(chrnames, function(x) strand(chip_signal)[chromosome(chip_signal) %in% x])
cov <- sapply(chrnames, function(x) coverage(chrranges[[x]], width = mychrlength[x])) # Calculate read coverage for all chromosomes
peaks <- sapply(chrnames, function(x) slice(cov[[x]], lower = 50)) # Call peaks based on minimum coverage value (lower =)
	## as.numeric(peaks[[1]][[1]]) # returns coverage vector

## Function to generate coverage plot for spec region
plotCov <- function(mycov=cov, mychr=1, mypos=c(1,1000), mymain="Coverage", ...) {
	op <- par(mar=c(8,3,6,1))
	plot(as.numeric(mycov[[mychr]][mypos[1]:mypos[2]]), type="l", lwd=1, col="blue", ylab="", main=mymain, xlab="", xaxt="n", ...)
	axis(1, las = 2, at=seq(1,mypos[2]-mypos[1], length.out= 10), labels=as.integer(seq(mypos[1], mypos[2], length.out= 10)))
	par(op)
}
plotCov(mycov=cov, mychr=2, mypos=c(1, mychrlength[2]), ylim=c(0,100), mymain=paste("Chr", 2)) 

## Plot individual peaks
plotPeak <- function(mychr="1", peakno=1) {
	cov.pos <- coverage(chrranges[[mychr]][chrstrand[[mychr]]=="+"], width = mychrlength[1])   
	cov.neg <- coverage(chrranges[[mychr]][chrstrand[[mychr]]=="-"], width = mychrlength[1])   
	peaks.pos <- copyIRanges(peaks[[mychr]], cov.pos)
	peaks.neg <- copyIRanges(peaks[[mychr]], cov.neg)
	coverageplot(peaks.pos[peakno], peaks.neg[peakno])
}
plotPeak(mychr="1", peakno=2)

##################################################
## Obtain Genomic Context Information for Peaks ##
##################################################
## Annotate peaks with gene annotations from TAIR's gff
library(Biostrings)
read.gff3 <- function(file="gff3.txt") {
        gff <- read.delim(file)
        colnames(gff) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", "attributes")
        return(gff)
}
# system("wget ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR9_genome_release/TAIR9_gff3/TAIR9_GFF3_genes.gff")
gff <- read.gff3(file="/srv/projects/db/tmpgirke/chipseq/refseq/TAIR9_GFF3_genes.gff")
gffsub <- gff[gff$type=="gene",]
gffsub[, 9] <- gsub("ID=|;.*", "", gffsub[,9])
gffsub <- cbind(gffsub, AGI=gsub("\\..*", "", gffsub[,9]))
gffsub <- gffsub[!duplicated(gffsub$AGI),]
subranges <- RangedData(IRanges(start=gffsub$start, end=gffsub$end, names=gffsub$AGI), space=gffsub$seqid, strand=as.numeric(paste(gffsub$strand, 1, sep="")))
names(peaks) <- unique(gffsub[,1])
library(ChIPpeakAnno)
annotatedPeak <- sapply(names(peaks), function(x)  annotatePeakInBatch(RangedData(peaks[[x]], space=x), AnnotationData = subranges))
allPeaks <- data.frame(NULL); for(i in names(peaks)) { allPeaks <- rbind(allPeaks, as.data.frame(annotatedPeak[[i]]))  } 

## Add standard annotation information
# system("wget ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR9_genome_release/TAIR9_functional_descriptions")
# Removed in Excel long description column, because it caused import problems...
myannot <- read.delim("/srv/projects/db/tmpgirke/chipseq/refseq/TAIR9_functional_descriptions") 
myannot[,1] <- gsub("\\..*", "", myannot[,1]); myannot <- myannot[!duplicated(myannot[,1]),1:3]
allPeaks <- merge(allPeaks, myannot, by.x="feature", by.y=1, all.x=T)
allPeaks <- cbind(allPeaks, peaknames=paste(allPeaks$space, allPeaks$start, sep=":"))

## Add coverage information
maxcov <- data.frame(peaknames=unlist(sapply(names(peaks), function(x) paste(x, start(peaks[[x]]), sep=":"))), MaxCov=unlist(sapply(names(peaks), function(x) viewMaxs(peaks[[x]]))))
allPeaks <- merge(maxcov, allPeaks, by.x="peaknames", by.y="peaknames", all=T)
allPeaks <- allPeaks[order(allPeaks$space, allPeaks$start), ]
write.table(allPeaks, file="allPeaks.xls", row.names=F, quote=F, sep="\t")

################################
## Obtain Sequences for Peaks ##
################################
# system("wget ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR9_genome_release/TAIR9_chr_all.fas")
mychr <- read.DNAStringSet("/srv/projects/db/tmpgirke/chipseq/refseq/TAIR9_chr_all.fas","fasta")
mychr <- mychr[c(1:5,7,6)]
names(mychr) <- names(peaks)
allPeaksfilter <- allPeaks[allPeaks$MaxCov >= 100 & allPeaks$width >= 100 & allPeaks$width <= 500 , ]
remove <- unlist(sapply(names(mychr), function(x) which(allPeaksfilter$space==x & allPeaksfilter$end >= width(mychr[names(mychr)==x]))))
if(length(remove)!=0) allPeaksfilter <- allPeaksfilter[-remove, ]
peakseq <- sapply(names(mychr), function(x) Views(mychr[[which(names(mychr) %in% x)]], start=allPeaksfilter$start[allPeaksfilter$space==x], end=allPeaksfilter$end[allPeaksfilter$space==x])) 
rankseq <- DNAStringSet(unlist(sapply(names(mychr), function(x) unlist(strsplit(toString(peakseq[[x]]), ", "))))) 
rankseq <- rankseq[order(-allPeaksfilter$MaxCov)] # Sorts peak sequences by coverage (highest on top) 
write.XStringSet(rankseq, file="rankseq.fasta", format="fasta") 

##############################
## Motif Discovery in Peaks ##
##############################
## Predicting Overrepresented Sequences
library(BCRANK)
set.seed(1)
BCRANKout <- bcrank("rankseq.fasta", restarts=25, use.P1=TRUE, use.P2=TRUE)
topMotif <- toptable(BCRANKout, 1)
weightMatrix <- pwm(topMotif, normalize = FALSE)
weightMatrixNormalized <- pwm(topMotif, normalize = TRUE)
library(seqLogo)
seqLogo(weightMatrixNormalized)
plot(topMotif)




