# R --slave --vanilla --args input1_part in2_all outdir png_pre  < R_script.r
args = commandArgs( trailingOnly =  T)  
in1_part	= args[1]
in2_all		= args[2]
outdir		= args[3]
png_pre		= args[4] 

#setwd("/Users/tang58/misc/Zhaobo_Lang/6_mbd7_91-2/May16_lab_meeting/Q4_TE_distribution/in_dir/")
#mbd7 = read.delim("mbd7_CHH_hyper_JacobsenCell_Bin100_FDR0.01_sDep4_lDep4_Cnum4_DMRs_number_WinSize500000_sliding500000_self.txt")
#te = read.delim("TAIR10_Transposable_Elements_DMRs_number_WinSize500000_sliding500000_self.txt")

mbd7 = read.delim (in1_part)
te	 = read.delim (in2_all )

sum_mbd7 = sum(mbd7[,4]) 
print ( sum(mbd7[,4]) )
#[1] 2799
sum_te =  sum(te[,4])
print ( sum(te[,4]) )
#[1] 31189

setwd(outdir)

width_val = 8# 3.8; 
height_val = 3;
units_val = "in"; res_val = 500; pointsize_val =8;

file_name = paste( png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

par(oma = c(2.3, 2.3, 1, 0) ) #par(oma = c(3, 3, 1, 0) ) #down left up rigth
par(mar = c(4, 4 , 4, 1) + 0.1)


x_data =mbd7
x_data[,4] = (mbd7[,4]/sum_mbd7)/(te[,4]/sum_te)

plot( x_data[,5] , x_data[,4] , 
#ylim = c(0, max_y),
type="l" , 
#	col = cols_db[1], 
ylab = "TE density ratio", 
font.lab = 2,
xlab = "Chromosome",

xaxt="n", 
cex.lab =  1.5, 
cex.axis = 1.5, 
cex.main = 2, 
lwd = 2,
las = 1
)
gray_col = "gray70"
lwd_abline = 1.5
abline( v = 30427671, col = gray_col , lwd = lwd_abline )
abline( v = 50125960, col = gray_col, lwd = lwd_abline )
abline( v = 73585790, col = gray_col, lwd = lwd_abline )
abline( v = 92170846 , col = gray_col, lwd = lwd_abline )
abline(h=1, col = "blue", lwd = lwd_abline )
par(xpd=NA)
text(x = c(15000000, 35027671 ,63625960 , 77505790,103870846  ), y= rep(-0.5,5) , labels = 1:5, cex = 1.5)


dev.off()