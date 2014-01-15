#setwd("/Users/tang58/misc/Mingguang_Lei/1_draw_methylation_level_fig/data")
#data = read.csv("idm1-4 methylation_for_modify.csv")
if(0){
x = data;
x[,3] = toupper(x[,3])
}
total = dim(x)[1]

x_half = 0.15


#dev.off();

lines = 6;
base_per_line = ceiling(total / lines)


#tiff("Mingguang.tif", width = 1000)
pdf("Mingguang.pdf",width = 12)

par(mar=c(0.5, 5, 0.5, 1))
plot.new()
plot.window(xlim=c(-1, base_per_line +10), ylim=c(-1, lines + 1))
for(i in 1: (lines - 1)){
	y = x[(1+ (i-1)*base_per_line ):( i *base_per_line ),];
	text(1:base_per_line, lines + 1-i, y[,3])
	
	C_pos = y[ !(is.na.data.frame(y[,2])),];
	
	cPosInLine = C_pos[,1] - (i-1)*base_per_line;
	
	rect(cPosInLine-x_half, lines+1 -i +0.1, cPosInLine+x_half ,lines+1 -i +0.4);
	rect(cPosInLine-x_half, lines+1 -i -0.4, cPosInLine+x_half, lines+1 -i -0.1);
	
	cxx  = C_pos[ C_pos[,5] =="CG" ,]
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="black" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="black" );
	
	cxx  = C_pos[ C_pos[,5] =="CHG" ,]
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="blue" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="blue" );
	
	cxx  = C_pos[ C_pos[,5] =="CHH" ,]
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="red" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="red" );		
}

y = x[(1 + (lines - 1) * base_per_line):(total),];
text(1:(total -(lines - 1) * base_per_line) , lines+1 -lines, y[,3])
C_pos = y[ !(is.na.data.frame(y[,2])),];
cPosInLine = C_pos[,1] - (lines-1)*base_per_line;
rect(cPosInLine - x_half, lines + 1-lines+0.4, cPosInLine + x_half, lines + 1-lines+0.1);
rect(cPosInLine - x_half, lines + 1-lines-0.1, cPosInLine + x_half, lines + 1-lines-0.4);

i = lines

cxx  = C_pos[ C_pos[,5] =="CG" ,]
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="black" );
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="black" );

cxx  = C_pos[ C_pos[,5] =="CHG" ,]
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="blue" );
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="blue" );

cxx  = C_pos[ C_pos[,5] =="CHH" ,]
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i +0.1  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +0.1 +0.3*cxx[,2]  , col="red" );
rect(cxx[,1] -  (i-1)*base_per_line -x_half, lines+1 -i -0.1 -0.3*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -0.1 ,               col="red" );


dev.off()
