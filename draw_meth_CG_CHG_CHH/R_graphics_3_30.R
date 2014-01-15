tiff("3_30.tif")
groups <- c("cows", "sheep", "horses", 
"elephants", "giraffes")
males <- sample(1:10, 5)
females <- sample(1:10, 5)

par(mar=c(0.5, 5, 0.5, 1))

plot.new()
plot.window(xlim=c(-10, 10), ylim=c(-1.5, 5.5))

ticks <- seq(-10, 10, 5)
y <- 1:5
h <- 0.2

lines(rep(0, 2), c(-1.5, 5.5), col="grey")
segments(-10, y, 10, y, lty="dotted")
rect(-males, y-h, 0, y+h, col="dark grey")
rect(0, y-h, females, y+h, col="light grey")
mtext(groups, at=y, adj=1, side=2, las=2)
par(cex.axis=0.5, mex=0.5)
axis(1, at=ticks, labels=abs(ticks), pos=0)

tw <- 1.5*strwidth("females")
rect(-tw, -1-h, 0, -1+h, col="dark grey")
rect(0, -1-h, tw, -1+h, col="light grey")
text(0, -1, "males", pos=2)
text(0, -1, "females", pos=4)

box("inner", col="grey")
dev.off()