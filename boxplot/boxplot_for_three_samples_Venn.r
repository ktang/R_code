# us letter 8.5 X 11 inch
# R --slave --vanilla --args  png_pre  indir label1 2 3 < /Users/tang58/scripts_all/R_scripts/Draw_distribution_5Chr_one_line/Draw_distribution_5Chr_one_line_Cell_culture_project.R
args = commandArgs( trailingOnly =  T)  
png_pre		= args[1]
indir		= args[2]
label1		= args[3]
label2		= args[4]
label3		= args[5]

width_val = 8# 3.8; 
#height_val = 2.5;
height_val = 6 #1.5
units_val = "in"; 
pointsize_val =8;
res_val = 500;

cols_db =  c( 
rgb( 179,42,46  , maxColorValue = 255), #wt
rgb( 69,98,159 , maxColorValue = 255), #ibm1
rgb( 101,158,73 , maxColorValue = 255), #edm2, asi1
rgb( 113,48,137 , maxColorValue = 255) #rdd
)

#123

#1_only
#12_only
#13_only

#2_only
#23_only

#3_only


#all_three = read.table("asi1_ibm1_rdd_127loci.txt", head=T, sep="\t")
#main_only = read.table("asi1_only_406loci.txt", head=T, sep="\t")
#main_second = read.table("asi1_ibm1_not_rdd_2525loci.txt", head=T, sep="\t")
#main_third  = read.table("asi1_rdd_not_ibm1_214loci.txt", head=T, sep="\t")
#second_only = read.table("ibm1_only_6900loci.txt", head=T, sep="\t")
#second_third = read.table("ibm1_rdd_not_asi1_177loci.txt", head=T, sep="\t")
#third_only = read.table("rdd_only_3480loci.txt", head=T, sep="\t")
setwd(indir)
all_three_file = dir(pattern ="^123")
main_only_file = dir(pattern ="^1_only")
main_second_file = dir(pattern ="^12_only")
main_third_file = dir(pattern ="^13_only")
second_only_file = dir(pattern ="^2_only")
second_third_file = dir(pattern ="^23_only")
third_only_file = dir(pattern ="^3_only")

all_three = read.delim(all_three_file)
main_only = read.delim(main_only_file)
main_second = read.delim(main_second_file)
main_third  = read.delim(main_third_file)

second_only = read.delim(second_only_file)
second_third = read.delim(second_third_file)

third_only = read.delim(third_only_file)

setwd("..")

file_name = paste(png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );
#mar_ori = par("mar") #down left up rigth
#par(mar=c(1,3,1,1)+0.1)
par(mar= c(0.5, 1, 0.8, 1))
par(oma = c(7, 4, 3, 0) ) #fig margins
#layoutmat =  matrix(1:length_file,ncol = length_file) ;


layoutmat = matrix(1:21,nrow=3,byrow=T)
layout(layoutmat)


#############
# CG
####################
y_lim_CG = 100
cex_main_val = 0.8

CG_label = paste("wmCG", c("wt", label1, label2, label3), sep="_")



boxplot( all_three[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =2, xaxt="n",          main = "123", cex.main = cex_main_val )
boxplot( main_second[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n", main = "12", cex.main = cex_main_val )
boxplot( main_third[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" , main = "13", cex.main = cex_main_val )
boxplot( second_third[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n", main = "23", cex.main = cex_main_val)
boxplot( main_only[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n"  , main = "1" , cex.main = cex_main_val )
boxplot( second_only[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" , main = "2", cex.main = cex_main_val )
boxplot( third_only[,CG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n"  , main = "3" , cex.main = cex_main_val)


#############
# CHG
####################
y_lim_CHG = 100

CHG_label = paste("wmCHG", c("wt", label1, label2, label3), sep="_")

boxplot( all_three[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =2, xaxt="n" )
boxplot( main_second[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( main_third[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( second_third[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( main_only[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( second_only[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( third_only[,CHG_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHG) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )


#############
# CHH
####################
y_lim_CHH = 100
CHH_label = paste("wmCHH", c("wt", label1, label2, label3), sep="_")

boxplot( all_three[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =2, xaxt="n" )
boxplot( main_second[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( main_third[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( second_third[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( main_only[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( second_only[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )
boxplot( third_only[,CHH_label],  notch = T, boxwex=0.5,  ylim = c(0,y_lim_CHH) , col =cols_db[1:4], outline=FALSE, las = 2,cex.axis =0.000001, xaxt= "n" )


par(xpd=NA)
#legend ( -23, -3, legend = c("WT", expression(italic(label1)), expression(italic(label2)), expression(italic(label3)) )  ,col =cols_db[1:4],fill =cols_db[1:4],  bty = "n",  cex = 2,   ncol = 4 )#lwd = 3,
legend ( -23, -3, legend = c("WT", ((label1)), ((label2)), ((label3)) )  ,col =cols_db[1:4],fill =cols_db[1:4],  bty = "n",  cex = 2,   ncol = 4 )#lwd = 3,

dev.off()
