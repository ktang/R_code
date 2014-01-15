setwd("/Users/tang58/deep_seq_analysis/Bisulfite/work_with_Liu/figure")

args = commandArgs()
output = args[5]
error = args[6]
cg = as.numeric (args[7])
chg =as.numeric( args[8])
chh = as.numeric(args[9])
total = as.numeric(args[10])

title = args[11]

main_tol = paste("Total number of mC", total, sep = " = ")

main_error = paste("Convertion Error", error, sep = " = ")

main_second = paste(main_tol, main_error, sep = ", ")

main = paste(title, main_second, sep="\n" )

cgp = round(100 * cg / total )
chgp = round (100 * chg / total)
chhp = 100 -cgp - chgp 
label1 = paste("CG",paste(cgp,"%",sep=""),sep = "\n") 
label2 = paste("CHG",paste(chgp,"%",sep=""),sep = "\n") 
label3 = paste("CHH",paste(chhp,"%",sep=""),sep = "\n") 

jpeg(file = output)
#pie(c(cg,chg,chh),labels = c(label1,label2, label3),clockwise = T, main = main, col=c("khaki","gray","cornsilk"))
pie(c(cg,chg,chh),labels = c(label1,label2, label3),clockwise = T, main = main, col=c("rosybrown3","dodgerblue3","yellow3"))
#col=c("rosybrown3","dodgerblue3","yellow3")
dev.off()