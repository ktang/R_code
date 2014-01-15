
#########################################################################
#		plot cor
#########################################################################

system("date")
setwd("/Users/kaitang/Desktop/Nimblegen/PHD_project_Dec2/phd_signal/5chr_sgr")

system("date");wt = read.table("WT.sgr");system("date")
system("date");hsp = read.table("hsp_At1g53840.sgr");system("date")
system("date");phd = read.table("phd_At3g14980.sgr");system("date")

setwd("/Users/kaitang/Desktop/Nimblegen/PHD_project_Dec2/figures/cor_plot")

system("date");

jpeg("Affy_WT_vs_phd.jpg")
plot(wt[,3],phd[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down) for WT")) ,ylab=expression(paste(Log[2],"(pull-down) for phd")) ,main = "correlation coefficient = 0.96")#, xlim=c(-6.5,6.5),ylim=c(-6.5,6.5) )
dev.off()
system("date");

jpeg("Affy_WT_vs_hsp.jpg")
plot(wt[,3],hsp[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down) for WT")) ,ylab=expression(paste(Log[2],"(pull-down) for hsp")),main = "correlation coefficient = 0.95")# , xlim=c(-4,4),ylim=c(-4,4) )
dev.off()
system("date");



jpeg("Affy_phd_vs_hsp.jpg")
plot(phd[,3],hsp[,3],pch = 46, xlab = expression(paste(Log[2],"(pull-down) for phd")), ylab = expression (paste(Log[2],"(pull-down) for hsp")) ,main = "correlation coefficient = 0.96");
dev.off();

# plot(1:100,1:100,pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down/input) for mutant"))  )
#correlation coefficient = 