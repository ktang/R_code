#!/usr/bin/perl -w
# call ChIPSeq_package.R in the same directory to
# batch run chipseq package

################################################################
#
#		main 
#
################################################################

print STDERR ("\n==================| $0 start |==========================================\n");

my $start = time();
my $Time_Start = sub_format_datetime(localtime(time())); 
print STDERR "Now = $Time_Start\n\n";

my $dir = "/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read";

my $cmd_l1 = "./call_R_ChIP_Seq.pl $dir Lane1_Ros3_Ab_Short_low_hit_combined.soap 200";
print $cmd_l1, "\n";
system("$cmd_l1");

my $cmd_l3 = "./call_R_ChIP_Seq.pl $dir Lane3_Ros3_Ab_Long_low_hit_combined.soap 450";
print $cmd_l3, "\n";
system("$cmd_l3");

my $cmd_l4 = "./call_R_ChIP_Seq.pl $dir Lane4_No_Ab_Short_low_hit_combined.soap 200";
print $cmd_l4, "\n";
system("$cmd_l4");

my $cmd_l5 = "./call_R_ChIP_Seq.pl $dir Lane5_No_Ab_Long_low_hit_combined.soap 450";
print $cmd_l5, "\n";
system("$cmd_l5");

my $cmd_l6 = "./call_R_ChIP_Seq.pl $dir Lane6_Ros3_RNA_Ab_low_hit_combined.soap 140";
print $cmd_l6, "\n";
system("$cmd_l6");

my $cmd_l7 = "./call_R_ChIP_Seq.pl $dir Lane7_Ros3_Ab_low_hit_combined.soap 140";
print $cmd_l7, "\n";
system("$cmd_l7");

my $cmd_l8 = "./call_R_ChIP_Seq.pl $dir Lane8_No_Ab_low_hit_combined.soap 140";
print $cmd_l8, "\n";
system("$cmd_l8");

my $cmd_FS = "./call_R_ChIP_Seq.pl $dir Ros3_FS_s_7_low_hit_combined.soap 150";
print $cmd_FS, "\n";
system("$cmd_FS");

my $cmd_FL = "./call_R_ChIP_Seq.pl $dir Ros3_FL_s_8_low_hit_combined.soap 300";
print $cmd_FL, "\n";
system("$cmd_FL");

my $cmd_NS = "./call_R_ChIP_Seq.pl $dir Ros3_NS_s_6_low_hit_combined.soap 150";
print $cmd_NS, "\n";
system("$cmd_NS");

my $cmd_NL = "./call_R_ChIP_Seq.pl $dir Ros3_NL_s_5_low_hit_combined.soap 300";
print $cmd_NL, "\n";
system("$cmd_NL");

sub_end_program();

############################################################################################################
######################                  sub_format_datetime
############################################################################################################

sub sub_format_datetime #
{
    my ($sec, $min, $hour, $day, $mon, $year, $wday, $yday, $isdst) = @_;
    sprintf("%4d-%02d-%02d %02d:%02d:%02d", $year+1900, $mon+1, $day, $hour, $min, $sec);
}


############################################################################################################
######################                  sub_end_program
############################################################################################################
sub sub_end_program
{
	print STDERR ("\n............................................................\n");
	my $Time_End = sub_format_datetime(localtime(time()));
	print STDERR "Running from [$Time_Start] to [$Time_End]\n";
	my $end = time();
	printf STDERR ("Total execute time : %.2f s\n",$end-$start);
	print STDERR ("==========================| $0  end  |==================================\n\n");
	exit(0);

}

