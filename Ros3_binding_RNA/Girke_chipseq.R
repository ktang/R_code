#################
## Data Import ##
#################
library(chipseq); library(lattice)
data(cstest); cstest # Loads a reduced test data set containing the start positions and orientation of the aligned reads for three mouse chromosomes.
cstest; cstest$ctcf # cstest is a list-like object of class "GenomeDataList". Each of its components contains the data from one Illumina lane.

#####################
## Extending Reads ##
#####################
## HT sequencing data contain often only the partial sequence of ChIP-Seq pull-down fragments. Therefore, it can be useful in certain cases to extend the reads to cover the entire binding site of DNA binging proteins. 
estimate.mean.fraglen(cstest$ctcf, method="SISSR") # The function 'estimate.mean.fraglen' implements several methods to estimate the mean fragment length. See help file for details. 
ext <- resize(cstest$ctcf, width = 200) # Returns an IRanges object of read intervals extended to 200 bases.

#################################
## Coverage, Islands and Depth ##
#################################
cov <- coverage(ext); cov # Counts the read coverage for each base. The results are stored in a run-length encoded form as Rle object.
islands <- slice(cov, lower = 1) # Returns read islands where the read coverage is equal or above a specified bound.
viewSums(islands) # Returns the sum of coverage in the islands.
table(viewSums(islands) / 200) # Returns the number of estimated reads of the corresponding islands.
viewMaxs(head(islands)) # Returns the maximum coverage depth within each island.
table(viewMaxs(islands)) # Counts the corresponding islands.

## Function to perform above analysis on many data sets with seqapply()
islandReadSummary <- function(x) {
    g <- resize(x, width = 200)
    s <- slice(coverage(g), lower = 1)
    tab <- table(viewSums(s) / 200)
    df <- DataFrame(tab)
    colnames(df) <- c("chromosome", "nread", "count")
    df$nread <- as.integer(df$nread)
    df
}
head(islandReadSummary(cstest$ctcf)) # Returns same result as before.
nread.islands <- seqapply(cstest, islandReadSummary) # Performs analysis on all chromosomes.
nread.islands <- stack(nread.islands, "sample") # Returns results as data frame.

## Plots the distribution of read numbers against the number of islands.
xyplot(log(count) ~ nread | sample, as.data.frame(nread.islands), 
subset = (chromosome == "chr10" & nread <= 40), 
layout = c(1, 2), pch = 16, type = c("p", "g"))

##############################
## Chromosome Coverage Plot ##
##############################
plotCov <- function(mycov=cov, mychr=1, mypos=c(1,1000), mymain="Coverage", ...) {
    op <- par(mar=c(8,3,6,1))
    plot(as.numeric(mycov[[mychr]][mypos[1]:mypos[2]]), type="l", 
		 lwd=1, col="blue", ylab="", main=mymain, xlab="", xaxt="n", ...)
    axis(1, las = 2, at=seq(1,mypos[2]-mypos[1], length.out= 10), 
		 labels=as.integer(seq(mypos[1], mypos[2], length.out= 10)))
    par(op)
}
plotCov(mycov=cov, mychr="chr10", mypos=c(3000000,4000000))

##############################
## Peak Calling and Summary ##
##############################
peakCutoff(cov, fdr = 0.0001) # Using Poisson-based approach for estimating the noise distribution, the 'peakCutoff' function returns a cutoff value for a specific FDR.
peaks <- slice(cov, lower = 8); peaks # Based on the above calculated coverage value ~7 at an FDR of 0.0001, one can choose a coverage >=8 as a conservative cutoff value for peak calling. 
peaks.sum <- peakSummary(peaks) # Summarizes the peak data in a RangedData object.

###############################################
## Strand-Specific Peak Calling and Plotting ##
###############################################
peak.depths <- viewMaxs(peaks) 
cov.pos <- coverage(ext[strand(ext) == "+"]) # Returns coverage for sense matches.
cov.neg <- coverage(ext[strand(ext) == "-"]) # Returns coverage for antisense matches.
peaks.pos <- Views(cov.pos, peaks) 
peaks.neg <- Views(cov.neg, peaks) 
wpeaks <- tail(order(peak.depths$chr10), 4); wpeaks # Returns four highest peaks.
coverageplot(peaks.pos$chr10[wpeaks[1]], peaks.neg$chr10[wpeaks[1]]) # Plots the first peak. 

###############################################
## DPs: Differential Peaks Among Two Samples ##
###############################################
## Simplest strategy is to combine the data from two samples and then compare the contribution of each sample to the peaks. 
cov.gfp <- coverage(resize(cstest$gfp, 200)) 
peaks.gfp <- slice(cov.gfp, lower = 8) 
peakSummary <- diffPeakSummary(peaks.gfp, peaks) 
xyplot(asinh(sums2) ~ asinh(sums1) | space,
data = as.data.frame(peakSummary),
panel = function(x, y, ...) {
	panel.xyplot(x, y, ...) 
	panel.abline(median(y - x), 1)
    },
    type = c("p", "g"), alpha = 0.5, aspect = "iso")