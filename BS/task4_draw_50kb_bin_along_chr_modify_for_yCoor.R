#R --slave --vanilla --args 
#1 2        3          4
args = commandArgs()

indir = args[5]
input = args[6]
outdir = args[7]
#output = args[8]
label = args[8]#label <=> sample

output_3 = paste(label, "_Methylcytosines_density.pdf",sep = "")
output_sep = paste(label, "_Methylcytosines_density_individual_context.pdf",sep = "")

chr_roma = c("ChrI", "ChrII", "ChrIII", "ChrIV", "ChrV")

setwd(indir)

data = read.table(input,header=T,sep="\t")

setwd(outdir)



chrname = c("chr1", "chr2", "chr3", "chr4", "chr5")
max_len = max(data[,3])

#par (mar = c(0.2,5,0.2,0.2) , cex.axis = 0.8, xpd =F , fin = c(7,9))

pdf(output_3 ,paper = "letter", height = 9)
par (mar = c(0.2,5,0.2,0.2) , cex.axis = 0.8, xpd =F , fig = c(0,1,0,1))


type = label ;

layoutmat=matrix(data=c(1,2,3,4,5), ncol=1, nrow=5)
layout(layoutmat)
for (i in 1:(length(chrname))) {
	chr = chrname[i];
	x = data[  data[,1] == chr,]
	
	max = max( x[,4:9])
	maxx = max(x[,3])
	
#	ylab = paste(chr, "Methylcytosines / 50 kb", sep ="\n")
	
#	plot(x[,2],x[,4], type = "l", ylim = c(-max,max),xlim = c(0,max_len), col = "red3", ylab = ylab, xlab = "", axes =F ) #xaxt = "n", bty = "n" (no box) box()
	plot(x[,2],x[,4], type = "l", ylim = c(-max,max),xlim = c(0,max_len), col = "red3", ylab = "Methylcytosines / 50 kb" , xlab = "", axes =F ) #xaxt = "n", bty = "n" (no box) box()
	box (which = "figure")
	lines(x[,2],x[,5]*-1, type = "l", col ="red4")
	abline(h=0)
	
	mtext("Methylcytosines / 50 kb" , side = 2, adj = 0.5 , outer=T)
	
#	legend(max_len, max + 100, paste(type, c("CG (Watson)","CG (Crick)","CHG (Watson)","CHG (Crick)","CHH (Watson)","CHH (Crick)"),sep = " ") ,
#		   col = c("red3", "red4", "dodgerblue3" , "dodgerblue","chartreuse2", "chartreuse3"),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1 , ncol = 3,horiz = F)

	legend(max_len + 1500000, max + 150, paste(type, c("CG (Watson)","CHG (Watson)", "CHH (Watson)", "CG (Crick)", "CHG (Crick)","CHH (Crick)"),sep = " ") ,
		   col = c("red3", "dodgerblue3" , "chartreuse2", "red4", "dodgerblue", "chartreuse3"),cex = 0.7, lty = 1 ,bty = "n" , xjust = 1, yjust = 1 , ncol = 2,horiz = F)
	
	lines(c( - 999999,0),c(-max - 10, -max - 10) , lwd = 3)
	text( - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
	lines(x[,2],x[,6], type = "l", col ="dodgerblue3")
	lines(x[,2],x[,7]*-1, type = "l", col ="dodgerblue")
	lines(x[,2],x[,8], type = "l", col = "chartreuse2")#"gold"
	lines(x[,2],x[,9]*-1, type = "l", col = "chartreuse3")#"lightgoldenrod"
	
#labels = seq(-1000, 1000, by = 200)
	
	len200 = floor(max/300)
	seq_p = seq(0, 300 * (len200-1), by = 300) 
	seq_m = seq_p[ (len200 ):2] *-1
	
	labels = c(-max, seq_m,seq_p,max);
	axis(2, las=1, labels=labels, at=labels)
	
#	text( - 50000, max * 0.8, chr_roma[i]  , adj = c(0.5,0))
	text( - 300000, max, chr_roma[i]  , adj = c(0.5,1))

}

dev.off()


#pdf("try.pdf", paper = "letter")
pdf(output_sep, paper = "letter")


for (i in 1:(length(chrname))) {
	chr = chrname[i];
	subdata = data[  data[,1] == chr,]
	
	outfile = paste(label, chr, "density.jpg", sep = "_")
	
#	jpeg (outfile,width = 15, height =12, units = "in",res=300)
	par (mar = c(0.2,5.2,0.2,0.2), cex.axis = 0.9 , xpd = F)
	layoutmat=matrix(data=c(1,2,3), ncol=1, nrow=3)
	layout(layoutmat)
	
	context = c("CG", "CHG", "CHH")
	cols = c("red3", "red4", "dodgerblue3" , "dodgerblue","chartreuse2", "chartreuse3")
	
	for(j in 1:3){
	    
		current = context[j]# current context(CG..)
		
		x = subdata[,c(3, 2*(j+1), 2*(j+1) + 1)]
		
		max = max( x[,2:3])#max is max_y
		maxx = max(x[,1])
	
#		ylab = paste(chr, "Methylcytosines / 50 kb", sep ="\n")
	
		plot(x[,1],x[,2], type = "l", ylim = c(-max,max),xlim = c(0,maxx), col = cols[2*j], ylab = "Methylcytosines / 50 kb", 
			 xlab = "", axes =F ) 
#,outer=T) #xaxt = "n", bty = "n" (no box) box()
		
###########################
#		title(outer =T)
#########################
		
		box (which = "figure")
		lines(x[,1],x[,3]*-1, type = "l", col =cols[2*j-1])
		abline(h=0)
	
		legend(maxx, max, paste(type, current , c("(Watson)","(Crick)"),sep = " ") ,col = c(cols[2*j], cols[2*j - 1]),cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1 )
		
		lines(c(maxx - 999999,maxx),c(-max - 10, -max - 10) , lwd = 3)
		
		text(maxx - 500000, -max * 0.97, "1Mb" , adj = c(0.5,0))
		
		text( - 300000, max, chr_roma[i]  , adj = c(0.5,1))
	
	len200 = floor(max/300)
	seq_p = seq(0, 300 * (len200-1), by = 300) 
	seq_m = seq_p[ (len200 ):2] *-1
	
	labels = c(-max, seq_m,seq_p,max);
		
#	labels = seq(-1000, 1000, by = 200)
		axis(2, las=1, labels=labels, at=labels)
		
	}	
}

dev.off()
