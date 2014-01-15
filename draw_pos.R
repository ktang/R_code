setwd ("C:/Users/renyi/Documents/research/heterosis/pos_figures/") #working dir
OverData <- read.table(file="cleaned_pos_lib_info.txt", header = TRUE, sep="\t") # load data
n<-dim(OverData) # find how many rows to process
lastGene <- "NONE"
for(i in 1:n[1]){ # read each line, do sth
    Gene <- OverData$Gene[i]
    if(Gene != lastGene){ # start a new plot
        if(lastGene != "NONE"){
           dev.off()
        }
        FileName<- paste("C:/Users/renyi/Documents/research/heterosis/pos_figures/figs/", Gene, ".jpeg", sep="")
        jpeg(file = FileName, width = 680, height = 800) # generate a new jpeg file
       
     }else{
        par(new=TRUE)
     }
 plot(c(OverData$Freq_flowcell55_lane1[i], OverData$Freq_flowcell54_lane2[i], OverData$Freq_flowcell54_lane3[i], OverData$Freq_flowcell54_lane5[i], OverData$Freq_flowcell54_lane6[i], OverData$Freq_flowcell54_lane7[i], OverData$Freq_flowcell54_lane8[i], OverData$Freq_flowcell54_lane1[i]), type="b", main=OverData$Gene[i], xlab="", ylab="", ylim=c(0, 1)) # setup plot window
        lastGene <- Gene
     
}
