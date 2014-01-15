setwd("/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read")
library(chipseq)


date();L8_soap = readAligned(".","Lane8_No_Ab_low_hit_combined.soap",type = "SOAP");date()
#length: 1351093
date();L8_soap_filtered = readAligned(".","Lane8_No_Ab_low_hit_combined.soap",type = "SOAP",filter =chipseqFilter() );date()
#length: 59001

a = L8_soap;

#a = L8_soap_filtered

a_GRange = as(a,"GRanges")

a_ext = resize(a_GRange, width = 140)

cov = coverage (a_ext)

island = slice(cov,lower = 10)

for(i in 1:length(island)){
	
	
		write.table(names(island[i]), file = "try_island_out.txt",append = T, quote =F, sep ="\t",row.names=F, col.names=F)
		start = as.data.frame(start(island[[i]]))
		end = as.data.frame(end(island[[i]]))
		width = as.data.frame(width(island[[i]]))
		
		write.table( cbind(start, end, width),file = "try_island_out.txt", append = T, quote =F, sep ="\t",
				   row.names=F, col.names=F);

}