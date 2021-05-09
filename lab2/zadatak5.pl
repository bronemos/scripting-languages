#!/usr/bin/perl

use open ':locale';
use locale;

$first_line = 0;
$weights_set = 0;
open CSV, $ARGV[0];

while(defined($line = <CSV>)){
    if ($line =~ /^#.*$/){
        next;
    }
    if ($weights_set == 0){
        $weights_set = 1;
        @weights = split /;/, $line;
    }
    else{
        @data = split /;/, $line;
        @student_data = @data[0..2];
        $student_name = join(", ", @student_data[1..2]);
        @student_points = @data[3..$#data];
        $sum = 0;
        foreach $index (0..$#student_points){
            if ($student_points[$index] ne "-"){
                $sum += $student_points[$index] * $weights[$index];
            }
        }
        $points_hash{$student_data[0]} = $sum;
        $jmbag_hash{$student_data[0]} = $student_name;
    }
}
print "Lista po rangu:";
print "\n-------------------\n";
$counter = 1;
foreach  $student_jmbag (sort {$points_hash{$b} <=> $points_hash{$a}} keys %points_hash){
    print "$counter. $jmbag_hash{$student_jmbag} ($student_jmbag) : $points_hash{$student_jmbag}\n";
    $counter++;
}

