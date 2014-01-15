chr_length = c(30427671, 19698289, 23459830, 18585056, 26975502)
centromere_pos = c(14546720, 3608430, 13799918, 3956522, 11725524)
total_len = sum(chr_length)

extend_length = 1000000
gap = 3000000
lwd_chr = 20
cen_gap_half = 750000
chr_color = "gray90"

plot.new()
plot.window(xlim=c(-extend_length, total_len + gap *4 + extend_length),ylim=c(1,6))
y_i = 1;
for (chr in 1:5){
	chr_start		= sum(chr_length[0:(chr-1)]) + gap * (chr-1)
	chr_centromere	= chr_start+centromere_pos[chr]
	chr_end			= chr_start + chr_length[chr]
	lines( c( chr_start ,chr_centromere-cen_gap_half), c(y_i, y_i) ,lwd = lwd_chr, col =chr_color )
	lines( c( chr_centromere+cen_gap_half ,chr_end), c(y_i, y_i) ,lwd = lwd_chr  , col = chr_color)
}

