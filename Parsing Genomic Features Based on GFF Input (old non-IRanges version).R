################################################
## Import GFF and Extract Feature Coordinates ##
################################################

## (1) Import chromosome sequences and corresponding GFF3
library(Biostrings)
read.gff3 <- function(file="gff3.txt") {
        gff <- read.delim(file)
        colnames(gff) <- c("seqid", "source", "type", "start", "end", "score", "strand", "phase", 
        "attributes")
        return(gff)
}
gff <- read.gff3(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/gff3.txt")
chr <- read.DNAStringSet(file="http://faculty.ucr.edu/~tgirke/Documents/R_BioCond/Samples/genome_sample.txt", "fasta") # Imports a sample gff and the corresponding chromosome sequences (here a highly simplified example!)

## (2) Extract feature coordinates of interest
gff2Feature <- function(gff=gff, feature="exon", discont=TRUE) {
        features <- gff[gff[,3]==feature,]
        if(discont==TRUE) { # Sorting for discontinous features important to assure 
                            # correct feature order (e.g. exons of mRNAs)
            sortfeature <- tapply(1:length(features[,1]), features[,9], function(x) 
            x[order(features[x,4])])
            features <- features[as.numeric(unlist(sortfeature)),]
        }
        return(features)
}

## (3) Parsing of continuous sequences (e.g. genes, promoters)
seqParse <- function(chr=chr, features=gene, chrid="Chr1", revcomp="-") {
        features <- features[features[,1]==chrid, ]
        fragment <- Views(chr[[which(names(chr) == chrid)]], start = features[, 4], 
        end = features[, 5])
        names(fragment) <- features[, 9]
        if(revcomp != FALSE) {
                revcompindex <- which(names(fragment) %in% 
                unique(features[features[,7]==revcomp, 9]))
                revcompseq <- reverseComplement(fragment[revcompindex])
                fragment <- c(DNAStringSet(fragment[-revcompindex]), DNAStringSet(revcompseq))
        }
        return(fragment)
}
gene <- gff2Feature(gff=gff, feature="gene", discont=FALSE)
gene1chr <- seqParse(chr=chr, features=gene, chrid="Chr1", revcomp="-") # Returns gene sequences from first chromosome. The reverse and complement will be returned for all entries with a "-" in the 'strand' column of the gff when "-" is assigned to the revcomp argument.
geneallchr <- sapply(c(names(chr)), function(x) seqParse(chr=chr, features=gene, chrid=x, revcomp="-")) # Same as in previous step but for all chromosomes.

## (4) Parsing of discontinuous features and joining them to continuous sequences: e.g. exon to mRNA sequences
discseqParse <- function(chr=chr, features=exons, chrid="Chr1", revcomp="-") {
        features <- features[features[,1]==chrid, ]
        fragment <- Views(chr[[which(names(chr) == chrid)]], start = features[, 4], 
        end = features[, 5])
        fragment <- DNAStringSet(paste(fragment, collapse=""))
        fragmentindex <- features[features[,1]==chrid, 5] - features[features[,1]==chrid, 4] + 1
        mylength <- tapply(fragmentindex, features[features[,1]==chrid, 9], sum)
        mylength <- sapply(seq(along=mylength), function(x) sum(mylength[1:x]))
        mystart <- c(1, mylength[-length(mylength)] + 1)
        fragment <- Views(fragment[[1]], start = mystart, end = mylength)
        names(fragment) <- unique(features[features[,1]==chrid, 9])
        if(revcomp != FALSE) {
                revcompindex <- which(names(fragment) %in% 
                unique(features[features[,7]==revcomp, 9]))
                revcompseq <- reverseComplement(fragment[revcompindex])
                fragment <- c(DNAStringSet(fragment[-revcompindex]), DNAStringSet(revcompseq))
        }
        return(fragment)
}
exons <- gff2Feature(gff=gff, feature="exon", discont=TRUE)
exons[, 9] <- gsub("^.*=", "", exons[,9]) # Note: the last column provides the exon-to-gene associations. This may need to be adjusted for other GFFs!!   
cdna1chr <- discseqParse(chr=chr, features=exons, chrid="Chr1", revcomp="-") # Parses all UTR/exon sequences and returns them as continuous cDNA sequences in proper orientation.
cdnaallchr <- sapply(c(names(chr)), function(x) discseqParse(chr=chr, features=exons, chrid=x, revcomp="-")) # Same as in previous step but for all chromosomes.
eval(parse(text=paste("c(", paste("cdnaallchr[[", 1:length(cdnaallchr), "]]", sep="", collapse=", "), ")", sep=""))) # Returns sequences in a single DNAStringSet object.

## (5) CDS parsing, ORF assembly and translation into proteins
cds <- gff2Feature(gff=gff, feature="CDS", discont=TRUE)
cds[, 9] <- gsub(",.*", "", cds[,9]) # Note: the last column provides the exon-to-gene associations. This may need to be adjusted for other GFFs!!
cds <- sapply(c(names(chr)), function(x) discseqParse(chr=chr, features=cds, chrid=x, revcomp="-"))
cds <- eval(parse(text=paste("c(", paste("cds[[", 1:length(cds), "]]", sep="", collapse=", "), ")", sep="")))
mypep <- AAStringSet(sapply(seq(along=cds), function(x) toString(translate(cds[[x]]))))
names(mypep) <- names(cds)
