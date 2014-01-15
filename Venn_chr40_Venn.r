
##########################################
#	no change
###########################################
library("VennDiagram")

width_val = 3.8; height_val = 3.5; units_val = "in"; res_val = 100; pointsize_val =8; 
file_name = paste("chr40_1a_overlap_Venn_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")

png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );
venn.plot <- draw.pairwise.venn(
area1 =     580   , 
area2 =      3773   , #3777
cross.area = 131   , 
fill = c(  	rgb( 255, 102,0, maxColorValue = 255 ),
			rgb( 51, 102, 255, maxColorValue = 255)  
		),

scaled = T,

lty = "blank",
cex = 1.8,
cat.cex = 2,
cat.pos = c(285, 105),
cat.dist = c(0.15, 0.09),
cat.just = list(c(-1, -1), c(1, 1)),
ext.pos = -20,
ext.dist = -0.08,
ext.length = 0.7,
ext.line.lwd = 2,
ext.line.lty = "dashed",
inverted = T
);

dev.off()
#	no change
###########################################



####################
# ros1-5 hyper
###########################
library("VennDiagram")

width_val = 3.8; height_val = 3.5; units_val = "in"; res_val = 100; pointsize_val =8; 
file_name = paste("chr40_ros1-5_overlap_Venn_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")

png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );
venn.plot <- draw.pairwise.venn(
area1 =     773   , 
area2 =      4758   , #3777
cross.area = 441   , 
fill = c(
  #	rgb( 255, 102,0, maxColorValue = 255 ),#orange
rgb( 255,0 , 255, maxColorValue = 255) , #pink

rgb( 51, 102, 255, maxColorValue = 255)  #blue


),

scaled = T,

lty = "blank",
cex = 1.8,
cat.cex = 2,
cat.pos = c(285, 105),
cat.dist = c(0.15, 0.09),
cat.just = list(c(-1, -1), c(1, 1)),
ext.pos = -20,
ext.dist = -0.08,
ext.length = 0.7,
ext.line.lwd = 2,
ext.line.lty = "dashed",
inverted = T
);

dev.off()





####################
# 
###########################

setwd("/Users/tang58/misc/edm2/P005/new_200_50_100_2_5/downstream");

gray_col = "gray50"
lwd_abline = 1.5
centromere =  c(15000000, 3600000 + 30427671 , 13500000 + 50125960, 3920000 + 73585790, 11700000 + 92170846)

ibm1 = read.table("ibm1_vs_colA_hyper_DMR_number_WinSize500000_sliding500000.txt", head=T);
edm2 = read.table("sk460A_edm2_vs_colA_hyper_DMR_number_WinSize500000_sliding500000.txt", head=T);
ros1 = read.table("JKZ3_ros1-4_vs_colA_hyper_DMR_number_WinSize500000_sliding500000.txt", head=T);
rdd  = read.table("JKZ18_rdd_vs_colA_hyper_DMR_number_WinSize500000_sliding500000.txt", head=T);
#my %chr_len = ("chr1"=>30427671, "chr2"=>19698289, "chr3"=>23459830, "chr4"=>18585056, "chr5"=>26975502);
#my %chr_len_cumulative = ("chr1"=> 0 , "chr2"=>30427671, "chr3"=>50125960, "chr4"=>73585790, "chr5"=>92170846);
#las always parallel to the axis
# axis(2, las=1, labels=labels, at=labels)


par(mar = c(5, 6 , 4, 2) + 0.1)
plot( ibm1[,5],ibm1[,4], type="l" , col = "blue", ylab = "Number of DMRs / 500kb", cex.lab =  1.6, xlab="Chromosome",xaxt="n", cex.axis = 1.3, cex.main = 2, lwd = 2 ) # , xlab = "Chromosome" ,
lines(edm2[,5],edm2[,4],col="red",lwd = 2 )
lines(rdd[,5],rdd[,4],col="darkgreen",lwd = 2 )
#lines(ros1[,5],ros1[,4],col="black",lwd = 2 )
par(xpd=F)
abline( v = 30427671, col = gray_col , lwd = lwd_abline )
abline( v = 50125960, col = gray_col, lwd = lwd_abline )
abline( v = 73585790, col = gray_col, lwd = lwd_abline )
abline( v = 92170846 , col = gray_col, lwd = lwd_abline )
axis(1, las=1, labels=1:5, at= centromere , cex.axis = 1.8 ,tick =F)
#legend(-160, -5.7,legend= x_lables , col = cols, lwd = 3, bty = "n",  cex = 1.2,  ncol = length) # ncol = length)
par(xpd=NA)
legend(4210340, -30, legend = c( expression(italic("ibm1")), expression(italic("edm2")), expression(italic("rdd"))  ) , col = c("blue", "red", "darkgreen")  ,lwd = 3, bty = "n",  cex = 1.2,  ncol =3 )

