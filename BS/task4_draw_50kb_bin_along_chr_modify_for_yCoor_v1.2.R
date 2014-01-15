# this script generate figures as following:
# put mutant and WT in the sampe figure
col0 = read.table("/Users/tang58/deep_seq_analysis/Bisulfite/work_with_Liu/dir_task_4/JKZ1_Col0_50kb_stat.txt",header=T,sep="\t")
args = commandArgs()

indir = args[5]
input = args[6]
outdir = args[7]
label = args[8]#label <=> sample
type = label ;

chr_roma = c("ChrI", "ChrII", "ChrIII", "ChrIV", "ChrV")
chrname = c("chr1", "chr2", "chr3", "chr4", "chr5")

output = paste(label, "_Methylcytosines_density_individual_context_vsWT.pdf",sep = "")


setwd(indir)
data = read.table(input,header=T,sep="\t")
setwd(outdir)
pdf(output, paper = "letter")
#pdf("try.pdf", paper = "letter")

for (i in 1:(length(chrname))) {
	chr = chrname[i];
	subdata = data[data[,1] == chr,]

#############
	subdata_col0 = col0[col0[,1] == chr,]
###############

	par (mar = c(0.2,5.2,0.2,0.2), cex.axis = 0.9 , xpd = F)
	layoutmat=matrix(data=c(1,2,3), ncol=1, nrow=3)
	layout(layoutmat)
	
	context = c("CG", "CHG", "CHH")
	cols = c("red3", "red4", "dodgerblue3" , "dodgerblue","chartreuse2", "chartreuse3")
##############
	cols_col0 = c("chartreuse2", "chartreuse3", "red3", "red4", "dodgerblue3" , "dodgerblue")
#############	
	for(j in 1:3){
	    
		current = context[j]# current context(CG/CHG/CHH)
		
		x = subdata[,c(3, 2*(j+1), 2*(j+1) + 1)]
		
#########
		x_col0 = subdata_col0[,c(3, 2*(j+1), 2*(j+1) + 1)]
###########
		max = max( x[,2:3])#max is max_y
		maxx = max(x[,1])
		
		
		plot(x[,1],x[,2], type = "l", ylim = c(-max,max),xlim = c(0,maxx), col = cols[2*j], ylab = "Methylcytosines / 50 kb",
			 xlab = "", axes =F ) 
		box (which = "figure")
		lines(x[,1],x[,3]*-1, type = "l", col =cols[2*j-1])
		abline(h=0)
		legend_text1 = paste(type, current , c("(Watson)","(Crick)"),sep = " ")
		legend_text2 = paste("Col-0", current , c("(Watson)","(Crick)"),sep = " ")

		legend(maxx, max, c(legend_text1, legend_text2) ,col = c(cols[2*j], cols[2*j - 1], cols_col0[2*j], cols_col0[2*j - 1])
			   ,cex = 0.8, lty = 1,bty = "n" , xjust = 1, yjust = 1 , ncol = 1)
		lines(c(maxx - 999999,maxx),c(-max - 10, -max - 10) , lwd = 3)
		
#############################
		lines(x_col0[,1],x_col0[,2], type = "l", col =cols_col0[2*j])
		lines(x_col0[,1],x_col0[,3]*-1, type = "l", col = cols_col0[2*j - 1])
###########################
		
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