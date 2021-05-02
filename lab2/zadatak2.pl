#!/usr/bin/perl

print "Unesite elemente niza odvojene razmakom: ";
$sequence = <STDIN>;
@sequence = split / /, $sequence;
$sum = 0;
$count = 0;
foreach $number (@sequence){
    $sum += $number;
    $count += 1;
}
$avg = $sum / $count;
print "$avg\n";
