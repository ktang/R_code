####################################################################################
# redraw images
####################################################################################


library(Ringo)# load library

setwd("/Users/kaitang/Desktop/Nimblegen/real_data")# set work directory to load the R data

load("RGs_separate_as_ten.rda")# load data;

setwd("./images_Aug_6/")# set new wd to generate the file

RG1breaks <- c(0,quantile(RGs_separate[[1]]$G, probs=seq(0,1,by=0.1)),2^16)


###  RGs_separate[[2]]  ---->>>50446602




####################################################################################
#       480*480  
####################################################################################
jpeg("50446602_532.jpg",quality = 100)
par(mar=c(0.01,0.01,2.2,0.01))
my.colors = colorRampPalette(c("black",paste("green",c(4,1),sep=""))) (length(RG1breaks)-1)
image(RGs_separate[[2]],1,channel = "green",mybreaks = RG1breaks,mycols = my.colors)
mtext(side=3, line=0.2, font=2, text="50446602_532_pair")
dev.off()


jpeg("50446602_635.jpg",quality = 100)
par(mar=c(0.01,0.01,2.2,0.01))
my.colors = colorRampPalette(c("black",paste("red",c(4,1),sep=""))) (length(RG1breaks)-1)
image(RGs_separate[[2]],1,channel = "green",mybreaks = RG1breaks,mycols = my.colors)
mtext(side=3, line=0.2, font=2, text="50446602_635_pair")
dev.off()





####################################################################################
#       1074*768
####################################################################################

for (this.set in 1:10)
{
	thisRG <- RGs_separate[[this.set]]
	for (this.channel in c("green","red"))
	
	
	{
		text=colnames(thisRG[[toupper(substr(this.channel,1,1))]])[1]
		jpeg(paste(text,"_1074*768.jpg" , sep=""),quality=100,height=1074, width=768)
		par(mar=c(0.01,0.01,2.2,0.01))
		my.colors = colorRampPalette(c("black",paste(this.channel,c(4,1),sep=""))) (length(RG1breaks)-1)
		
		image(thisRG, 1, channel=this.channel,mybreaks=RG1breaks, mycols=my.colors)
		mtext(side=3, line=0.2, font=2, text)
		dev.off()
	}
	
	
}

####################################################################################
#       1074*768  RG_Col0_breaks
####################################################################################

RG1breaks <- c(0,quantile(RGs_separate[[3]]$G, probs=seq(0,1,by=0.1)),2^16)
for (this.set in 1:10)
{
	thisRG <- RGs_separate[[this.set]]
	for (this.channel in c("green","red"))
	
	
	{
		text=colnames(thisRG[[toupper(substr(this.channel,1,1))]])[1]
		jpeg(paste(text,"_1074*768_RGbreak_Col0_1.jpg" , sep=""),quality=100,height=4200, width=768)
		par(mar=c(0.01,0.01,2.2,0.01))
		my.colors = colorRampPalette(c("black",paste(this.channel,c(4,1),sep=""))) (length(RG1breaks)-1)
		
		image(thisRG, 1, channel=this.channel,mybreaks=RG1breaks, mycols=my.colors)
		mtext(side=3, line=0.2, font=2, text)
		dev.off()
	}
	
	
}


####################################################################################
#       size
####################################################################################



RG1breaks <- c(0,quantile(RGs_separate[[3]]$G, probs=seq(0,1,by=0.1)),2^16)

for (this.set in 1:10)
{
	thisRG <- RGs_separate[[this.set]]
	for (this.channel in c("green","red"))
	
	
	{
		text=colnames(thisRG[[toupper(substr(this.channel,1,1))]])[1]
		jpeg(paste(text,"_RGbreak_Col0_1.jpg" , sep=""),quality=100,height=4200, width=1050)
		par(mar=c(0.01,0.01,2.2,0.01))
		my.colors = colorRampPalette(c("black",paste(this.channel,c(4,1),sep=""))) (length(RG1breaks)-1)
		
		image(thisRG, 1, channel=this.channel,mybreaks=RG1breaks, mycols=my.colors)
		mtext(side=3, line=0.2, font=2, text)
		dev.off()
	}
	
	
}



jpeg("try.jpg",quality=100,height=4200, width=1050)
RG1breaks <- c(0,quantile(RGs_separate[[3]]$G, probs=seq(0,1,by=0.1)),2^16)
my.colors = colorRampPalette(c("black",paste("red",c(4,1),sep=""))) (length(RG1breaks)-1)
image(RGs_separate[[1]], 1, channel="red",mybreaks=RG1breaks, mycols=my.colors)

dev.off()
