plot.new()
plot.window(xlim=c(0,6),ylim=c(-31000000,500000))

lines(c(1,1),c(0,-30427671),lwd = 10)

lines(c(2,2),c(0,-19698289),lwd = 10)

lines(c(3,3),c(0,-23459830),lwd = 10)

lines(c(4,4),c(0,-18585056),lwd = 10)

lines(c(5,5),c(0,-26975502),lwd = 10)

lines(c(1.2,1.2),c(0,-30427671))

lines(c(2.2,2.2),c(0,-19698289))

lines(c(3.2,3.2),c(0,-23459830))

lines(c(4.2,4.2),c(0,-18585056))

lines(c(5.2,5.2),c(0,-26975502))

symbols(c(1,2,3,4,5),c(-15000000,-3600000,-13500000,-3920000,-11700000),circles=c(1,1,1,1,1),add=T,inches=0.08,fg="red",bg="red")

thin_lwd = 0.1

for(i in 1:dim(data)[1])
{
	if(data[i,1] =="chr1")
	{lines(c(1.2,1.4),c(-data[i,2],-data[i,2]),lwd = thin_lwd)}
	
	if(data[i,1] =="chr2")
	{lines(c(2.2,2.4),c(-data[i,2],-data[i,2]),lwd = thin_lwd)}
	
	if(data[i,1] =="chr3")
	{lines(c(3.2,3.4),c(-data[i,2],-data[i,2]),lwd = thin_lwd)}
	
	if(data[i,1] =="chr4")
	{lines(c(4.2,4.4),c(-data[i,2],-data[i,2]),lwd = thin_lwd)}
	
	if(data[i,1] =="chr5")
	{lines(c(5.2,5.4),c(-data[i,2],-data[i,2]),lwd = thin_lwd)}
	
}

text(c(1,2,3,4,5),c(5000,5000,5000,5000,5000),labels=c(1,2,3,4,5),pos=3)