#!/usr/bin/perl

use strict;
use warnings;

$ARGV[2] or die "use extractSeq.pl LIST FASTA OUT\n";

my $list = shift @ARGV;
my $fasta = shift @ARGV;
my $out = shift @ARGV;
my %select;
open L, "$list" or die;
while (<L>) {
    chomp;
    s/>//g;
    $select{$_} = 1;
}
close L;

$/ = "\n>";
open O, ">$out" or die;
open F, "$fasta" or die;
while (<F>) {
    s/>//g;
    my ($id) = split (/\n/, $_);
    print O ">$_" if (defined $select{$id});
}
close F;
close O;
