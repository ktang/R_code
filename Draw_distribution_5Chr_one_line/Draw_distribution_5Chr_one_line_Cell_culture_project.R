# R --slave --vanilla --args  png_pre  indir < /Users/tang58/scripts_all/R_scripts/Draw_distribution_5Chr_one_line/Draw_distribution_5Chr_one_line_Cell_culture_project.R
args = commandArgs( trailingOnly =  T)  
png_pre		 = args[1]
indir        = args[2]

setwd(indir)

width_val = 20#8.5 # 3.8; 
height_val = 7#11;
units_val = "in"; res_val = 500; pointsize_val =8;

chr_length = c(30427671, 19698289, 23459830, 18585056, 26975502)
centromere_pos = c(14546720, 3608430, 13799918, 3956522, 11725524)
total_len = sum(chr_length)

extend_length = 1000000
gap = 3000000
lwd_chr = 20
thin_lwd = 0.8
cen_gap_half = 750000
chr_color = "gray90"

half_bar = 0.08

cols_db =  c( 
"red",   #rgb ( 222, 147, 142, maxColorValue = 255 ),		#  red
"blue",  #	rgb ( 200, 226, 126, maxColorValue = 255 ),		#  
"gold3",#rgb ( 177, 199, 112, maxColorValue = 255 ),		#  green
rgb ( 142, 120, 176, maxColorValue = 255 ),		#  purple
rgb ( 186,  94,	 31, maxColorValue = 255 ),		#brown
rgb (   46, 35, 65, maxColorValue = 255 ),		# shen zi se
#"gold2"#rgb ( 57, 87,  175, maxColorValue = 255 ) 		#blue
"green" #rgb ( 177, 199, 112, maxColorValue = 255 )		#  green

)


files = dir(pattern= "txt")
print(files)
file_number = length(files)

x_data = list()
for (i in 1:file_number){ x_data[[i]] = read.delim(files[i], quote="") }# important

setwd("..")

file_name = paste( png_pre , "_w", width_val, "_h", height_val, "_res", res_val, "_pt", pointsize_val, ".png", sep="")
png(file_name, width = width_val, height = height_val, units = units_val , res = res_val, pointsize = pointsize_val );

par(oma = c(4, 0, 1, 0) ) #down left up rigth
par(mar= rep(1, 4))



plot.new()
#plot.window(xlim=c(-extend_length, total_len + gap *4 + extend_length),ylim=c(-1, -file_number))
plot.window(xlim=c(-extend_length, total_len + gap *4 + extend_length),ylim=c(file_number, 1))

#chr	pos	ref	mut_WT_0	per_WT_0	dep_WT_0	seq_WT_0	qual_WT_0	type	type_code
#chr1	863624	A	A=>DEL	11.11	9	.,,-1c.,...,	&!8!0&&&#	intron	5
#chr1	1130104	C	C=>DEL	13.33	15	..,,,,,-2ca,,-2ca.,,.,,	DFH#GFAHAGHFJD?	IG	7

#y_i = 1;
for (y_i in 1:file_number){
	for (chr in 1:5){
		chr_start		= sum(chr_length[0:(chr-1)]) + gap * (chr-1)
		chr_centromere	= chr_start+centromere_pos[chr]
		chr_end			= chr_start + chr_length[chr]
#	lines( c( chr_start ,chr_centromere-cen_gap_half), c(-y_i, -y_i) ,lwd = lwd_chr, col = chr_color )
#		lines( c( chr_centromere+cen_gap_half ,chr_end),   c(-y_i, -y_i) ,lwd = lwd_chr, col = chr_color)

		lines( c( chr_start ,chr_centromere-cen_gap_half), c(y_i, y_i) ,lwd = lwd_chr, col = chr_color )
		lines( c( chr_centromere+cen_gap_half ,chr_end),   c(y_i, y_i) ,lwd = lwd_chr, col = chr_color)

	}
	
	data_individual = x_data[[y_i]][,c(1:4, 10)];
	print (dim (data_individual))
	
	for (j in 1:5){
		chr = paste("chr", j, sep="");
		data = data_individual [data_individual[, 1] == chr, ];

		for(k in 1:dim(data)[1]){
			x_pos = data[k,2]+ sum(chr_length[0:(j-1)]) + gap * (j-1) 
#		lines( c( x_pos, x_pos   ) , c( -y_i + half_bar, -y_i - half_bar  ) , lwd = thin_lwd , col = cols_db[data[k,5]] )
		lines( c( x_pos, x_pos   ) , c( y_i + half_bar, y_i - half_bar  ) , lwd = thin_lwd , col = cols_db[data[k,5]] )
			
		}#		for(k in 1:dim(data)[1]){
	}#	for (j in 1:5){
}

legend_txt = c("CDS", "TE", "ncRNA", "UTR", "intron", "pseudogene", "IG")
par(xpd=NA)
legend(  centromere_pos[1], 6.3 ,legend= legend_txt , col = cols_db, lwd = 4, bty = "n",  cex = 1.5, ncol = 7
#,   ncol = length
)
dev.off()