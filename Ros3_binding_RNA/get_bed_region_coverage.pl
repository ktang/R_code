#!/usr/bin/perl -w
# call ChIPSeq_package.R in the same directory to
# batch run chipseq package

################################################################
#
#		main 
#
################################################################

my $debug = 0;

my $usage = "$0 <bed_dir> <IP_bed> <soapdir> <ctrl_soap_name> <length>";

die $usage unless (@ARGV == 5);

print STDERR ("\n==================| $0 start |==========================================\n");

my $start = time();
my $Time_Start = sub_format_datetime(localtime(time())); 
print STDERR "Now = $Time_Start\n\n";

#my $cmd_ = "time R --slabe --vanilla --args $input $length";

my ($dir, $ip_bed, $soapdir, $ctrl_soap, $length) = @ARGV[0..4];

if ($debug) { print STDERR join("\n",($dir, $ip_bed, $ctrl_soap,$soapdir, $length)) , "\n"}

my $output = "NONE";

if($ip_bed =~ /(\S+)\.bed$/){
	$output = $1."_coverage_info_in_ctrl.txt";
}else{
	die "wrong input not end in .bed";
}

if (!(-e "$soapdir/$ctrl_soap")) {die "$soapdir/$ctrl_soap\n"}

if ( (-e "$dir/$output") or !(-e "$dir/$ip_bed") or !(-e "$soapdir/$ctrl_soap")){
	die "input or output wrong";
}

my $cmd = "time R --slave --vanilla --args " . $ctrl_soap . " " . $length . " " . $output . " ". $dir . " ". $ip_bed . " ". $soapdir ." < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/get_bed_region_coverage.R";

#my $cmd = "R -q --vanilla --args " . $input . " " . $length . " " . $output . " ". $dir . " < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/ChIPSeq_package.R";


print STDERR $cmd , "\n\n";
system ("$cmd");



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

