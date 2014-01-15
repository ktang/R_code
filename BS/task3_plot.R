# barplot for nucleitide distribution
#this is version 1.1
# for position distribution, the ylim should be a little above the max.
args = commandArgs()

dir = args[5]
input = args[6]
label = args[7]

out = paste(label,"_correlation.jpg",sep="")

setwd(dir)

x = read.table(input,header=T,sep="\t")

cor = cor (x[,4],x[,5])

max = max(x[,c(4,5)])

cor_text = paste("Pearson's correlation coefficient",round(cor, digits = 2),sep=" = ")

main = paste (label,cor_text,sep ="\n")

jpeg(out)

plot(x[,4],x[,5], type ="p",pch=46, xlim = c(0,max), ylim =c(0,max), main=main , xlab = names(x)[4], ylab = names(x)[5])
z=line(x[,4],x[,5])
abline(coef(z))
dev.off()


if(FALSE){
	cor = cor (x[,4],x[,5])
	
	max = max(x[,c(4,5)])

	
	cor_text = paste("Pearson's correlation coefficient",round(cor, digits = 2),sep=" = ")
	main = paste (label,cor_text,sep ="\n")
	plot(x[,4],x[,5], type ="p",pch=46, xlim = c(0,max), ylim =c(0,max), main=main , xlab = names(x)[4], ylab = names(x)[5])
	z=line(x[,4],x[,5])
	abline(coef(z))

}