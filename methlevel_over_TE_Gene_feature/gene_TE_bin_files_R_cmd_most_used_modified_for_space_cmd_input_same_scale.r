#setwd("/Volumes/My_Book/Heng_Zhang/GSE16071/results/2_June15/1/Gene")
# us letter 8.5 X 11 inch
width_val = 8# 3.8; 
height_val = 2.5;
units_val = "in"; res_val = 100; pointsize_val =8;

# R --slave --vanilla --args  png_pre dir
#< /Users/tang58/scripts_all/R_scripts/methlevel_over_TE_Gene_feature/gene_TE_bin_files_R_cmd_most_used_modified_for_space_cmd_input_same_scale.r
# 1   2        3         4       5          6
args = commandArgs(trailingOnly = T)  

cex_lab_val = 2.5 #cex.lab =  1.5, 
cex_axis_val = 2; #cex.axis = 1.5, 
cex.main = 2

las_val = 1; # axis labels horizontal or vertical

#print("modify file name\n")
#file_name = paste("Chengguo_ago_gene", "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")

file_pre = args[1]
dir_use = args[2]
setwd(dir_use)

file_name = paste(file_pre, "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")

png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );



#par(mar=c(1,3,1,1)+0.1)

par(oma = c(5, 5, 1, 0) ) #down left up rigth
par(mar= rep(2, 4))



mar_ori = par("mar")

#par(mar = c(5, 6 , 4, 2) + 0.1)

print("modify label TE/GENE")

files = dir(pattern=".*in.+txt")

#print (files)

length = length(files)

x_data = list()

for (i in 1:length(files)){ x_data[[i]] = read.table(files[i], head=T, sep = "\t") }

#x_lables = sub(".*TE_.+_in_(.+)_binNum20_flaking2000bp_binNum20.txt", "\\1", files, perl =T)
#x_lables = sub(".*idm2-1_targets_in_(.+)_binNum20_flaking2000bp_binNum20.txt", "\\1", files, perl =T)
x_lables = sub(".+_in_(.+)_binNum20_flaking2000bp_binNum20.+.txt", "\\1", files, perl =T)


lwd_line = 2

label = c("CG", "CHG", "CHH", "C")

#ago4 double ago6 wt
cols_db =  c( 

rgb(153, 153, 153, maxColorValue = 255), #grey
rgb ( 222,147,142 ,maxColorValue = 255 ), #edm2 red
rgb ( 200,226, 126   ,maxColorValue = 255 ), # ibm1 green for edm2paper
rgb ( 160, 132, 200  ,maxColorValue = 255 ) # rdd purple  for edm2Paper

#rgb( 102, 255, 204, maxColorValue = 255), #light blue
#rgb( 181, 204, 82,  maxColorValue = 255),  #qing zi se

#rgb( 255, 102,0, maxColorValue = 255 ) #orange
#rgb( 255,0 , 255, maxColorValue = 255),  #pink
#rgb( 0, 255, 255, maxColorValue = 255)   #blue

)

cols = cols_db[1:length]
#cols = c("black", "blue", "darkgreen","blueviolet", "red", "pink", "lawngreen")

max_y = 0
for (i in 1:4){
	temp_max_y = max (unlist(lapply(x_data, function(x) max(x[,3*i+1 ]) ) ) )
	if(temp_max_y > max_y){
		max_y <- temp_max_y
	}
}

layoutmat =  matrix(1:4,ncol = 4) ;layout(layoutmat)

par(xpd=F)
#par(xpd=NA)

for (i in 1:4){
# max_y = max( pro_WT[, 3*i+1 ],  pro_JKZ3[, 3*i+1],  pro_JKZ4[, 3*i+1],  pro_ros1[, 3*i+1], pro_newJKZ4[, 3*i+1] )
#	 max_y = max (unlist(lapply(x_data, function(x) max(x[,3*i+1 ]) ) ) )
	
	y_lab = ""
	if(i == 1){
		y_lab = "% Methylation"
	}else{
		y_lab = ""
	}
#   plot( pro_WT[,1], pro_WT[,3*i+1], type="l", col = color_WT, ylab = y_lab, ylim = c(0, 1.1*max_y ) , main = label[i], xaxt="n", cex.lab =  1.5, xlab="", cex.axis = 1.5, cex.main = 2)
	
	par(xpd=NA)
    plot(x_data[[1]][,1], x_data[[1]][,3*i+1], type="l", col = cols[1], ylab = y_lab, ylim = c(0, 1.1*max_y ) , main = label[i], xaxt="n", cex.lab =  2.5, xlab="", cex.axis = 1.5, cex.main = 2, lwd = lwd_line, las=1 )
	par(xpd=F)
	for(j in 2:length){
#	lines(  x_data[[j]][,1], x_data[[j]][,3*i+1],  col = cols[j], pch = j, type = "o", cex = 0.5)
		lines(  x_data[[j]][,1], x_data[[j]][,3*i+1],  col = cols[j], pch = j, type = "l", cex = 0.5 , lwd = lwd_line )
	}
	
	abline(v = 21, lty = 2); 	abline(v = 40, lty = 2)
	axis(1, labels = c("+2kb", "Gene", "-2kb"), at = c(11,31,51), tick =F, cex.axis = 1.3)
}


par(xpd=NA)
legend(-200, -6,legend= x_lables , col = cols, lwd = 3, bty = "n",  cex = 2
,   ncol = length,
			
) # ncol = length)

par(mar = mar_ori)

dev.off()
