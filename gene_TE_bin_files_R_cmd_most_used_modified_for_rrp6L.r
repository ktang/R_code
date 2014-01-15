#setwd("/Volumes/My_Book/Heng_Zhang/GSE16071/results/2_June15/1/Gene")

mar_ori = par("mar")

par(mar = c(5, 6 , 4, 2) + 0.1)

print("modify label TE/GENE")

files = dir(pattern=".*in.+txt")

#print (files)

length = length(files)

lwd_line = 2

x_data = list()

for (i in 1:length(files)){ x_data[[i]] = read.table(files[i], head=T, sep = "\t") }

#x_lables = sub(".*all_.+_in_(.+)_binNum20_flaking2000bp_binNum20.txt", "\\1", files, perl =T)

#x_lables = sub(".*idm2-1_targets_in_(.+)_binNum20_flaking2000bp_binNum20.txt", "\\1", files, perl =T)
x_lables = sub(".+_(.+)_nodupl.+_binNum20_flaking2000bp_binNum20.txt", "\\1", files, perl =T)


label = c("CG", "CHG", "CHH", "C")

#cols = c("black", "gold1", "coral1", "blue3", "blueviolet", "darkgreen", "darkorange4")

#cols_db = c("black", "gold1", "coral1", "blue3", "blueviolet", "darkgreen", "darkorange4", "lawngreen", "red",  )

#  cols_db = colors()[c( 229, 151, 267, 629,  25, 116, 155, 177, 414, 365, 437 )]

#colors()[c( 34, 125, 461, 258, 657, 510, 404, 500, 204, 142, 100, 287 )]
#[1] "brown2"  "deepskyblue4" "mediumblue"   "green4"   "yellowgreen"  "orchid2"      "lightcoral"   "orange2"      "gray51"  "gold" "darkred" "grey26"   
#		34,	 	125,			461,			258,	657,		     510,			404,			500,			204,	142,	100,	287


#cols_db = colors()[c( 34, 142, 461, 258, 500, 510, 404,  204, 125, 100, 287 )]

cols_db =  c( rgb( 153, 153, 153, maxColorValue = 255), rgb( 51, 102, 255, maxColorValue = 255), 
rgb( 255, 102,0, maxColorValue = 255 ), 
#rgb( 255,0 , 255, maxColorValue = 255), 
rgb( 0, 255, 255, maxColorValue = 255)  )

#cols = cols_db[1:length]

cols = c("black", "blue", "darkgreen", "red")

layoutmat =  matrix(1:4,ncol = 4) ;layout(layoutmat)
par(xpd=F)
for (i in 1:4){
# max_y = max( pro_WT[, 3*i+1 ],  pro_JKZ3[, 3*i+1],  pro_JKZ4[, 3*i+1],  pro_ros1[, 3*i+1], pro_newJKZ4[, 3*i+1] )
	 max_y = max (unlist(lapply(x_data, function(x) max(x[,3*i+1 ]) ) ) )
	y_lab = ""
	if(i == 1){
		y_lab = "Methylation level(%)"
	}else{
		y_lab = ""
	}
#   plot( pro_WT[,1], pro_WT[,3*i+1], type="l", col = color_WT, ylab = y_lab, ylim = c(0, 1.1*max_y ) , main = label[i], xaxt="n", cex.lab =  1.5, xlab="", cex.axis = 1.5, cex.main = 2)
	
    plot(x_data[[1]][,1], x_data[[1]][,3*i+1], type="l", col = cols[1], ylab = y_lab, ylim = c(0, 1.1*max_y ) , main = label[i], xaxt="n", cex.lab =  1.5, xlab="", cex.axis = 1.5, cex.main = 2, lwd = lwd_line )
	
	for(j in 2:length){
#	lines(  x_data[[j]][,1], x_data[[j]][,3*i+1],  col = cols[j], pch = j, type = "o", cex = 0.5)
	lines(  x_data[[j]][,1], x_data[[j]][,3*i+1],  col = cols[j], pch = j, type = "l", cex = 0.5, lwd = lwd_line)
	}
	
	abline(v = 21, lty = 2); 	abline(v = 40, lty = 2)
	axis(1, labels = c("upstream 2kb", "targets", "downstream 2kb"), at = c(11,31,51), tick =F, cex.axis = 1.3 )
}

par(xpd=NA)
legend(-160, -5.5,legend= x_lables , col = cols, lwd = 3, bty = "n",  cex = 1.2,  ncol = length) # ncol = length)

par(mar = mar_ori)
