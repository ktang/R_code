#!/usr/bin/perl -w
# convert call_R_ChIP_Seq.pl output to bed file
#

################################################################
#
#		main 
#
################################################################

use strict;

my $usage = "$0 <dir> <input_file_name>";

die $usage unless (@ARGV == 2);



my ($dir, $input) = @ARGV[0..1];

if (! (-e "$dir/$input")) {die "input $input do not exists!!\n"}

my $output = "no";

if ($input =~ /(\S+)\.txt/){
	$output = $1.".bed";
}else{
	die "wrong input name\n";
}

if (-e "$dir/$output"){ die "output $output exists!!!\n"}

open (IN, "$dir/$input");
open (OUT, ">$dir/$output");

my $chr = "Chr0";
while(<IN>){
	chomp;
	if(/Chr/){
		$chr = $_;
	}
	else{
		print OUT join("\t", ($chr,$_)), "\n";
	}
}

close(IN);
close(OUT);


