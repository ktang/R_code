#Chr1     Chr2     Chr3     Chr4     Chr5     ChrM     ChrC 
#30427671 19698289 23459830 18585056 26975502   366924   154478
#5 Chr length = 119146348;
#my $cmd = "R --slave --vanilla --args " . $input . " " . $length . " " . $output . " ". $dir . " < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/ChIPSeq_package.R";

#setwd("/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read")

# version 2 
# use peakCutoff() function in chipseq package to calculate the cutoff 

args = commandArgs();

library(chipseq)



size = args[6];
size = as.numeric(size)
input = args[5];
output = args[7]
#chrLength = 119146348

indir = args[8];
outdir = args[9];

setwd(indir)

raw_data = readAligned(".",input,type = "SOAP", filter = positionFilter(min = size + 5));
print ("input read number:")
print (length(raw_data));

#readNumber = length(raw_data)[1]
data_GRange = as(raw_data,"GRanges")

#print (size)
#is.numeric(size)
#is.vector(size)

data_ext = resize(data_GRange, width = size)
#data_ext = resize(data_GRange, width = 140)

cov = coverage (data_ext)

#rawcut = peakCutoff(cov, fdr = 0.00001)

cutoff = ceiling(peakCutoff(cov, fdr = 0.00001)) + 1;

#cutoff = ceiling(3*readNumber*size/chrLength)
print("cutoff")
print(cutoff)
#140
island = slice(cov,lower = cutoff)

setwd(outdir)

frame = as.data.frame( peakSummary(island) )
frame[,8] = frame[,7]/frame[,4]
names(frame)[c(1,8)] = c("Chr","average_coverage")
write.table(frame,file = output, quote =F, sep ="\t",row.names=F, col.names=T)

#for(i in 1:length(island)){
#	write.table(names(island[i]), file = output,append = T, quote =F, sep ="\t",row.names=F, col.names=F)
#	start = as.data.frame(start(island[[i]]))
#	end = as.data.frame(end(island[[i]]))
#	width = as.data.frame(width(island[[i]]))
#	write.table( cbind(start, end, width),file = output, append = T, quote =F, sep ="\t",row.names=F, col.names=F);
#}

q("no")