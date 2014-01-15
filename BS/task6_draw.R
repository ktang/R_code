#("rosybrown3","dodgerblue3","yellow3") lightgoldenrod3
args = commandArgs()

indir = args[5]
outdir = args[6]

setwd(indir)

output = paste(outdir, "/distribution_of_percentage_methylation.pdf",sep="")

pdf(output, paper="letter", width = 8 ,height = 8)
layoutmat =  matrix(1:4,ncol = 2,byrow=T)
layout(layoutmat)

for(i in 1:16){
	input = args[2*i + 5]
	sample = args[2*i + 6]
	data = read.table(input, header=T)
	sum_cg = sum(data[,2])
	sum_chg = sum(data[,3])
	sum_chh = sum(data[,4])
	cg_fra = data[,2] / sum_cg
	chg_fra = data[,3] / sum_chg
	chh_fra = data[,4] / sum_chh
	seq = seq(5,95,by = 10)
	
	plot(seq,cg_fra,type = "o", col = "yellow4", xlim = c(0,100),pch = 19, xlab = "% methylation of cytosine",
		 ylab = "Fraction of total methylcytsine" , xaxp = c(0,100,10 ) , xaxs = "i", ylim=c(0,0.6), yaxs = "i",
		   bty = "l", las = 1,cex.axis = 0.00000000000001 )
# ,xaxt = "n", axes =F , ann = F)
	lines(seq, chg_fra, type = "o", col = "dodgerblue4", pch = 15)
	lines(seq, chh_fra, type = "o", col = "rosybrown4", pch = 17)
	legend (5, 0.55, paste(sample, c("CG", "CHG", "CHH"), sep = " "), col = c("yellow4", "dodgerblue4", "rosybrown4"),
			bty = "n", pch = c(19, 15, 17) , lty = 1)

	box (which = "figure")
	
	labels_x = seq(10,100,by = 10)
	axis(1, labels = labels_x ,  at = seq ,tick = F , cex.axis = 0.9)
	labels_y = seq(0,0.6,by = 0.05)
	axis(2, las=1, labels=labels_y, at=labels_y, cex.axis = 0.9)
	
	
}

dev.off()


if(FALSE){
	pdf("ros2_distribution_of_percentage_methylation.pdf",width=8,height=4,paper="letter")
	 layout(layoutmat)
	 data = JK5
	 sample = "JKZ5_ros2"
	 sum_cg = sum(data[,2])
	 	sum_chg = sum(data[,3])
	 	sum_chh = sum(data[,4])
	 	cg_fra = data[,2] / sum_cg
	 	chg_fra = data[,3] / sum_chg
	 	chh_fra = data[,4] / sum_chh
	 	seq = seq(5,95,by = 10)
	 	
	 	plot(seq,cg_fra,type = "o", col = "yellow4", xlim = c(0,100),pch = 19, xlab = "% methylation of cytosine",
			  ylab = "Fraction of total methylcytsine" , xaxp = c(0,100,10 ) , xaxs = "i", ylim=c(0,0.6), yaxs = "i",
			  bty = "l", las = 1,cex.axis = 0.00000000000001 )
	 # ,xaxt = "n", axes =F , ann = F)
	 	lines(seq, chg_fra, type = "o", col = "dodgerblue4", pch = 15)
	 	lines(seq, chh_fra, type = "o", col = "rosybrown4", pch = 17)
	 	legend (5, 0.55, paste(sample, c("CG", "CHG", "CHH"), sep = " "), col = c("yellow4", "dodgerblue4", "rosybrown4"),
			 			bty = "n", pch = c(19, 15, 17) , lty = 1)
	 
	 	box (which = "figure")
	 	
	 	labels_x = seq(10,100,by = 10)
	 	axis(1, labels = labels_x ,  at = seq ,tick = F , cex.axis = 0.7)
	 	labels_y = seq(0,0.6,by = 0.05)
	 	axis(2, las=1, labels=labels_y, at=labels_y, cex.axis = 0.9)
	 
	 data = JK6
	 sample="JKZ6_ros2"
	 sum_cg = sum(data[,2])
	 	sum_chg = sum(data[,3])
	 	sum_chh = sum(data[,4])
	 	cg_fra = data[,2] / sum_cg
	 	chg_fra = data[,3] / sum_chg
	 	chh_fra = data[,4] / sum_chh
	 	seq = seq(5,95,by = 10)
	 	
	 	plot(seq,cg_fra,type = "o", col = "yellow4", xlim = c(0,100),pch = 19, xlab = "% methylation of cytosine",
			 		 ylab = "Fraction of total methylcytsine" , xaxp = c(0,100,10 ) , xaxs = "i", ylim=c(0,0.6), yaxs = "i",
			 		   bty = "l", las = 1,cex.axis = 0.00000000000001 )
	 # ,xaxt = "n", axes =F , ann = F)
	 	lines(seq, chg_fra, type = "o", col = "dodgerblue4", pch = 15)
	 	lines(seq, chh_fra, type = "o", col = "rosybrown4", pch = 17)
	 	legend (5, 0.55, paste(sample, c("CG", "CHG", "CHH"), sep = " "), col = c("yellow4", "dodgerblue4", "rosybrown4"),
					bty = "n", pch = c(19, 15, 17) , lty = 1)
	 
	 	box (which = "figure")
	 	
	 	labels_x = seq(10,100,by = 10)
	 	axis(1, labels = labels_x ,  at = seq ,tick = F , cex.axis = 0.7)
	 	labels_y = seq(0,0.6,by = 0.05)
	 	axis(2, las=1, labels=labels_y, at=labels_y, cex.axis = 0.9)
	 
	 dev.off()
	

}