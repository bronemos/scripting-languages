#!/usr/bin/perl

while(<>){
    chomp;
    $line = $_;
    @vals = split /;/, $line;
    ($deadline_date) = $vals[3] =~ m/(\d{4}-\d{2}-\d{2})/;
    ($submit_date) = $vals[4] =~ m/(\d{4}-\d{2}-\d{2})/;
    if ($deadline_date ne $submit_date){
        &problem_print(@vals);
        next;
    }
    ($deadline_hour) = $vals[3] =~ m/(\d+):\d{2}/; 
    ($submit_hour) = $vals[4] =~ m/(\d+):\d{2}:\d{2}/;
    if ($deadline_hour + 1 <= $submit_hour){
        &problem_print(@vals);
        next;
    }
}

sub problem_print{
    @vals = @_;
    @deadline = split / /, $vals[3];
    print "$vals[0] $vals[1] $vals[2] - PROBLEM: @deadline[0..1] --> $vals[4]\n"
}