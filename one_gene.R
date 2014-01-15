setwd ("/Users/kaitang/Desktop/F1/new_analysis_May_15/May_18") #working dir
OverData <- read.table(file="cut_table_rm0_freq.txt", header = TRUE, sep="\t") # load data
n<-dim(OverData) # find how many rows to process
lastGene <- "NONE"
for(i in 1:n[1]){ # read each line, do sth
    Gene <- OverData$mRNAID[i]
    if(Gene != lastGene){ # start a new plot
        if(lastGene != "NONE"){
			title(main = "1:WT(Col0XC24) 2:WT(C24XCol0) 3:nrpd1a(Col0XC24) 4:nrpd1a(C24XCol0) \n5:nrpd1b(Col0XC24) 6:nrpd1b(C24XCol0) 7:drd1(Col0XC24) 8:drd1(C24XCol0)" ,cex.main =1)
			dev.off()
        }
        FileName<- paste("/Users/kaitang/Desktop/F1/new_analysis_May_15/May_18/fig_for_gene/", Gene, ".jpeg", sep="")
        jpeg(file = FileName, width = 680, height = 800) # generate a new jpeg file
		
       
     }else{
        par(new=TRUE)
     }
 plot(c(OverData[i,7], OverData[i,10], OverData[i,13], OverData[i,16], OverData[i,19], OverData[i,22], OverData[i,25], OverData[i,28]), type="b", main=OverData$Gene[i], xlab="", ylab="", ylim=c(0, 1)) # setup plot window
        lastGene <- Gene
     
}

dev.off();