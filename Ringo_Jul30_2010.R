##this script is mainly apply batch import the raw files of the NimbleGen data
##totally 10 chips.

readin = data.frame(Files = c("50446602","50446902","50449302","50471602","50533302","50541202","50541502","50541802","50594202","50606702"),
					Samples = c("ZDP_1","Col0_1","HSP_2","ZDK_2","C0l0_2","HSP_1","PHD_2","PHD_1","rdd_2","rdd2"))


setwd("/mnt/disk4/genomes/nimblegen/analysis_Kai/raw_data")
RGs_separate = lapply(sprintf("../new_target_file/target_%d",0:9),readNimblegen,"spottypes.txt");




# load the data, RGs_separate is a list with length 10, 
# each chip is as a member.
load("RGs_separate_as_ten.rda")




# to draw the correlation plot, I should use the RGs data,
# which the two biological sample are read in to the same member.
load("RGs.rda")
for (i in 1:5)
 {
	 thisRG <- RGs[[i]]
	 	
	 	jpeg(paste(i,"_red_cor.jpg" , sep=""))
	 	layout(matrix(c(1,2),ncol=2,byrow=TRUE))
	 	
	     corPlot(log2(thisRG$R))
	 	dev.off()
}


for (i in 1:5)
 {
	 	thisRG <- RGs[[i]]
	 	
	 	jpeg(paste(i,"_green_cor.jpg" , sep=""))
		corPlot(log2(thisRG$G))
		dev.off()
 }


##preprocessing

  ##for the RGs_separate data

pre_RGs_separate_nimblegen = lapply(RGs_separate, function(x) preprocess(x[x$genes$Status == "Probe",],
method ="nimblegen"));
##19:05-19:17