#!/usr/bin/perl -w

################################################################
#
#		main 
#
################################################################

print STDERR ("\n==================| $0 start |==========================================\n");

my $start = time();
my $Time_Start = sub_format_datetime(localtime(time())); 
print STDERR "Now = $Time_Start\n\n";

my $dir = "/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read/bed_reduced/original";
my $soapdir = "/Users/tang58/deep_seq_analysis/Ros3_bind_RNA/combined_low_hits_read";
my $pre = "time /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/get_bed_region_coverage.pl";

my $cmd_l1 = "$pre $dir Lane1_Ros3_Ab_Short_low_hit_combined_resize_200_combined.bed  $soapdir Lane4_No_Ab_Short_low_hit_combined.soap 200";
print $cmd_l1, "\n";
system("$cmd_l1");

my $cmd_l3 = "$pre $dir Lane3_Ros3_Ab_Long_low_hit_combined_resize_450_combined.bed $soapdir Lane5_No_Ab_Long_low_hit_combined.soap 450";
print $cmd_l3, "\n";
system("$cmd_l3");

my $cmd_l6 = "$pre $dir Lane6_Ros3_RNA_Ab_low_hit_combined_resize_140_combined.bed $soapdir Lane8_No_Ab_low_hit_combined.soap 140";
print $cmd_l6, "\n";
system("$cmd_l6");

my $cmd_l7 = "$pre $dir Lane7_Ros3_Ab_low_hit_combined_resize_140_combined.bed $soapdir Lane8_No_Ab_low_hit_combined.soap 140";
print $cmd_l7, "\n";
system("$cmd_l7");

my $cmd_FL = "$pre $dir Ros3_FL_s_8_low_hit_combined_resize_300_combined.bed $soapdir Ros3_NL_s_5_low_hit_combined.soap 300";
print $cmd_FL, "\n";
system("$cmd_FL");


my $cmd_FS = "$pre $dir Ros3_FS_s_7_low_hit_combined_resize_150_combined.bed $soapdir Ros3_NS_s_6_low_hit_combined.soap 150";
print $cmd_FS, "\n";
system("$cmd_FS");



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

