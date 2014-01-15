# barplot for nucleitide distribution
#this is version 1.1
# for position distribution, the ylim should be a little above the max.

args = commandArgs()
#base_dist = read.table("base_dist.txt" ,header =T, sep ="\t")
#pos_dist = read.table("tail.txt" ,header =T, sep ="\t")
#len_dist = read.table("length_dist.txt" ,header =T, sep ="\t")

#pre = args[5]
#jpeg("len_dist.jpeg",width = 1300)

indir = args[5]
input = args[6]
outdir = args[7]
output = args[8]
label = args[9]
main_cov = paste("distribution_of_coverage_level",label,sep="\n")
output_per = paste(label,"_methylated_percentage.jpg",sep="")
main_per = paste("methylated percentage at each coverage level",label,sep="\n")

setwd(indir);

y = read.table(input,header=T , sep="\t")

setwd(outdir)
jpeg(filename = output,width = 800)
y30 = sum(y[ y[,1] >= 30,2])
barplot(c(y[y[,1] < 30,2] , y30),space = 0.2,col = "blue", names.arg = c(y[y[,1] < 30,1], ">=30") , main = main_cov, xlab = "coverage level", ylab = "frequency")
dev.off()

jpeg(filename = output_per,width = 800)
met30 = sum(y[ y[,1] >= 30,3])	
max = max(y[ y[,1] < 30,3]/y[y[,1] < 30,2] * 100, met30/y30 *100)
barplot(c(y[ y[,1] < 30,3]/y[y[,1] < 30,2] * 100, met30/y30 *100), space = 1,width = 10,col = "blue", names.arg = c(y[y[,1] < 30,1], ">=30") , main = main_per, ylim=c(0,max + 5) , ylab = "%"
,xlab = "coverage level")
dev.off()

# y50 = sum(y[ y[,1] >= 50,2])
# met50 = sum(y[ y[,1] >= 50,3])
#barplot(c(y[1:50,3]/y[1:50,2] * 100, met50/y50 *100), space = 1,width = 10,col = "blue", names.arg = c(0:49, ">=50") , main = "distribution_of_coverage", ylim=c(0,100) , ylab = "%")

#setwd("/Users/tang58/deep_seq_analysis/Bisulfite/work_with_Liu/downstream")
#len_dist = read.table("JKZ13_phd_coverage_info_perl.txt",head=T)
#y= len_dist
#y30 = sum(y[ y[,1] >= 30,2])
#barplot(c(y[y[,1] < 30,2] , y30),space = 2,width = 1,col = "blue", names.arg = c(y[y[,1] < 30,1], ">=30"))

###############################
if(FALSE){
#par(new=T)
#plot(chr1[,2],chr1[,5]*-1, type = "l")
	setwd("/Users/tang58/deep_seq_analysis/Bisulfite/work_with_Liu/dir_task_4")
	JK1 = read.table("JKZ1_Col0_50kb_stat.txt",header=T,sep="\t")
	chr1 = JK1[  JK1[,1] == "chr1",]
	
	plot(chr1[,2],chr1[,4], type = "l", ylim = c(-1100,1100), col = "red3", ylab = "Methylcytosines / 50 kb", xaxt = "n", xlab = "" )
	lines(chr1[,2],chr1[,5]*-1, type = "l", col ="red4")
	abline(h=0)
legend(maxx, max, c("+","-"),col = c("red3", "red4"),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1)
lines(c(maxx - 999999,maxx),c(-max - 10, -max - 10) , lwd = 3)
	text(maxx - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
#legend("top", c("+","-"),col = c("red3", "red4"),cex = 0.8, lty = 1)
	
	
	
	jpeg("try.jpg", width = 15, height = 20, units = "in",res=300)
	chrname = c("chr1", "chr2", "chr3", "chr4", "chr5")

	
	
	layoutmat=matrix(data=c(1,2,3,4,5), ncol=1, nrow=5)
	layout(layoutmat)
		
	for (i in 1:(length(chrname))) {
		chr = chrname[i];
		x = JK1[  JK1[,1] == chr,]
		
		max = max( x[,4:9])
		maxx = max(x[,3])
		
		plot(x[,2],x[,4], type = "l", ylim = c(-max,max), col = "red3", ylab = "Methylcytosines / 50 kb", xaxt = "n", xlab = "" )
		lines(x[,2],x[,5]*-1, type = "l", col ="red4")
		abline(h=0)
		legend(maxx, max, c("+","-"),col = c("red3", "red4"),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1)
		lines(c(maxx - 999999,maxx),c(-max - 10, -max - 10) , lwd = 3)
		text(maxx - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
		lines(x[,2],x[,6], type = "l", col ="dodgerblue3")
		lines(x[,2],x[,7]*-1, type = "l", col ="dodgerblue")
		lines(x[,2],x[,8], type = "l", col ="gold")
		lines(x[,2],x[,9]*-1, type = "l", col ="lightgoldenrod")
	}
	
	dev.off()
	
	for (chr in 1:(length(chrsize$V1))) {
		
		chrname=chrsize$V1[chr]
		
		plot(data$V2[data$V1[]==chrname], data$V5[data$V1[]==chrname], ylim=c((-1)*max,max), xlim=c(0, max(chrsize$V2)), type="l", axes=F, xlab=paste("Chromosome ", chrname, sep=""), ylab="",)
		
		labels=c(1, seq(ls, chrsize$V2[chrsize$V1[]==chrname], by=ls), chrsize$V2[chrsize$V1[]==chrname])
		axis(1, label=labels, at=labels)
		axis(2, las=1, labels=c("-1", "0", "1"), at=c((-1)*max, 0, max))
	}
	
	
	chrname = c("chr1", "chr2", "chr3", "chr4", "chr5")
	max_len = max(JK1[,3])
	
	jpeg("try.jpg", width = 15, height = 20, units = "in",res=300)
	
#par(fig = c(0,1,0,1) )
	
#par( xaxs = "e")

	type = "rdd";
	
	par (mar = c(0.2,5.2,0.2,0.2))
	layoutmat=matrix(data=c(1,2,3,4,5), ncol=1, nrow=5)
	layout(layoutmat)
#par(fig = c(0,1,0,1) )
	for (i in 1:(length(chrname))) {
		chr = chrname[i];
		x = JK1[  JK1[,1] == chr,]
		
		max = max( x[,4:9])
		maxx = max(x[,3])
		
		ylab = paste(chr, "Methylcytosines / 50 kb", sep ="\n")
		
		plot(x[,2],x[,4], type = "l", ylim = c(-max,max),xlim = c(0,max_len), col = "red3", ylab = ylab, xlab = "", axes =F ) #xaxt = "n", bty = "n" (no box) box()
		box (which = "figure")
		lines(x[,2],x[,5]*-1, type = "l", col ="red4")
		abline(h=0)
#legend(0, max, c("+","-"),col = c("red3", "red4"),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1)
		
legend(max_len, max, paste(type, c("CG (Watson)","CG (Crick)","CHG (Watson)","CHG (Crick)","CHH (Watson)","CHH (Crick)"),sep = " ") ,col = c("red3", "red4", "dodgerblue3" , "dodgerblue","chartreuse2", "chartreuse3"
																																	   ),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1 , ncol = 3)
		lines(c( - 999999,0),c(-max - 10, -max - 10) , lwd = 3)
		text( - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
		lines(x[,2],x[,6], type = "l", col ="dodgerblue3")
		lines(x[,2],x[,7]*-1, type = "l", col ="dodgerblue")
		lines(x[,2],x[,8], type = "l", col = "chartreuse2")#"gold"
		lines(x[,2],x[,9]*-1, type = "l", col = "chartreuse3")#"lightgoldenrod"
		
#	labels=c(1, seq(ls, chrsize$V2[chrsize$V1[]==chrname], by=ls), chrsize$V2[chrsize$V1[]==chrname])
		labels = seq(-1000, 1000, by = 200)
		axis(2, las=1, labels=labels, at=labels)

	}
	
	dev.off()
	
}








######################################

chr_roma = c("ChrI", "ChrII", "ChrIII", "ChrIV", "ChrV")


pdf("try.pdf", paper = "letter")
for (i in 1:(length(chrname))) {
	chr = chrname[i];
	subdata = data[  data[,1] == chr,]
	
#	outfile = paste(label, chr, "density.jpg", sep = "_")
	
#jpeg (outfile,width = 15, height =12, units = "in",res=300)
	par (mar = c(0.2,5.2,0.2,0.2))
	layoutmat=matrix(data=c(1,2,3), ncol=1, nrow=3)
	layout(layoutmat)
	
	context = c("CG", "CHG", "CHH")
	cols = c("red3", "red4", "dodgerblue3" , "dodgerblue","chartreuse2", "chartreuse3")
	
	for(j in 1:3){
	    
		current = context[j]# current context(CG..)
		
		x = subdata[,c(3, 2*(j+1), 2*(j+1) + 1)]
		
		max = max( x[,2:3])#max os max_y
		maxx = max(x[,1])
		
#		ylab = paste(chr, "Methylcytosines / 50 kb", sep ="\n")
		
#	plot(x[,1],x[,2], type = "l", ylim = c(-max,max),xlim = c(0,max_len), col = cols[2*j], ylab = ylab, xlab = "", axes =F ) #xaxt = "n", bty = "n" (no box) box()
		plot(x[,1],x[,2], type = "l", ylim = c(-max,max),xlim = c(0,maxx), col = cols[2*j], ylab = "Methylcytosines / 50 kb", xlab = "", axes =F ) #xaxt = "n", bty = "n" (no box) box()
		box (which = "figure")
		lines(x[,1],x[,3]*-1, type = "l", col =cols[2*j-1])
		abline(h=0)
		
		legend(maxx, max, paste(type, current , c("(Watson)","(Crick)"),sep = " ") ,col = c(cols[2*j], cols[2*j - 1]),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1 ,)
		
#lines(c( - 999999,0),c(-max - 10, -max - 10) , lwd = 3)
#		text( - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))

		lines(c(maxx - 999999,maxx),c(-max - 10, -max - 10) , lwd = 3)
		text(maxx - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
		
		text( - 50000, max * 0.8, chr_roma[i]  , adj = c(0.5,0))
		
		
		
		
		labels = seq(-1000, 1000, by = 200)
		axis(2, las=1, labels=labels, at=labels)
		
	}	
	
#	dev.off()
}

dev.off()