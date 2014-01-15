#Chr1     Chr2     Chr3     Chr4     Chr5     ChrM     ChrC 
#30427671 19698289 23459830 18585056 26975502   366924   154478
#5 Chr length = 119146348;

#setwd("/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read")

args = commandArgs();

library(chipseq)

setwd(args[8])

size = args[6];
size = as.numeric(size)
input = args[5];
output = args[7]
chrLength = 119146348


raw_data = readAligned(".",input,type = "SOAP", filter = positionFilter(min = size + 5));
print ("input read number:")
print (length(raw_data));

readNumber = length(raw_data)[1]
#length: 1351093
#date();L8_soap_filtered = readAligned(".","Lane8_No_Ab_low_hit_combined.soap",type = "SOAP",filter =chipseqFilter() );date()
#length: 59001

#a = L8_soap;

#a = L8_soap_filtered

data_GRange = as(raw_data,"GRanges")

#print (size)
#is.numeric(size)
#is.vector(size)

data_ext = resize(data_GRange, width = size)
#data_ext = resize(data_GRange, width = 140)

cov = coverage (data_ext)

cutoff = ceiling(3*readNumber*size/chrLength)
print("cutoff")
print(cutoff)
#140
island = slice(cov,lower = cutoff)


for(i in 1:length(island)){
	write.table(names(island[i]), file = output,append = T, quote =F, sep ="\t",row.names=F, col.names=F)
	start = as.data.frame(start(island[[i]]))
	end = as.data.frame(end(island[[i]]))
	width = as.data.frame(width(island[[i]]))
	write.table( cbind(start, end, width),file = output, append = T, quote =F, sep ="\t",row.names=F, col.names=F);
}

q("no")