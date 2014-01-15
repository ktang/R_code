#!/usr/bin/perl -w

use strict;

my $usage = "$0 <indir> <outdir>";

my ($indir, $outdir) = @ARGV[0..1];

die $usage unless (@ARGV == 2);

if(!(-e $indir) or !(-e $outdir)){
	die "wrong directory!:$!"
}
opendir (DIR, $indir) or die "cannot open $indir";


my @files = grep /\.bed$/, readdir DIR;



print STDERR join("\n", @files) , "\n";

foreach my $file(@files){
	if($file =~ /(\S+)_orig/){
		
		my $label = $1;
		
		my $output = $label."_combined.bed";
		my $out_sort = $label."_combined_sorted.bed";
		
		if(-e "$outdir/$output" or !(-e "$indir/$file")){
			die "wrong input or output\n";
		}
		 
		my $cmd = "R --slave --vanilla --args $file $output $indir $outdir ". "< ./bed_reduce.R";
		print STDERR $cmd , "\n";
		system("$cmd");

		my $sort_cmd = "sort -k1,1 -k2,2n $outdir/$output > $outdir/$out_sort; rm -f $outdir/$output";
		system ("$sort_cmd");
		

		
	}else{
		die "wrong name\n";
	}
}

exit;