#!/usr/bin/perl -w
# convert call_R_ChIP_Seq.pl output to bed file
#

################################################################
#
#		main 
#
################################################################

use strict;

my $usage = "$0 <dir> ";

die $usage unless (@ARGV == 1);



my $dir = $ARGV[0];

opendir(DIR, $dir) or die "cannot open $dir";

my @files = grep /d\.txt$/, readdir DIR;

foreach my $file (@files){
	my $cmd = "./R_output2bed.pl $dir $file";
	print STDERR $cmd, "\n";
	system("$cmd");
}