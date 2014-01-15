#!/usr/bin/perl -w

#use File::Spec;
#my $outFile_ge9 = File::Spec->catfile($outDir, join(".", @parts) . "_ge9." . $ext);
# my ($volume,$directories,$file) =          File::Spec->splitpath( $path );


use strict;
use File::Spec;

my $debug = 0;

my $script = "/Users/tang58/scripts_all/R_scripts/boxplot/R_boxplot_for_meth_level_in_sRNA_region_command_input_need_change_head.r";
die unless (-e $script);
#<input_list_DMR> <bam_dir> <outdir> <output_pre>
if($debug){
	print STDERR "debug = 1\n\n";
}
#my $usage = "$0 \n <indir> <outdir>\n\n";
#die $usage unless(@ARGV == 2);
#my $indir_DMR = shift or die;
#my $bam_dir = shift or die;
#my $outdir = shift or die;

my $usage = "$0 \n <dir>\n\n";
die $usage unless(@ARGV == 1);
my $dir = shift or die;

opendir(DIR, $dir) or die "cannot open $dir: $!";
my @DMR_lists = grep /\.txt$/ , readdir DIR;
closedir DIR;

if ( $debug ) {
	print STDERR join("\n", @DMR_lists), "\n\n";
}

## R --slave --vanilla --args  indir input_file_name  output_pre < R_cmd.r


my $i = 0;
foreach my $file(@DMR_lists){
	if ( $file =~ /(\S+)\.txt$/) {
		$i++;
		my $pre = $1 . "_boxplot";
		#my $input = File::Spec->catfile( $indir_DMR, $file );
		#die unless (-e $input);
		
		my $cmd = "R --slave --vanilla --args  $dir $file $pre < $script >/dev/null 2>&1";
		#my $cmd = "R --slave --vanilla --args  $dir $file $pre < $script ";
#		my $cmd = "perl $script $input $bam_dir $outdir $pre";
		
		if ( !$debug) {
			print STDERR $i, "\t";
			`$cmd`;#code
		}else{
			print STDERR $cmd, "\n\n";
		}
	}
}
# <input_list_DMR> <bam_dir> <outdir> <output_pre>
print STDERR "\n\n";
exit;
