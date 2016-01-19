#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_file);

my $file = read_file("resultados_NOISE_mlp.txt");

my @gens = split(/\n\n\n/, $file);

my @data = ['Gen','ID','Fitness'];
for my $f (@gens) {
    my ($gen) = ($f =~ /\((\d+)\)/);
    my @f_content = split(/\n\n/, $f );
    for my $l ( @f_content[1..$#f_content] ) {
      my ($ord, $ID) = ($l =~ /(\d+)\s+ID= (\d+)/);
      my $id ="$ord-$ID";
      my @values=($l =~ /c1= (\d+\.\d+)/g);
      for my $v (@values ) {
	push @data, [$gen, "Id$id", $v];
      }
    }
    
}

say join("\n",map join(",",@$_), @data);

