#v0.1: set line number
#v0.2: set base_per_line

#setwd("/Users/tang58/misc/Mingguang_Lei/1_draw_methylation_level_fig/data")
#data = read.csv("idm1-4 methylation_for_modify.csv")
if(0){
x = data;
x[,3] = toupper(x[,3])
}

total = dim(x)[1]
x_half = 0.15
y_bottom = 0.12
y_top = 0.45

y_diff = y_top - y_bottom

#lines = 6;
#base_per_line = ceiling(total / lines)
base_per_line = 50;
lines = ceiling(total / base_per_line);

#tiff("Mingguang_50bp.tif", width = 1000)
pdf("Mingguang_50bp_per_line.pdf",height = 9,width = 12)

par(mar=c(0.5, 0.5, 0.5, 0.5))
plot.new()
plot.window(xlim=c(-1, base_per_line +10), ylim=c(-1, lines + 1))
for(i in 1: (lines - 1)){
	y = x[(1+ (i-1)*base_per_line ):( i *base_per_line ),];
	text(1:base_per_line, lines+1 -i, y[,3])
	
	C_pos = y[ !(is.na.data.frame(y[,2])),];
	
	cPosInLine = C_pos[,1] - (i-1)*base_per_line;
	
	rect(cPosInLine-x_half, lines+1 -i + y_bottom, cPosInLine+x_half ,lines+1 -i +y_top);
	rect(cPosInLine-x_half, lines+1 -i -y_top, cPosInLine+x_half, lines+1 -i -y_bottom);
	
	cxx  = C_pos[ C_pos[,5] =="CG" ,]
	if(dim(cxx)[1] !=0 ){
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="black" );
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="black" );
	}
	
	cxx  = C_pos[ C_pos[,5] =="CHG" ,]
	if(dim(cxx)[1] !=0 ){
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="blue" );
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="blue" );
	}
	
	cxx  = C_pos[ C_pos[,5] =="CHH" ,]
	if(dim(cxx)[1] !=0 ){
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="red" );
		rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="red" );
	}
}

y = x[(1 + (lines - 1) * base_per_line):(total),];
text(1:(total -(lines - 1) * base_per_line) , lines+1 -lines, y[,3])
C_pos = y[ !(is.na.data.frame(y[,2])),];
cPosInLine = C_pos[,1] - (lines-1)*base_per_line;

i = lines

rect(cPosInLine-x_half, lines+1 -i +y_bottom, cPosInLine+x_half ,lines+1 -i +y_top);
rect(cPosInLine-x_half, lines+1 -i -y_top,    cPosInLine+x_half, lines+1 -i -y_bottom);

cxx  = C_pos[ C_pos[,5] =="CG" ,]
if(dim(cxx)[1] !=0 ){
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="black" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="black" );
}

cxx  = C_pos[ C_pos[,5] =="CHG" ,]
if(dim(cxx)[1] !=0 ){
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="blue" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="blue" );
}

cxx  = C_pos[ C_pos[,5] =="CHH" ,]
if(dim(cxx)[1] !=0 ){
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i +y_bottom  ,             cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i +y_bottom +y_diff*cxx[,2]  , col="red" );
	rect(cxx[,1] -(i-1)*base_per_line -x_half, lines+1 -i -y_bottom -y_diff*cxx[,4],  cxx[,1] -(i-1)*base_per_line +x_half, lines+1 -i -y_bottom ,               col="red" );
}
dev.off()
