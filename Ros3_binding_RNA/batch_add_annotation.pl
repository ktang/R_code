#!/usr/bin/perl -w

use strict;

my $usage = "$0 <dir> ";

die $usage unless (@ARGV == 1);

my $dir = $ARGV[0];

opendir(DIR, $dir) or die "cannot open $dir";

my @files = grep /\.bed$/, readdir DIR;

foreach my $file (@files){
	my $output = "NONE";
	if ($file =~ /(\S+)\.bed$/){
		$output = $1."_annotated.txt";
		my $cmd = "time ./add_annotation_Kai_Apr26.pl $dir $file $output";
		print STDERR $cmd, "\n";
		system("$cmd");
	}
}