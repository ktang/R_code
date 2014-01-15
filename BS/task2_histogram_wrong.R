#args = commandArgs()
input = args[5]
output = args[6]
indir = args[7]
outdir = args[8]

setwd(indir)
data = read.table(file = input , header = T, sep = "\t")

setwd(outdir)

hist = table(data$depth)
write.table(cbind("depth", "number", "methylated_number"),file = output, append =T , quote =F, col.names=F, row.names=F,sep ="\t")
for(i in 1:dim(hist) ){
	temp = table( data[ data$depth == names(hist[i]) ,7])
	
	met = temp[ names(temp) == 1]
	
	if(length(met) == 0) {met = 0}
	
	write.table(cbind(names(hist[i]), hist[i], met ), file = output, append =T , quote =F, col.names=F, row.names=F,sep ="\t")
}

#for(i in 1:dim(try_his)){ 
#	print(table(try[ try$depth == names(try_his[i]) , 7 ])) 
#}

# try_his[ names(try_his ) == "3"]