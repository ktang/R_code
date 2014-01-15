setwd ("/Users/kaitang/Desktop/F1/new_analysis_May_15/data") #working dir
OverData <- read.table(file="pos_C24_freq_larger_than4.txt", header = TRUE, sep="\t") # load data
n<-dim(OverData) # find how many rows to process
lastGene <- "NONE"
for(i in 1:n[1]){ # read each line, do sth
    Gene <- OverData$gene[i]
    if(Gene != lastGene){ # start a new plot
        if(lastGene != "NONE"){
           dev.off()
        }
        FileName<- paste("/Users/kaitang/Desktop/F1/new_analysis_May_15/data/figs/", Gene, ".jpeg", sep="")
        jpeg(file = FileName, width = 680, height = 800) # generate a new jpeg file
       
     }else{
        par(new=TRUE)
     }
 plot(c(OverData$freq_C24_flowcell55_lane1[i], OverData$freq_C24_flowcell54_lane2[i], OverData$freq_C24_flowcell54_lane3[i], OverData$freq_C24_flowcell54_lane5[i], OverData$freq_C24_flowcell54_lane6[i], OverData$freq_C24_flowcell54_lane7[i], OverData$freq_C24_flowcell54_lane8[i], OverData$freq_C24_flowcell54_lane1[i]), type="b", main=OverData$Gene[i], xlab="", ylab="", ylim=c(0, 1)) # setup plot window
        lastGene <- Gene
     
}

dev.off();