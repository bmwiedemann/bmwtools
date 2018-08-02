#!/usr/bin/perl -w
# play music from a directory in random order
# exit it by pressing q or Ctrl-c twice

use strict;
use warnings;

my $dir=shift @ARGV;
if(not $dir) {
	print "usage: $0 DIR\n";
	exit 1;
}

open(PIPE, "find '$dir' -type f |") or die $!;
my @l1=<PIPE>;
my @l2;
foreach(@l1) {
	chop;
	next unless /\.mp3$/ or /\.m4a$/ or /\.wav/ or /\.ogg/;
	push(@l2, $_);
}
exit 0 if not @l2;

while(1){
	my $startt=time;
	my $x=$l2[rand(@l2)];
	system("/usr/bin/mplayer",$x);
	if(time-$startt<2) {die "short play - exiting"}
}
