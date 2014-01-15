#Chr1     Chr2     Chr3     Chr4     Chr5     ChrM     ChrC 
#30427671 19698289 23459830 18585056 26975502   366924   154478
#5 Chr length = 119146348;

#setwd("/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read")

library(GenomicRanges)
library(rtracklayer)

args = commandArgs();


setwd(args[7])

input = args[5]
output = args[6]

bed = import.bed(input,variant = "base", genome = "TAIR9")
bed_sort = reduce(bed,min.gapwidth= 200)


setwd(args[8])
write.table(cbind(paste(space(bed_sort)), start(bed_sort),end(bed_sort)), output,quote=F, sep="\t",row.names=F,col.names=F)

q("no")