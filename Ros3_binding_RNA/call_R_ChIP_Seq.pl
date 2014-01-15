#!/usr/bin/perl -w
# call ChIPSeq_package.R in the same directory to
# batch run chipseq package

################################################################
#
#		main 
#
################################################################

my $usage = "$0 <indir> <input> <length>";

die $usage unless (@ARGV == 3);

print STDERR ("\n==================| $0 start |==========================================\n");

my $start = time();
my $Time_Start = sub_format_datetime(localtime(time())); 
print STDERR "Now = $Time_Start\n\n";

#my $cmd_ = "time R --slabe --vanilla --args $input $length";

my ($dir, $input, $length) = @ARGV[0..2];

my $output = "NONE";

if($input =~ /(\S+)\.soap$/){
	$output = $1."_resize_". $length ."_original_island.txt";
}else{
	die "wrong input not end in .soap";
}

if (-e "$dir/$output" or !(-e "$dir/$input")){
	die "input or output wrong";
}

my $cmd = "R --slave --vanilla --args " . $input . " " . $length . " " . $output . " ". $dir . " < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/ChIPSeq_package.R";

#my $cmd = "R -q --vanilla --args " . $input . " " . $length . " " . $output . " ". $dir . " < /Users/tang58/scripts_all/R_scripts/Ros3_binding_RNA/ChIPSeq_package.R";


print $cmd , "\n";
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

