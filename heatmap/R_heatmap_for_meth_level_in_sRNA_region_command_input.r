# us letter 8.5 X 11 inch
# R --slave --vanilla --args  indir input_file_name  output_pre < R_cmd.r

args = commandArgs( trailingOnly =  T)  

lwd_line = 1;#0.8 # 2

indir        = args[1]
file_name	 = args[2]
#outdir		 = args[3]
png_pre		 = args[3]


#myCol = colorRampPalette( c("blue","cyan","yellow", "red") )(100)

#myCol = colorRampPalette(c("white","green","green4","violet","purple"))(100)

#myBreaks = seq(0, 40, by = 2) #-5:6
#myCol = colorRampPalette(c( "white","cadetblue1",  "blue1", "blue4","red" ))(40) # set2
#myCol = colorRampPalette(c( "darkslategray2", "cadetblue4",  "blue2", "blue4"))(40)

myBreaks = seq(0, 100, by = 5) #-5:6
myCol = colorRampPalette(c( "white","dodgerblue3" ,"blue1" ,   "blue4" , "midnightblue","coral1", "red1", "red3", "red4", "darkred" ))(20)

#######
# all 40
##########

setwd(indir)
x = read.table(file_name ,head=T)

library(gplots)

width_val = 6# 3.8; 
#height_val = 2.5;
height_val = 6
units_val = "in"; res_val = 500; pointsize_val =8;


cex_lab_val = 2 #cex.lab =  1.5, 
cex_axis_val = 1.5; #cex.axis = 1.5, 
cex.main = 2

las_val = 1; # axis labels horizontal or vertical

#setwd(outdir)
file_name = paste(png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

#mar_ori = par("mar")
#par(oma = c(5, 5, 1, 0) ) #down left up rigth
#par(mar= rep(2, 4))

#par(mar = c(15, 4, 4, 2)) # nothing
par(oma = c(7, 3, 1, 0) )

x = x [, c(  "raw_wmCG_colA_nodupl2",  "raw_wmCG_rrp6L1.2A_nodupl",  "raw_wmCG_nrpd1.3A_nodupl",  "raw_wmCG_nrpe1.11A_nodupl", 
"raw_wmCHG_colA_nodupl2", "raw_wmCHG_rrp6L1.2A_nodupl", "raw_wmCHG_nrpd1.3A_nodupl", "raw_wmCHG_nrpe1.11A_nodupl", 
"raw_wmCHH_colA_nodupl2", "raw_wmCHH_rrp6L1.2A_nodupl", "raw_wmCHH_nrpd1.3A_nodupl", "raw_wmCHH_nrpe1.11A_nodupl"
)]

x = as.matrix(x)

#print (max(x[ !is.na(x) ]))
#print ( summary(x) )



#heatmap.2( x [ , c( "wmCHH_wt", "wmCHH_ago6ago4" , "wmCHH_ago4", "wmCHH_ago6", "wmCHH_nrpd1.3A_nodupl", "wmCHH_nrpe1.11A_nodupl" ) ], 
heatmap.2( x [, c(  "raw_wmCG_colA_nodupl2",  "raw_wmCG_rrp6L1.2A_nodupl",  "raw_wmCG_nrpd1.3A_nodupl",  "raw_wmCG_nrpe1.11A_nodupl", 
					"raw_wmCHG_colA_nodupl2", "raw_wmCHG_rrp6L1.2A_nodupl", "raw_wmCHG_nrpd1.3A_nodupl", "raw_wmCHG_nrpe1.11A_nodupl", 
					"raw_wmCHH_colA_nodupl2", "raw_wmCHH_rrp6L1.2A_nodupl", "raw_wmCHH_nrpd1.3A_nodupl", "raw_wmCHH_nrpe1.11A_nodupl"
				 )],
scale="none", Rowv=NA, Colv=NA,
col = myCol, ## using your colors
breaks = myBreaks, ## using your breaks
dendrogram = "none",  ## to suppress warnings
margins=c(5,5), cexRow=0.5, cexCol=1.0, key=TRUE, keysize=1.5,
trace="none",
rowsep = c(0,dim(x)[1]),
colsep = 1:dim(x)[2],
sepcolor="black",
sepwidth=c(0.05 , 0.05)
,density.info= "none"
)

dev.off()

