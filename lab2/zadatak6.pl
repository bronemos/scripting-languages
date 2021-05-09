#!/usr/bin/perl

use open ':locale';
use locale;


$prefix_length = $ARGV[1];
open WORDS, $ARGV[0];

while(<WORDS>){
    chomp;
    tr/A-Z/a-z/;
    @words = split (/[\s.,!;?]+/, $_); #\s matcha whitespace, \n i \t
    foreach $word (@words){
        if ($prefix_length <= length($word)){
            $prefix = substr($word, 0, $prefix_length);
            $prefix_hash{$prefix}++;
        }
    }
}
foreach $prefix (sort keys %prefix_hash){
    print "$prefix : $prefix_hash{$prefix}\n"
}