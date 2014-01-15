#!/usr/bin/perl -w
#batch call bed_reduce_self.pl
use strict;

my $usage = "$0 <indir> <outdir> <max_gap>";

my ($indir, $outdir, $gap) = @ARGV[0..2];

die $usage unless (@ARGV == 3);

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
		 
		my $cmd1 = "sort -k1,1 -k2,2n $indir/$file > $outdir/temp.txt";
		print STDERR $cmd1 , "\n";
		system("$cmd1");
		
		my $cmd2 = "./bed_reduce_self.pl $outdir/temp.txt $outdir/$output $gap";
		print STDERR "$cmd2\n";
		system("$cmd2");
		
		my $cmd3 = "rm -f $outdir/temp.txt";
		print STDERR "$cmd3\n";
		system("$cmd3");		
		
	}else{
		die "wrong name\n";
	}
}

exit;