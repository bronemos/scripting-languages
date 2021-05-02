#!/usr/bin/perl

print "Unesite niz znakova: ";
$line = <STDIN>;
print "Unesite broj ponavljanja: ";
$n = <STDIN>;
$count = 0;
while ($count < $n) {
    print $line;
    $count += 1;
}
