#!/usr/bin/perl -w

#use File::Spec;
#my $outFile_ge9 = File::Spec->catfile($outDir, join(".", @parts) . "_ge9." . $ext);

use strict;
use File::Spec;
print STDERR "workdir should be . \n\n";
#my $script = "/Users/tang58/Kai_BS/myown/cytosines_coverage/cal_cytosines_coverage_for_acgt_count_output.pl";
my $script = "/Users/tang58/Kai_BS/for_publish/loci_distribution_in_chr/draw_distribution_in_chr_use_v0.1_coordinate_format_single_file.R";

die unless (-e $script);

my $debug = 0;

if($debug){
	print STDERR "debug = 1\n\n";
}
my $usage = "$0 \n <indir> <postfix: JacobsenCell_Bin100_FDR0.01_sDep4_lDep4_Cnum4.txt> \n\n";
die $usage unless(@ARGV == 2);

my $indir = shift or die;
die unless (-e $indir);
my $postfix = shift or die;

opendir(DIR, $indir) or die;

my @files = grep /$postfix/, readdir DIR;
closedir DIR;

print STDERR join("\n", @files), "\n\n";



# <isMeth_file> <sample_name> <head_yes_no> STDOUT

# R --slave --vanilla --args 91_2A_mbd7_vs_MG_35S_SUC2_WT_CHH_hyper_JacobsenCell_Bin100_FDR0.01_sDep4_lDep4_Cnum4.txt mbd7_CHH_hyper
#< /Users/tang58/Kai_BS/for_publish/draw_distribution_in_chr_use_v0.1_coordinate_format_single_file.R


foreach my $file (@files){
	if($file =~ /(\S+)_$postfix/){
		my $pre = $1;
	#	my $input = File::Spec->catfile($indir, $file);
		#die unless (-e $input);
		die  $pre, "\n", $file unless (-e $file);
	#	my $cmd = "perl $script  $input  $pre no >> $output";
		my $cmd = " R --slave --vanilla --args $file $pre < $script";
		print STDERR $cmd, "\n";
		if(!$debug){
			`$cmd`;
		}
	}
}

exit;
