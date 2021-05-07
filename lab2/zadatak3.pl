#!/usr/bin/perl

$new_file = 0;
while (<>){
    $line = $_;
    chomp ($line);
    ($date) = $ARGV =~ m/(\d{4}-\d{2}-\d{2})/;
    ($hour) = $line =~ m/^.*\[\d{2}\/[a-zA-Z]{3}\/\d{4}:(\d{2}).*\].*$/;
    if ($new_file == 0){
        print "\nDatum: $date\n";
        print "sat : broj pristupa\n";
        print "-------------------------------\n";
        $access{$hour}++;
        $new_file = 1;
    }
    else {
        $access{$hour}++;
    }
    if (eof){
        foreach $hour (sort keys %access){
            printf "%3d : %d\n", $hour, $access{$hour};
        }
        $new_file = 0;
        %access=undef;
    }
}
