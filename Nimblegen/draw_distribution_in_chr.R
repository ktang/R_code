jpeg("T5_At1g54840_uniq.datS3_o0.anno_Ex.jpg",width = 580, height = 680)

plot.new()
plot.window(xlim=c(0,6),ylim=c(-31000000,500000))

lines(c(1,1),c(0,-30427671),lwd = 10)

lines(c(2,2),c(0,-19698289),lwd = 10)

lines(c(3,3),c(0,-23459830),lwd = 10)

lines(c(4,4),c(0,-18585056),lwd = 10)

lines(c(5,5),c(0,-26975502),lwd = 10)

lines(c(1.2,1.2),c(0,-30427671))

lines(c(2.2,2.2),c(0,-19698289))

lines(c(3.2,3.2),c(0,-23459830))

lines(c(4.2,4.2),c(0,-18585056))

lines(c(5.2,5.2),c(0,-26975502))

symbols(c(1,2,3,4,5),c(-15000000,-3600000,-13500000,-3920000,-11700000),circles=c(1,1,1,1,1),add=T,inches=0.08,fg="red",bg="red")

for(i in 1:dim(x)[1])
{
#if(data[i,1] =="chr1")
#	{lines(c(1.2,1.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}

	lines(c(x[i,1]+0.2,x[i,1]+0.4),c(-x[i,2],-x[i,2]),lwd=0.8)
}

text(c(1,2,3,4,5),c(5000,5000,5000,5000,5000),labels=c(1,2,3,4,5),pos=3)
dev.off()

##################################################################################

jpeg("T5_At3g14980_uniq.datS3_o0.anno_Ex.jpg",width = 580, height = 680)
x=read.table("At3g14980.csv",sep=",")

jpeg("T5_At3g14980_uniq.datS3_o0.anno_Ex.jpg",width = 580, height = 680)
plot.new()
plot.window(xlim=c(0,6),ylim=c(-31000000,500000))

lines(c(1,1),c(0,-30427671),lwd = 10)

lines(c(2,2),c(0,-19698289),lwd = 10)

lines(c(3,3),c(0,-23459830),lwd = 10)

lines(c(4,4),c(0,-18585056),lwd = 10)

lines(c(5,5),c(0,-26975502),lwd = 10)

lines(c(1.2,1.2),c(0,-30427671))

lines(c(2.2,2.2),c(0,-19698289))

lines(c(3.2,3.2),c(0,-23459830))

lines(c(4.2,4.2),c(0,-18585056))

lines(c(5.2,5.2),c(0,-26975502))

symbols(c(1,2,3,4,5),c(-15000000,-3600000,-13500000,-3920000,-11700000),circles=c(1,1,1,1,1),add=T,inches=0.08,fg="red",bg="red")

for(i in 1:dim(x)[1])
{
#if(data[i,1] =="chr1")
#	{lines(c(1.2,1.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
	lines(c(x[i,1]+0.2,x[i,1]+0.4),c(-x[i,2],-x[i,2]),lwd=0.8)
}

text(c(1,2,3,4,5),c(5000,5000,5000,5000,5000),labels=c(1,2,3,4,5),pos=3)
dev.off()


#########################################################################
#		location distribution
#########################################################################

setwd("/Users/kaitang/Desktop/Nimblegen/Sep_20_new_analysis/result/send")


data = read.table("label_ZDP_peaks.bed")

setwd("/Users/kaitang/Desktop/Nimblegen/final_summary_Nov12")
dev.off()

jpeg("peak_pos_in_chrs.jpg",width = 580, height = 680)

plot.new()
plot.window(xlim=c(0,6),ylim=c(-31000000,500000))

lines(c(1,1),c(0,-30427671),lwd = 10)

lines(c(2,2),c(0,-19698289),lwd = 10)

lines(c(3,3),c(0,-23459830),lwd = 10)

lines(c(4,4),c(0,-18585056),lwd = 10)

lines(c(5,5),c(0,-26975502),lwd = 10)

lines(c(1.2,1.2),c(0,-30427671))

lines(c(2.2,2.2),c(0,-19698289))

lines(c(3.2,3.2),c(0,-23459830))

lines(c(4.2,4.2),c(0,-18585056))

lines(c(5.2,5.2),c(0,-26975502))

symbols(c(1,2,3,4,5),c(-15000000,-3600000,-13500000,-3920000,-11700000),circles=c(1,1,1,1,1),add=T,inches=0.08,fg="red",bg="red")

for(i in 1:dim(data)[1])
{
	if(data[i,1] =="chr1")
	{lines(c(1.2,1.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
	if(data[i,1] =="chr2")
	{lines(c(2.2,2.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
	if(data[i,1] =="chr3")
	{lines(c(3.2,3.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
	if(data[i,1] =="chr4")
	{lines(c(4.2,4.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
	if(data[i,1] =="chr5")
	{lines(c(5.2,5.4),c(-data[i,2],-data[i,2]),lwd = 0.8)}
	
}

text(c(1,2,3,4,5),c(5000,5000,5000,5000,5000),labels=c(1,2,3,4,5),pos=3)
dev.off()


#########################################################################
#		pie chart
#########################################################################

dev.off()


setwd("/Users/kaitang/Desktop/Nimblegen/final_summary_Nov12")

#jpeg("pie_TE_gene_intergenic.jpg")
#pie(c(356,39,20),labels="",col=c("green","red","yellow"),radius=1)
#text(c(-0.3,0.45,0.6),c(0.1,-0.27,-0.08),labels=c("transposon\n85.78%","gene\n9.40%","intergenic\n4.82%"))

jpeg("pie_TE_gene_intergenic_modified.jpg")
pie(c(356,20,39),labels=c("transposon\n(85.78%)","intergenic(4.82%)","gene(9.40%)"),col=c("khaki","gray","cornsilk"),radius=0.2)

dev.off()

#wrong:: text(c(-0.3,0.32,0.37),c(0.1,-0.05,-0.23),labels=c("transposon","gene","intergenic"))


#########################################################################
#		plot cor
#########################################################################
setwd("~/Desktop/Nimblegen/sgr_data/Ringo_nimblegen_method/ten_individual/sorted/")

system("date");wt = read.table("33_50533302_C2_nimblegen_method_sorted.sgr");system("date")

setwd("./average/")
system("date");zdp = read.table("label_ZDP_66_16_mean.sgr");system("date")

setwd("/Users/kaitang/Desktop/Nimblegen/final_summary_Nov12")


#jpeg("cor_WT_vs_zdp.jpg")

system("date");
jpeg("cor_WT_vs_zdp_6.5.jpg")
plot(wt[,3],zdp[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down/input) for mutant")) , xlim=c(-6.5,6.5),ylim=c(-6.5,6.5) )
dev.off()
system("date");
jpeg("cor_WT_vs_zdp_4.jpg")
plot(wt[,3],zdp[,3],pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down/input) for mutant")) , xlim=c(-4,4),ylim=c(-4,4) )
dev.off()
system("date");

# plot(1:100,1:100,pch=46,xlab=expression(paste(Log[2],"(pull-down/input) for WT")) ,ylab=expression(paste(Log[2],"(pull-down/input) for mutant"))  )