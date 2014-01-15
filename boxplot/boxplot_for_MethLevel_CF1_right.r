#setwd("/Users/tang58/misc/Chaofeng_Huang/20121007_rdm16/fig/1_vs_ros1-1_hypo/for_R/")

A = read.delim("rdm16ros1-1A_vs_ros1_1_CF_hypo_only_not_overlap_ros1_1nrpd1A_vs_ros1_1_CF_hypo_C24_WT_CF_detail_ros1_1nrpd1A_detail.txt",head=T,sep="\t")
both = read.delim("rdm16ros1-1A_vs_ros1_1_CF_hypo_overlap_ros1_1nrpd1A_vs_ros1_1_CF_hypo_C24_WT_CF_detail_ros1_1nrpd1A_detail.txt", head=T,sep="\t"  )
B = read.delim("ros1_1nrpd1A_vs_ros1_1_CF_hypo_only_not_overlap_rdm16ros1-1A_vs_ros1_1_CF_hypo_C24_WT_CF_detail_rdm16ros1_1A_detail.txt", head=T,sep="\t" )


cols_db =  c( rgb( 153, 153, 153, maxColorValue = 255), rgb( 51, 102, 255, maxColorValue = 255), 
rgb( 255, 102,0, maxColorValue = 255 ), 
#rgb( 255,0 , 255, maxColorValue = 255), 
rgb( 0, 255, 255, maxColorValue = 255)  )

mar_ori = par("mar")


#png("edm2_rdd_overlape_part_fig.png", width = 3.8, height = 3.5, units = "in", res = 100, pointsize =8 );

width_val = 3.8; height_val = 3.5; units_val = "in"; res_val = 100; pointsize_val =8; 

file_name = paste("Chaofeng_rdm16_fig1_right", "_h" , height_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

#par(mar=c(1,3,1,1)+0.1)

par(mar= rep(0.5, 4))

par(oma = c(4, 3.5, 0, 0) )

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

las_val     = 1;

cex_axis_val  = 2; #1.3 OK

num = 4;

layoutmat =  matrix(1:9,ncol = 3) ;

layout(layoutmat)

x = A;

boxplot(x[,"C24_WT_CF_CG_per"] ,x[,"CF_ros1_1_CG_per"],x[,"rdm16ros1_1A_CG_per"], x[,"ros1_1nrpd1A_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();
boxplot(x[,"C24_WT_CF_CHG_per"] ,x[,"CF_ros1_1_CHG_per"],x[,"rdm16ros1_1A_CHG_per"], x[,"ros1_1nrpd1A_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val, las = las_val  ); box();
boxplot(x[,"C24_WT_CF_CHH_per"] ,x[,"CF_ros1_1_CHH_per"],x[,"rdm16ros1_1A_CHH_per"], x[,"ros1_1nrpd1A_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();

x = both

boxplot(x[,"C24_WT_CF_CG_per"] ,x[,"CF_ros1_1_CG_per"],x[,"rdm16ros1_1A_CG_per"], x[,"ros1_1nrpd1A_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"C24_WT_CF_CHG_per"] ,x[,"CF_ros1_1_CHG_per"],x[,"rdm16ros1_1A_CHG_per"], x[,"ros1_1nrpd1A_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"C24_WT_CF_CHH_per"] ,x[,"CF_ros1_1_CHH_per"],x[,"rdm16ros1_1A_CHH_per"], x[,"ros1_1nrpd1A_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();

x= B;
boxplot(x[,"C24_WT_CF_CG_per"] ,x[,"CF_ros1_1_CG_per"],x[,"rdm16ros1_1A_CG_per"], x[,"ros1_1nrpd1A_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"C24_WT_CF_CHG_per"] ,x[,"CF_ros1_1_CHG_per"],x[,"rdm16ros1_1A_CHG_per"], x[,"ros1_1nrpd1A_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"C24_WT_CF_CHH_per"] ,x[,"CF_ros1_1_CHH_per"],x[,"rdm16ros1_1A_CHH_per"], x[,"ros1_1nrpd1A_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();

par(xpd=NA)
legend(-10, -12,legend= c("C24 WT", expression(italic("ros1")), expression(italic("rdm16ros1")),  expression(italic("nrpd1ros1")) ) , 
col = cols_db[1:num],
bty = "n", 
cex =  1.7, #2 
ncol = num, 
pch =15, 
pt.cex = 5, #5
#lwd = 5,
#fill =cols_db[1:num] ,
border  =cols_db[1:num] 
) # ncol = length)#lwd = 5, 

par(mar = mar_ori)

dev.off()
############################################################################################################################################
######################################################################
######################################################################

