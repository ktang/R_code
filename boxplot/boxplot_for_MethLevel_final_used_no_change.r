setwd("~/misc/edm2/P005/new_200_50_100_2_5/downstream/overlap/for_overlap/R_files")

A = read.table("ibm1-4_hyper_overlap_rdd_nonoverlap_with_all3_rdd_detail_for_R_detail_used.txt",head=T,sep="\t")
B = read.table("sk460A_edm2_hyper_overlap_rdd_nonoverlap_with_all3_rdd_detail_for_R_detail_used.txt", head=T,sep="\t" )
both = read.table("sk460A_edm2_hyper_overlap_rdd_hyper_ibm1-4_rdd_both_hyper_only_rdd_detail_for_R_detail_used.txt", head=T,sep="\t"  )


cols_db =  c( rgb( 153, 153, 153, maxColorValue = 255), rgb( 51, 102, 255, maxColorValue = 255), 
rgb( 255, 102,0, maxColorValue = 255 ), 
#rgb( 255,0 , 255, maxColorValue = 255), 
rgb( 0, 255, 255, maxColorValue = 255)  )

mar_ori = par("mar")


#png("edm2_rdd_overlape_part_fig.png", width = 3.8, height = 3.5, units = "in", res = 100, pointsize =8 );

width_val = 3.8; height_val = 3.5; units_val = "in"; res_val = 100; pointsize_val =8; 

file_name = paste("edm2_rdd_overlape_part_fig_w", height_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
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

boxplot(x[,"wt_CG_per"] ,x[,"sk460A_edm2_CG_per"],x[,"ibm1.4_CG_per"], x[,"rdd_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();
boxplot(x[,"wt_CHG_per"] ,x[,"sk460A_edm2_CHG_per"],x[,"ibm1.4_CHG_per"], x[,"rdd_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val, las = las_val  ); box();
boxplot(x[,"wt_CHH_per"] ,x[,"sk460A_edm2_CHH_per"],x[,"ibm1.4_CHH_per"], x[,"rdd_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val ); box();

x = both

boxplot(x[,"wt_CG_per"] ,x[,"sk460A_edm2_CG_per"],x[,"ibm1.4_CG_per"], x[,"rdd_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"wt_CHG_per"] ,x[,"sk460A_edm2_CHG_per"],x[,"ibm1.4_CHG_per"], x[,"rdd_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"wt_CHH_per"] ,x[,"sk460A_edm2_CHH_per"],x[,"ibm1.4_CHH_per"], x[,"rdd_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();

x= B;
boxplot(x[,"wt_CG_per"] ,x[,"sk460A_edm2_CG_per"],x[,"ibm1.4_CG_per"], x[,"rdd_CG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val ); 
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"wt_CHG_per"] ,x[,"sk460A_edm2_CHG_per"],x[,"ibm1.4_CHG_per"], x[,"rdd_CHG_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();
boxplot(x[,"wt_CHH_per"] ,x[,"sk460A_edm2_CHH_per"],x[,"ibm1.4_CHH_per"], x[,"rdd_CHH_per"], outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, col = cols_db[1:num], axes = axes_val );
axis(side = side_val, at = at_trick, labels = labels_val2, lwd = lwd_axis_val, cex.axis = cex_axis_val ); box();

par(xpd=NA)
legend(-8, -12,legend= c("Col-0", expression(italic("edm2")), expression(italic("ibm1-4")),  expression(italic("rdd")) ) , 
col = cols_db[1:num],
bty = "n", 
cex = 2,  ncol = num, 
pch =15, 
pt.cex = 5,
#lwd = 5,
#fill =cols_db[1:num] ,
border  =cols_db[1:num] 
) # ncol = length)#lwd = 5, 

par(mar = mar_ori)

dev.off()
############################################################################################################################################
######################################################################
######################################################################

