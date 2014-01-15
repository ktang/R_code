# now the thought is that for each IP peak,
# check the coverage in control

#Chr1     Chr2     Chr3     Chr4     Chr5     ChrM     ChrC 
#30427671 19698289 23459830 18585056 26975502   366924   154478
#5 Chr length = 119146348;

#setwd("/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read")
#my $cmd = "R --slave --vanilla --args " . $input . " " . $length . " " . $output . " ". $dir . " < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/ChIPSeq_package.R";


#viewSums( Views(x,3,5))
#[1] 8




args = commandArgs();

library(chipseq)
library(rtracklayer)



size = args[6];
size = as.numeric(size)
input = args[5];
output = args[7]
inbed = args[9]
#chrLength = 119146348

beddir = args[8]
soapdir = args[10]

setwd(beddir)

print("reading inbed")
#bed = import.bed(inbed)
bed = read.table (file = inbed, header =T, sep ="\t")

setwd(soapdir)
print("reading soap")
#raw_data = readAligned(".",input,type = "SOAP", filter = positionFilter(min = size + 5));
x = readAligned(".",input,type = "SOAP", filter = positionFilter(min = size + 5));
print ("input read number:")
print (length(x));

#readNumber = length(raw_data)[1]
#length: 1351093
#date();L8_soap_filtered = readAligned(".","Lane8_No_Ab_low_hit_combined.soap",type = "SOAP",filter =chipseqFilter() );date()
#length: 59001

#a = L8_soap;

#a = L8_soap_filtered

#data_GRange = as(raw_data,"GRanges")
x = as(x,"GRanges")

#print (size)
#is.numeric(size)
#is.vector(size)

#data_ext = resize(data_GRange, width = size)
x= resize(x, width = size)
#data_ext = resize(data_GRange, width = 140)

#cov = coverage (data_ext)
cov = coverage(x)

setwd(beddir)

chr = table(bed[,1])

write.table(paste("Chr","start", "end", "max_depth_in_ctrl", "sum_ctrl", "average_coverage_in_ctrl",sep = "\t"),file = output,append=T ,quote = F, row.names =F,col.names=F)
#write.table(paste("Chr","start", "end", "max_depth_in_ctrl", "sum_ctrl", "average_coverage_in_ctrl",sep = "\t"),file = "1.txt",append=F ,quote = F, row.names =F,col.names=F)

for(i in 1:length(chr)){
	s = bed[bed[,1]== names(chr)[i]  ,2]
	e = bed[ bed[,1]== names(chr)[i]  ,3]
	viewsum = viewSums ( Views (cov[[ names(chr)[i]  ]] , start = s ,end = e ) )
	ave = viewsum / (e - s + 1)
	max = viewMaxs( Views (cov[[ names(chr)[i] ]] , start = s ,end = e ) )
	frame = cbind ( bed[bed[,1]== names(chr)[i], ], max, viewsum, ave )
	write.table(frame,file = output,append=T,quote = F, row.names =F,col.names=F, sep = "\t")
#	write.table(frame,file = "1.txt",append=T,quote = F, row.names =F,col.names=F, sep = "\t")
}

#for (i in 1:5){
#	viewsum = viewSums(Views(cov[[i]], start = start(bed[i]), end = end(bed[i])))/( end(bed[i]) - start(bed[i]) + 1)
#	frame = cbind(as.data.frame(bed[i]), viewsum)
#	write.table(frame,file = "average_cov.txt",append=T,quote = F, row.names =F,col.names=F, sep = "\t")
#	write.table(frame,file = output,append=T,quote = F, row.names =F,col.names=F, sep = "\t")
#}

q("no")