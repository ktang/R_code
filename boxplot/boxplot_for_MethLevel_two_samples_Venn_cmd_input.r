# R --slave --vanilla --args png_pre workdir A B both l1,l2 < /Users/tang58/scripts_all/R_scripts/boxplot/boxplot_for_MethLevel_two_samples_Venn_cmd_input.r

#/Users/tang58/misc/Chengguo_Duan/12_Dec9_MG41_met18_analysis/set2_IDM1/add_overlap
#R --slave --vanilla --args MET18_boxplot_for_Sci . met18_only_Sci.txt ros1_only_Sci.txt overlap_Sci.txt MG_WT,MG41_met18,colA,JKZ3_ros1_4 < /Users/tang58/scripts_all/R_scripts/boxplot/boxplot_for_MethLevel_two_samples_Venn_cmd_input.r 

args = commandArgs( trailingOnly =  T)  

png_pre		= args[1]
workdir		= args[2]
A_file		= args[3]
B_file		= args[4]
both_file	= args[5]
all_labels	= args[6]
#workdir ="";
setwd(workdir);
#setwd("~/misc/edm2/P005/new_200_50_100_2_5/downstream/overlap/for_overlap/R_files")

A = read.table(A_file,head=T,sep="\t")
B = read.table(B_file, head=T,sep="\t" )
both = read.table(both_file, head=T,sep="\t"  )

#unlist(strsplit("a.b.c", "."))

samples = unlist(strsplit(all_labels, ","))
print(samples)


CG_label = paste("raw_wmCG_", samples, sep="")
CHG_label = paste("raw_wmCHG_", samples, sep="")
CHH_label = paste("raw_wmCHH_", samples, sep="")

cols_db =  c( rgb( 153, 153, 153, maxColorValue = 255), rgb( 51, 102, 255, maxColorValue = 255), 
rgb( 255, 102,0, maxColorValue = 255 ), 
#rgb( 255,0 , 255, maxColorValue = 255), 
rgb( 0, 255, 255, maxColorValue = 255)  )

#mar_ori = par("mar")


#png("edm2_rdd_overlape_part_fig.png", width = 3.8, height = 3.5, units = "in", res = 100, pointsize =8 );

width_val = 3.8; 
height_val = 3.5; 
units_val = "in"; 
res_val = 500;
pointsize_val =8; 

file_name = paste(png_pre,  "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

#par(mar=c(1,3,1,1)+0.1)

par(mar= rep(0.5, 4))

#par(oma = c(4, 3.5, 0, 0) )# down left up right
par(oma = c(4, 4.5, 0, 0) )

outline_val = F
range_val   = 0
xaxt_val    = "n"
ylim_val    = c(0,100)
axes_val    = F
at_trick    = seq(0,100,20)
labels_val  = c(0, rep("",4) ,100)
labels_val2 = F
side_val    = 2;
lwd_axis_val = 1;

 cex_lab_val = 1.5

las_val     = 1;

cex_axis_val  = 2; #1.3 OK

num = length(samples)#4;

layoutmat =  matrix(1:9,ncol = 3) ;

layout(layoutmat)

x = A;

par(xpd=NA)


boxplot(x[,CG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val, ylab= "CG" , cex.lab =cex_lab_val ); 
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();
boxplot(x[,CHG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val, ylab= "CHG" , cex.lab =cex_lab_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val, las = las_val  ); box();
boxplot(x[,CHH_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val, ylab= "CHH" , cex.lab =cex_lab_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();

x = both

boxplot(x[,CG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val  ); box();
boxplot(x[,CHG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val  ); box();
boxplot(x[,CHH_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val  ); box();


x= B;
boxplot(x[,CG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,CHG_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val  ); box();
boxplot(x[,CHH_label], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();


par(xpd=NA)
legend(-10, -12,legend=  samples , 
col = cols_db[1:num],
bty = "n", 
cex = 1.1,
ncol = num, 
pch =15, 
pt.cex = 3,
#lwd = 5,
#fill =cols_db[1:num] ,
border  =cols_db[1:num] 
) # ncol = length)#lwd = 5, 

#par(mar = mar_ori)

dev.off()
############################################################################################################################################
######################################################################
######################################################################

