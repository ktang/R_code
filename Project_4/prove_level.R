setwd("~/Desktop/Project_4/probe_level/")

ceng0 = read.table("11level_100_probe_per_level_sorted_bychr_cutoff0.txt")

ceng0_sorted_by_signal = ceng0[order(ceng0[,4]),]


setwd("~/Desktop/Project_4/probe_level/pic_probe_level/")
jpeg("1100_random_sorted_signal_vs_mC_cutoff0_C2.jpg")
plot(1:1100,ceng0_sorted_by_signal[,7],type="h",main="1100_random_sorted_signal_vs_mC_cutoff0_C2",xlab="signal from small to large",ylab="No._of_mC")
dev.off()

jpeg("1100_random_signal_vs_mC_cutoff0_C2.jpg")
plot(ceng0[,4],ceng0[,7],main="1100_random_signal_vs_mC_cutoff0_C2",xlab="signal",ylab="No_of_mC")
dev.off()

all = read.table("33_50533302_C2_nimblegen_method_mC_cutoff0.txt")

system("date"); all_80 = read.table("33_50533302_C2_nimblegen_method_mC_cutoff80.txt");system("date")
#Thu Nov 11 14:23:39 PST 2010
#Thu Nov 11 14:24:06 PST 2010


for (i in 0:19)
{	
	x = all[all[,6] == i,]
	print(paste (i,mean(x[,4]),min(x[,4]),median(x[,4]), max(x[,4]),collapse="\t\t\t"))
	
}

for (i in 0:17)
{	
	x = all_80[all_80[,6] == i,]
	print(paste (i,mean(x[,4]),min(x[,4]),median(x[,4]), max(x[,4]),collapse="\t"))
	
}