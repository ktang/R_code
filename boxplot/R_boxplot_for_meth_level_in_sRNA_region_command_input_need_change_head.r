# us letter 8.5 X 11 inch
# R --slave --vanilla --args  indir input_file_name  output_pre < R_cmd.r

args = commandArgs( trailingOnly =  T)  

lwd_line = 1;#0.8 # 2

indir        = args[1]
file_name	 = args[2]
#outdir		 = args[3]
png_pre		 = args[3]

#myBreaks = seq(0, 100, by = 5) #-5:6
#myCol = colorRampPalette(c( "white","dodgerblue3" ,"blue1" ,   "blue4" , "midnightblue","coral1", "red1", "red3", "red4", "darkred" ))(20)

#######
# all 40
##########

setwd(indir)


#library(gplots)

width_val = 6# 3.8; 
#height_val = 2.5;
height_val = 6
units_val = "in"; res_val = 500; pointsize_val =8;


cex_lab_val = 2 #cex.lab =  1.5, 
cex_axis_val = 1.5; #cex.axis = 1.5, 
cex.main = 2

las_val = 2; # axis labels horizontal or vertical
#0:always parallel to the axis [default],
#1:always horizontal,
#2:always perpendicular to the axis,
#3:always vertical.


outline_val = F
range_val   = 0
xaxt_val    = "s"#"n"
ylim_val    = c(0,100)
axes_val    = T#F
at_trick    = seq(0,100,20)
labels_val  = c(0, rep("",4) ,100)
labels_val2 = F
side_val    = 2;
lwd_axis_val = 1;


#setwd(outdir)
x = read.table(file_name ,head=T)

file_name = paste(png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

#mar_ori = par("mar")
#par(oma = c(5, 5, 1, 0) ) #down left up rigth
#par(mar= rep(2, 4))

#par(mar = c(15, 4, 4, 2)) # nothing
par(oma = c(7, 3, 1, 0) )

#x = x [, c(  "raw_wmCG_colA_nodupl2",  "raw_wmCG_rrp6L1.2A_nodupl",  "raw_wmCG_nrpd1.3A_nodupl",  "raw_wmCG_nrpe1.11A_nodupl", 
#"raw_wmCHG_colA_nodupl2", "raw_wmCHG_rrp6L1.2A_nodupl", "raw_wmCHG_nrpd1.3A_nodupl", "raw_wmCHG_nrpe1.11A_nodupl", 
#"raw_wmCHH_colA_nodupl2", "raw_wmCHH_rrp6L1.2A_nodupl", "raw_wmCHH_nrpd1.3A_nodupl", "raw_wmCHH_nrpe1.11A_nodupl"
#)]

#	"raw_wmCG_Col0_CF" , "raw_wmCG_rdm16.2A" , "raw_wmCG_sta1A" , "raw_wmCG_dtf1_Heng" , 
#			"raw_wmCHG_Col0_CF", "raw_wmCHG_rdm16.2A", "raw_wmCHG_sta1A" , "raw_wmCHG_dtf1_Heng", 
#			"raw_wmCHH_Col0_CF", "raw_wmCHH_rdm16.2A", "raw_wmCHH_sta1A" , "raw_wmCHH_dtf1_Heng", 
#			"raw_wmC_Col0_CF"  , "raw_wmC_rdm16.2A"  , "raw_wmC_sta1A" , "raw_wmC_dtf1_Heng"

#"raw_wmCG_Yu_Col0_35S_LUC", "raw_wmCG_P31A", #"raw_wmCG_P313A",
#"raw_wmCHG_Yu_Col0_35S_LUC", "raw_wmCHG_P31A",# "raw_wmCHG_P313A",
#"raw_wmCHH_Yu_Col0_35S_LUC", "raw_wmCHH_P31A", #"raw_wmCHH_P313A",
#"raw_wmC_Yu_Col0_35S_LUC", "raw_wmC_P31A"#, "raw_wmC_P313A"
x = x [, c(
"raw_wmCG_MG_35S_SUC2_WT", "raw_wmCG_MG91_2_mbd7",
"raw_wmCHG_MG_35S_SUC2_WT", "raw_wmCHG_MG91_2_mbd7",
"raw_wmCHH_MG_35S_SUC2_WT", "raw_wmCHH_MG91_2_mbd7",
"raw_wmC_MG_35S_SUC2_WT", "raw_wmC_MG91_2_mbd7"
)]

x = as.matrix(x)

par(xpd=NA)

boxplot(x, 
names= colnames(x),
outline = outline_val, range = range_val, xaxt = xaxt_val, ylim = ylim_val, ylab = "Methylatoin level",
#col = cols_db[1:num],
axes = axes_val , las=las_val); 
#axis(side = side_val, at = at_trick, labels = labels_val, lwd = lwd_axis_val, cex.axis = cex_axis_val , las = las_val );
box();


dev.off()