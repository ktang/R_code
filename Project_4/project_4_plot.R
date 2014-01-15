setwd("~/Desktop/Project_4/TAMALg_result/")
x0 = read.table("C2_myout_L2L3_merged_149regions_trimmean_ecker_strand_specific_cutoff_0.txt")
x80 = read.table("C2_myout_L2L3_merged_149regions_trimmean_ecker_strand_specific_cutoff_80.txt")


jpeg(filename="trimmean_vs_per_C2_cutoff80.jpg")
plot(x80[,4],x80[,8],main = "cutoff=0.8",xlab="trimmean",ylab="percentage of methylated C")
dev.off()


jpeg(filename="trimmean_vs_per_C2_cutoff0.jpg")
plot(x0[,4],x0[,8],main = "cutoff=0",xlab="trimmean",ylab="percentage of methylated C")
dev.off()

y0 = x0[order(x0[,4]),]
jpeg("ranked_trimmean_C2_cutoff_0.jpg")
plot(1:149,y0[,8],type = "h",main="cutoff=0",xlab="trimmean from small to large",ylab="percentage of methylated C")
dev.off()


y80 = x80[order(x80[,4]),]
jpeg("ranked_trimmean_C2_cutoff_80.jpg")
plot(1:149,y80[,8],type = "h",main="cutoff=80",xlab="trimmean from small to large",ylab="percentage of methylated C")
dev.off()

z0 = x0[order(x0[,8]),]
jpeg("ranked_percentage_C2_cutoff_0.jpg")
plot(1:149,z0[,4],type = "h",main="cutoff=0",xlab="percentage from small to large",ylab="trimmean")
dev.off()


z80 = x80[order(x80[,8]),]
jpeg("ranked_percentage_C2_cutoff_80.jpg")
plot(1:149,z80[,4],type = "h",main="cutoff=80",xlab="percentage from small to large",ylab="trimmean")
dev.off()
