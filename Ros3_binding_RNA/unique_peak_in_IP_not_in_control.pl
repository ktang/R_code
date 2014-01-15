#!/usr/bin/perl -w
# modified on April 27, 2011
# by Kai Tang

#this script input two annotated 
use strict;



sub isoverlappingslop
{
	my $extrabit=$_[0]; #allows for sloppiness - if this is set to zero, then there is no sloppiness
	my $acor=$_[1]-$extrabit;
	my $bcor=$_[2]+$extrabit;
	my $ccor=$_[3]-$extrabit;
	my $dcor=$_[4]+$extrabit;
	
	if ($acor>=$ccor && $acor<=$dcor)
	{return 1;}
	if ($bcor>=$ccor && $bcor<=$dcor)
	{return 1;}
	if ($ccor>=$acor && $ccor<=$bcor)
	{return 1;}
	if ($dcor>=$acor && $dcor<=$bcor)
	{return 1;}
	return 0;
}

#short for bed, long for gff
my $usage = "$0 <IP_bed_annotated> <ctrl_bed_annotated> <output> <gap>";
die $usage unless(@ARGV == 4);

my ($ip_file, $ctrl_file, $output, $gap) = @ARGV[0..3];

$gap = int($gap/2);

if ( !(-e $ip_file) or !(-e $ctrl_file) or (-e $output)){
	die "wrong input or output\n";
}

my ($ip_start, $ip_end, $ctrl_start, $ctrl_end);

open (IP, $ip_file);
my @ips = <IP>;
close(IP);

open (CTRL, $ctrl_file);
my @ctrls = <CTRL>;
close(CTRL);

open (OUT,">$output");

print OUT $ips[0];

for(my $i = 1; $i <= $#ips; $i++){
	my $overlap_flag = 0;
	my $this = $ips[$i];
	chomp $this;
	my @a = split "\t", $this;
	my $chr_ip = lc $a[0];
	($ip_start, $ip_end) = @a[1..2];
	
	LOOP: for (my $j = 1; $j <= $#ctrls; $j ++){
		my $this_ctrl = $ctrls[$j];
		chomp $this_ctrl;
		my @pts_ctrl = split "\t", $this_ctrl;
		my $chr_ctrl = lc $pts_ctrl[0];
		($ctrl_start, $ctrl_end) = @pts_ctrl[1..2];
		
		if ( ($chr_ip eq $chr_ctrl) and isoverlappingslop ($gap, $ip_start, $ip_end, $ctrl_start, $ctrl_end)){
			$overlap_flag = 1;
			last LOOP;
		}
	}
	
	if (! $overlap_flag){
		print OUT $this, "\n";
	}
	
}

exit;