#modified from 
#/Users/tang58/misc/Huiming_Zhang/13_Feb15_rrp6L1_smallRNA/heatmap/new_exp50_fold2_low_value_as_0/Mar7_R_cmd.r
##########
#  heat map ( "20 to 25 siRNA") for all 852 DMR loci;
# 2261 DMR_20_25
#########################
#library(gplots)
#setwd("/Users/tang58/misc/Huiming_Zhang/13_Feb15_rrp6L1_smallRNA/heatmap/426loci")
#wt = read.table("rrp6L1_hypo_852loci_sRNA_detail_in_WT_20_25bp.txt",head=T)
#rrp = read.table("rrp6L1_hypo_852loci_sRNA_detail_in_rrp6L1_20_25bp.txt", head=T)

# R --slave --vanilla --args  input_WT label_WT  input_mut label_mut  output_pre < R_script
args = commandArgs( trailingOnly =  T)  

wt_file   = args[1]
wt_name  = args[2]
mut_file  = args[3]
mut_name = args[4]

png_pre = args[5]

#png_pre = "rrp6l1_574_specific_loci_sRNA_all"
width_val = 8 # 3.8; 
height_val = 9;
units_val = "in"; res_val = 500; pointsize_val =8;

library(gplots)
#setwd("/Users/tang58/misc/Huiming_Zhang/Paper_methods/re_generate_fig/fig3D")
#wt_all = read.table("rrp6l1_2261_hypo_loci_sRNA_detail_in_HMWT.txt", head=T)
#rrp_all = read.table("rrp6l1_2261_hypo_loci_sRNA_detail_in_rrp6l1.txt", head=T)

#wt_all  = read.table("574_loci_specific2rrp6l1-2_sRNA_detail_in_HMWT.txt", head=T)
#rrp_all = read.table("574_loci_specific2rrp6l1-2_sRNA_detail_in_rrp6l1.txt", head=T)
wt_all = read.table( wt_file, head=T)
rrp_all = read.table(mut_file, head=T)

#x = cbind ( rrp_all[, c( "X20bp_HNA_HM_WT", "X21bp_HNA_HM_WT", "X22bp_HNA_HM_WT", "X23bp_HNA_HM_WT", "X24bp_HNA_HM_WT", "X25bp_HNA_HM_WT")], 
#			wt_all [, c( "X20bp_HNA_rrp6l1", "X21bp_HNA_rrp6l1", "X22bp_HNA_rrp6l1", "X23bp_HNA_rrp6l1", "X24bp_HNA_rrp6l1", "X25bp_HNA_rrp6l1")])


base_seq = 18:32

#rrp_label = paste("X",base_seq, "bp_HNA_rrp6l1",sep="")
#wt_label  = paste("X",base_seq, "bp_HNA_HM_WT",sep="")

rrp_label = paste("X",base_seq, "bp_HNA_",mut_name,sep="")
wt_label  = paste("X",base_seq, "bp_HNA_", wt_name,sep="")

#x = cbind ( rrp_all[, c( "X20bp_HNA_rrp6l1", "X21bp_HNA_rrp6l1", "X22bp_HNA_rrp6l1", "X23bp_HNA_rrp6l1", "X24bp_HNA_rrp6l1", "X25bp_HNA_rrp6l1")], 
#			 wt_all [, c( "X20bp_HNA_HM_WT", "X21bp_HNA_HM_WT", "X22bp_HNA_HM_WT", "X23bp_HNA_HM_WT", "X24bp_HNA_HM_WT", "X25bp_HNA_HM_WT")])

x = cbind ( rrp_all[, rrp_label],
			wt_all [, wt_label])

#x = cbind( rrp[,2:7], wt[,2:7] )
#x50 = x [ x[,6] + x[,12] >= 50  ,]
#x = x [ x[,5] + x[,11] >= 50 & x[,5]/x[,11]<=0.5 , ]
dim(x)

length = length(rrp_label)

#sum = data.frame( x[,1] + x[,7] )
sum = data.frame( x[,1] + x[, length + 1] )

#for (i in 2:6) {
#	sum = cbind(sum, x[,i] + x[,i+6]) 
#}
for (i in 2:length) {
	sum = cbind(sum, x[,i] + x[,i+ length]) 
}

#colnames(sum )= 20:25
colnames(sum )= base_seq

#fold = data.frame(  x[,1] / x[, 7 ] )
fold = data.frame(  x[,1] / x[, length + 1 ] )

#for (i in 2:6) {
#	fold = cbind(fold, x[,i] / x[, i+6 ] )
#}
for (i in 2:length) {
	fold = cbind(fold, x[,i] / x[, i+ length ] )
}


#colnames(fold )= 20:25
colnames(fold )= base_seq

fold[ sum < 10  ] = NA
log_fold = log2(fold)
log_fold = as.matrix(log_fold)
colnames(log_fold ) = base_seq



file_name = paste( png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

par(oma = c(5, 5, 1, 0) ) #down left up rigth
par(mar= rep(2, 4))


#myCol = colorRampPalette(  c("green4","green","red","yellow")    )(11)
myBreaks = -4:4#-5:6
#myCol = colorRampPalette( c("blue","cyan","red","yellow") )(8)
myCol = colorRampPalette( c("blue","cyan","yellow", "red") )(8)

heatmap.2(log_fold, scale="none", Rowv=NA, Colv=NA,
col = myCol, ## using your colors
breaks = myBreaks, ## using your breaks
dendrogram = "none",  ## to suppress warnings
margins=c(5,5), cexRow=0.5, cexCol=1.0, key=TRUE, keysize=1.5,
trace="none",
rowsep = c(0,dim(log_fold)[1]),
colsep = 1:dim(log_fold)[2],
sepcolor="black",
sepwidth=c(0.05 , 0.05)
,density.info= "none"
)

dev.off()

