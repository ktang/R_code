library(VennDiagram);

setwd("/Users/tang58/Weiqiang_idm1_1_Nature_paper/Revision_Mar15_2012/data/hyper_list/S1");


venn.diagram(
	x = list( rdd =  c(1:5020, 5021:(5021 - 1 + 3579), 8600:(8600 - 1 + 471), 9071:(9071 - 1 + 220)),
		 	 "ros1-4" = c(9291:(9291 - 1 + 846), 5021:(5021 - 1 + 3579), 8600:(8600 - 1 + 471), 10137:(10137 - 1 + 95)),
		 	 "idm1-1" = c(10232:(10232 - 1 + 312 ), 8600:(8600 - 1 + 471), 9071:(9071 - 1 + 220),  10137:(10137 - 1 + 95))
		 	 ),
	filename = "IDM1_Venn_new.tiff",
	col = "transparent", 	fill = c("red", "blue", "green"),
	alpha = 0.5, 	label.col = c("darkred", "white", "darkblue", "white", "white", "white", "darkgreen"),
	cex = 2.5, 	fontfamily = "serif", 	fontface = "bold",
	cat.default.pos = "text", 	cat.col = c("darkred", "darkblue", "darkgreen"),
	cat.cex = 2.5, 	cat.fontfamily = "serif", 	cat.dist = c(0.06, 0.06, 0.03), 	cat.pos = 0,
	cat.fontface = "italic"	);



###############
#  
##################

venn.diagram(
	x = list( rdd =  c(1:5098, 5099:(5099 - 1 + 3579), 8678:(8678 - 1 + 471), 9149:(9149 - 1 + 220)),
		 	 "ros1-4" = c(9369:(9369 - 1 + 847), 5099:(5099 - 1 + 3579), 8678:(8678 - 1 + 471), 10216:(10216 - 1 + 95)),
		 	 "idm1-1" = c(10311:(10311 - 1 + 312 ), 8678:(8678 - 1 + 471), 9149:(9149 - 1 + 220),  10216:(10216 - 1 + 95))
		 	 ),
	filename = "IDM1_Venn_sum_lager_than_total_new.tiff",
	col = "transparent", 	fill = c("red", "blue", "green"),
	alpha = 0.5, 	label.col = c("darkred", "white", "darkblue", "white", "white", "white", "darkgreen"),
	cex = 2.5, 	fontfamily = "serif", 	fontface = "bold",
	cat.default.pos = "text", 	cat.col = c("darkred", "darkblue", "darkgreen"),
	cat.cex = 2.5, 	cat.fontfamily = "serif", 	cat.dist = c(0.06, 0.06, 0.03), 	cat.pos = 0,
	cat.fontface = "italic"	);











#################################################################################
#		1098 + 5 
##################################################################################
venn.diagram(
	x = list(#R = c(1:70, 71:110, 111:120, 121:140), 
			 #B = c(141:200, 71:110, 111:120, 201:230), 
		 	 #G = c(231:280, 111:120, 121:140, 201:230) 
		 	 rdd =  c(1:5019, 5020:8594, 8595:9069, 9070:9290),
		 	 "ros1-4" = c(9291:10136, 5020:8594, 8595:9069, 10137:10231),
		 	 idm1 = c(10232:10543,8595:9069, 9070:9290,  10137:10231)
		 	 ),
	filename = "IDM1_Venn.tiff",
	col = "transparent", 	fill = c("red", "blue", "green"),
	alpha = 0.5, 	label.col = c("darkred", "white", "darkblue", "white", "white", "white", "darkgreen"),
	cex = 2.5, 	fontfamily = "serif", 	fontface = "bold",
	cat.default.pos = "text", 	cat.col = c("darkred", "darkblue", "darkgreen"),
	cat.cex = 2.5, 	cat.fontfamily = "serif", 	cat.dist = c(0.06, 0.06, 0.03), 	cat.pos = 0,
	cat.fontface = "italic"	);

#version2 sum > total regions
venn.diagram(
	x = list(#R = c(1:70, 71:110, 111:120, 121:140), 
			 #B = c(141:200, 71:110, 111:120, 201:230), 
		 	 #G = c(231:280, 111:120, 121:140, 201:230) 
		 	 rdd =  c(1:5097, 5098:8672, 8673:9147, 9148:9368),
		 	 "ros1-4" = c(9369:10215, 5098:8672, 8673:9147, 10216:10310),
		 #	 idm1 = c(10311:10622, 8673:9147, 9148:9368,  10216:10310)
		 	 idm1 = c(10311:10622,  9148:9368,  10216:10310,8673:9147)
		 	 ),
	filename = "IDM1_Venn_sum_lager_than_total.tiff",
	col = "transparent", 	fill = c("red", "blue", "green"),
	alpha = 0.5, 	label.col = c("darkred", "white", "darkblue", "white", "white", "white", "darkgreen"),
	cex = 2.5, 	fontfamily = "serif", 	
	fontface = "bold",#for number
	#fontface = "italic",
	cat.fontface = "italic",
	cat.default.pos = "text", 	cat.col = c("darkred", "darkblue", "darkgreen"),
	cat.cex = 2.5, 	cat.fontfamily = "serif", 	cat.dist = c(0.06, 0.06, 0.03), 	cat.pos = 0	);