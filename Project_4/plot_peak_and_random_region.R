#read file
setwd("~/Desktop/Project_4/TAMALg_result/")
x0 = read.table("C2_myout_L2L3_merged_149regions_trimmean_ecker_strand_specific_cutoff_0.txt")
x80 = read.table("C2_myout_L2L3_merged_149regions_trimmean_ecker_strand_specific_cutoff_80.txt")

setwd("~/Desktop/Project_4/random_data");

rand1000_80 = read.table("random_region_1000_575_Nov10_1033_cutoff80_C2_ecker.txt");

rand149_80 = read.table("random_region_150_575_Nov9_2009_sorted_cutoff80_C2.txt");

#set output directory
setwd("./pic/")

##for x80    trimmean = 1.5-2.113  mC =0- 51  percentage = 0-0.677
# for rand1000_80  -1.61-0.677          0-42        0-0.388
#


plot(x80[,4],x80[,8],type = "p" ,col="red")
par(new=T);points(rand80[,4],rand80[,8])

################
# trimmean vs mC
################
jpeg("trimmean_vs_mC_cutoff80_C2.jpg")
plot(x80[,4],x80[,7],type = "p" ,xlim=c(-1.7,2.2),col="red", main="trimmean_vs_mC_cutoff80_C2",xlab="trimmean",ylab="No. of methylated C")
par(new=T);points(rand1000_80[,4],rand1000_80[,7])
dev.off()


#######################
#trimmean vs percentage
#######################
jpeg("trimmean_vs_percentage_cutoff80_C2.jpg")
plot(x80[,4],x80[,8],type = "p" ,xlim=c(-1.7,2.2),col="red",main="trimmean_vs_percentage_cutoff80_C2",xlab="trimmean",ylab="percentage of methylated C")
par(new=T);points(rand1000_80[,4],rand1000_80[,8])
dev.off()





############################
#sort by trimmean
#######################
rand1000_80_sorted_by_trimmean = rand1000_80[order(rand1000_80[,4]),]
jpeg(filename="sorted_trimmean_vs_mC_random_cutoff80_C2.jpg",width=1000)
plot(1:971,rand1000_80_sorted_by_trimmean[,7],type="h",main="sorted_trimmean_vs_mC_random_cutoff80_C2",xlab= "trimmean from small to large",ylab= "No. of methylated C")
dev.off()

jpeg(filename="sorted_trimmean_vs_percentage_mC_random_cutoff80_C2.jpg",width=1000)
plot(1:971,rand1000_80_sorted_by_trimmean[,8],type="h",main="sorted_trimmean_vs_%mC_random_cutoff80_C2",xlab= "trimmean from small to large",ylab= "percentage of methylated C")
dev.off()


############################
#sort by No. of mC
#######################
rand1000_80_sorted_by_mC = rand1000_80[order(rand1000_80[,7]),]

jpeg(filename="sorted_mC_vs_percentage_random_cutoff80_C2.jpg",width=1000)
 plot(1:971,rand1000_80_sorted_by_mC[,8],type="h",main="sorted_mC_vs_%mC_random_cutoff80_C2",xlab= "No. of mC from small to large",ylab= "percentage of methylated C")
dev.off()

jpeg(filename="sorted_mC_vs_percentage_random_cutoff80_C2_wide.jpg",width=1500)
plot(1:971,rand1000_80_sorted_by_mC[,8],type="h",main="sorted_mC_vs_%mC_random_cutoff80_C2",xlab= "No. of mC from small to large",ylab= "percentage of methylated C")
dev.off()


jpeg(filename="sorted_mC_vs_trimmean_random_cutoff80_C2.jpg",width=1000)
plot(1:971,rand1000_80_sorted_by_mC[,4],type="h",main="sorted_mC_vs_trimmean_random_cutoff80_C2",xlab= "No. of mC from small to large",ylab= "trimmean")
dev.off()

jpeg(filename="sorted_mC_vs_trimmean_random_cutoff80_C2_wide.jpg",width=2000)
plot(1:971,rand1000_80_sorted_by_mC[,4],type="h",main="sorted_mC_vs_trimmean_random_cutoff80_C2",xlab= "No. of mC from small to large",ylab= "trimmean")
dev.off()


__END__


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
