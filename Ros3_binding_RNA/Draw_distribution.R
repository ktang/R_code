# barplot for nucleitide distribution

args = commandArgs()
base_dist = read.table("base_dist.txt" ,header =T, sep ="\t")
pos_dist = read.table("tail.txt" ,header =T, sep ="\t")
len_dist = read.table("length_dist.txt" ,header =T, sep ="\t")

pre = args[5]
#jpeg("len_dist.jpeg",width = 1300)

j1 = paste(pre,"len_dist.jpg",sep ="_")
jpeg(filename = j1,width = 1300)

barplot(len_dist[,2],names.arg = len_dist[,1],space = 2,width = 1,col = "blue") 
#main = paste(,sep=" "))
dev.off()


#barplot(as.vector(base_dist[1,2:5],mode ="numeric"), names.arg = names(base_dist[,2:5]) , col = c("green",
#"red", "blue", "brown"), main =  )

j2 = paste(pre, "pos_base_dist.jpg",sep ="_")
jpeg(filename = j2)

barplot(as.vector(base_dist[1,2:5],mode ="numeric"), names.arg = c( paste("A",round(base_dist[1,2]/base_dist[1,1],3) ,sep ="="),
paste("T",round(base_dist[1,3]/base_dist[1,1],3) ,sep ="="),paste("C",round(base_dist[1,4]/base_dist[1,1],3) ,sep ="="),
paste("G",round(base_dist[1,5]/base_dist[1,1],3) ,sep ="=")  ) , col = c("green","red", "blue", "brown"))
#main =  "a")

dev.off()

j3 = paste(pre, "length_dist.jpg", sep = "_")
jpeg(j3)

layoutmat = matrix(data=c(1,2), ncol = 1, nrow = 2)
layout(layoutmat)

t = sum(as.vector(pos_dist[1:4,3],mode="numeric"))

barplot(height = cbind(first = as.vector(pos_dist[1:4,3],mode="numeric") / t * 100,  second = as.vector(pos_dist[5:8,3],mode="numeric") / t * 100, 
third = as.vector(pos_dist[9:12,3],mode="numeric") / t * 100,  fourth= as.vector(pos_dist[13:16,3],mode="numeric") / t * 100,
fifth = as.vector(pos_dist[17:20,3],mode="numeric") / t * 100  ) , beside = T, col = c(1,"red", "blue", "brown"), ylab= "%", main = "head",)

legend("top",legend= c("A", "T", "C", "G"), cex = 0.8, col = c(1,"red", "blue", "brown"), lty = 1,lwd = 4, horiz = T, bty= "n")


barplot(height = cbind(first = as.vector(pos_dist[1:4,4],mode="numeric") / t * 100,  second = as.vector(pos_dist[5:8,4],mode="numeric") / t * 100, 
third = as.vector(pos_dist[9:12,4],mode="numeric") / t * 100,  fourth= as.vector(pos_dist[13:16,4],mode="numeric") / t * 100,
fifth = as.vector(pos_dist[17:20,4],mode="numeric") / t * 100  ) , beside = T, col = c(1,"red", "blue", "brown"), ylab= "%", main = "tail")

legend("top", c("A", "T", "C", "G"), cex = 0.8, col = c(1,"red", "blue", "brown"), lty = 1,lwd = 4, horiz = T, bty= "n")

dev.off()
