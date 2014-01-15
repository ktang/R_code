# R --slave --vanilla --args   input_list  png_pre < /Users/tang58/Kai_BS/for_publish/draw_distribution_in_chr_use_v0.1_coordinate_format_single_file.R


args = commandArgs( trailingOnly =  T)  
input		 = args[1]
png_pre		 = args[2]

data_individual = read.delim( input, header = T )
data = data_individual

width_val = 8 # 3.8; 
height_val = 9;
units_val = "in"; res_val = 500; pointsize_val =8;
file_name = paste( png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

par(oma = c(5, 5, 1, 0) ) #down left up rigth
par(mar= rep(2, 4))

mar_ori = par("mar")

#par(mar = c(5, 6 , 4, 2) + 0.1)

chr_len = c(30427671, 19698289, 23459830, 18585056, 26975502 );
seq1_5 = 1:5
seq1.2_5.2 = seq1_5 + 0.2

plot.new()
plot.window(xlim=c(0,6),ylim=c(-31000000,500000))
segments(seq1_5, 0, seq1_5, -chr_len, lwd = 10)
segments(seq1.2_5.2, 0, seq1.2_5.2, -chr_len)



symbols(c(1,2,3,4,5),c(-14546720,-3608430,-13799918,-3956522,-11725524),circles=c(1,1,1,1,1),add=T,inches=0.08,fg="red",bg="red")

thin_lwd = 0.5


for (i in 1:5){
	if (data[1,1] == "1"){
		x = data[ data[,1] == i,]
		segments(i+0.2, -x[,2], i+0.4, -x[,2], lwd = thin_lwd)
	}else{
		if(data[1,1] == "chr1"){
			chr = paste("chr",i,sep="")
			x = data[ data[,1] == chr,]
			segments(i+0.2, -x[,2], i+0.4, -x[,2], lwd = thin_lwd)
		}
		else{
			print ("wrong chr");
			q("no")
		}
	}
}


par(xpd=NA)

text_y = 700000;

text( c(1,2,3,4,5), rep(text_y, 5), # c(5000,5000,5000,5000,5000), 
  labels = c( "1","2","3","4","5"  )  ,pos=3, cex = 2);

dev.off()