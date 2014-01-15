# R --slave --vanilla --args  input output < /Users/tang58/scripts_all/R_scripts/draw_meth_CG_CHG_CHH/draw_meth_CG_CHG_CHH_v0.0.R

args = commandArgs( trailingOnly =  T)  


input	 = args[1]
png_pre   = args[2]

#Context	position	Col0	asi2_2	asi2_3	ros1_4	asi2_2_ros1_4
#CHH	8	0.00	0.00	0.00	83.33	0.00


x = read.table(input, head=T)

x_CG = x[ x[,1]=="CG",]
x_CHG =  x[ x[,1]=="CHG",]
x_CHH =  x[ x[,1]=="CHH",]

width_val = 8# 3.8; 
height_val = 5;
units_val = "in"; res_val = 500; pointsize_val =8;

cex_lab_val = 1.8 #cex.lab =  1.5, 
# cex_axis_val = 2; #cex.axis = 1.5, 
cex_main = 1.8

las_val = 2.5; # axis labels horizontal or vertical

lwd_val = 1.5

file_name = paste(png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

par(mar = c(0.5,0.5,0.5,0.5))

layout(matrix( c(1:(dim(x)[2]-2)), byrow = TRUE, ncol=1))
#CG, CHG and CHH methylation with black, red and blue 
for (i in 3:dim(x)[2]){
#plot(0:max(x[,2]) + 10 , 0:120, type="n", axes=FALSE, ann=FALSE)
	plot.new()
	plot.window(xlim = c(-20,max(x[,2]) + 10), ylim = c( 0,100))
	
#abline(h=0)
	segments(0,0, max(x[,2]),0, col="gray", lwd = 0.7)
	segments(x_CG[,2], 0, x_CG[,2], x_CG[,i], col = "black"  ,lwd= lwd_val)
	segments(x_CHG[,2], 0, x_CHG[,2], x_CHG[,i], col = "red" ,lwd= lwd_val)
	segments(x_CHH[,2], 0, x_CHH[,2], x_CHH[,i], col = "blue",lwd= lwd_val)
	text(-18,0, colnames(x)[i])
}

dev.off()

