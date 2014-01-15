#!/usr/bin/perl -w
# write this for self use, combined nearby peaks
# files must sorted

use strict;

my $usage = "$0 <input> <output> <max_gap>";
#format BED
#Chr	Start	End

die $usage unless(@ARGV == 3);

my ($input, $output, $cutoff) = @ARGV[0..2];

if (!(-e $input) or (-e $output)) {
	die "wrong input or output";
}
open (IN, $input)
	or die "cannot open $input file:$!";
	
open (OUT, ">$output")
	or die "cannot open $output file:$!";


my($last_chr, $last_start, $last_end) = ("chr0", -1, -1);

my($start, $end) = (0, 0);

my @regions; 

while(<IN>){
	chomp;
	my @a = split "\t";
	my $this_chr = lc $a[0];
	if ($this_chr ne $last_chr){
		if($last_chr ne "chr0") {push @regions, [$last_chr, $start, $end];}
		$start = $a[1];
		$end = $a[2];
		$last_start = $start;
		$last_end = $end;
		$last_chr =lc $a[0];
	}else{
		if ($a[1] < $start){
			die "a1 < start\n $a[1], $start\n";
		}
		
		if($a[1] - $last_end <= $cutoff){
			if($end < $a[2]){
				$end = $a[2];
				$last_end = $end;
			}
		}
		else{
			push @regions, [lc $a[0], $start, $end];
			$start = $a[1];
			$end = $a[2];
			$last_start = $start;
			$last_end = $end;
		}
	}
}
		
push @regions, [$last_chr, $start, $end];

#my $index = $#regions;
#print STDERR "index = $index";

for(my $i = 0; $i <= $#regions; $i++){
	my ($chr, $s, $e) = @{$regions[$i]};
	$chr =~ s/c/C/;
	print OUT join ("\t", ($chr, $s, $e) ), "\n";
}
close(OUT);