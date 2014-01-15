
#########################################################################
#		plot cor
#########################################################################

system("date")
setwd("/Users/kaitang/Desktop/Nimblegen/HSP/Nimblegen_figure/cor_plot")

system("date");wt = read.table("/Users/kaitang/Desktop/Nimblegen/sgr_data/Ringo_nimblegen_method/ten_individual/sorted/33_50533302_C2_nimblegen_method_sorted.sgr");system("date")
system("date");hsp = read.table("/Users/kaitang/Desktop/Nimblegen/HSP/handle_files/hsp_12_93_ave_nimblegen_method_sorted.sgr");system("date")
system("date");phd = read.table("/Users/kaitang/Desktop/Nimblegen/PHD_project_Dec2/handle_files/18_15_average.sgr");system("date")


system("date");


cor(wt[,3],phd[,3])
cor(wt[,3],hsp[,3])
cor(phd[,3],hsp[,3])

jpeg("Nim_WT_vs_phd.jpg")
plot(wt[,3],phd[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down) for phd")) ,main = "correlation coefficient = 0.93", xlim=c(-6.5,6.5),ylim=c(-4,4) )
dev.off()
system("date");

jpeg("Nim_WT_vs_hsp.jpg")
plot(wt[,3],hsp[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down) for hsp")),main = "correlation coefficient = 0.93" , xlim=c(-6,6),ylim=c(-4,4) )
dev.off()
system("date");



jpeg("Nim_phd_vs_hsp.jpg")
plot(phd[,3],hsp[,3],pch = 46, xlab = expression(paste(Log[2],"(pull-down/input) for phd")), ylab = expression (paste(Log[2],"(pull-down) for hsp")) ,main = "correlation coefficient = 0.96"  ,xlim=c(-4,4),ylim=c(-4,4));
dev.off();

# plot(1:100,1:100,pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down/input) for mutant"))   )
#correlation coefficient = 