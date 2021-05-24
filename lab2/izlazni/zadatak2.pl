#!/usr/bin/perl

open MAIL, $ARGV[0];

while(<MAIL>) {
    chomp;
    if (/^From:.*<.*@.*>$/){
        ($mail) = $_ =~ m/<(.*@.*)>/;
        $mail_hash{$mail}++;
    }
}
foreach $mail (sort {$mail_hash{$a} <=> $mail_hash{$b}} keys %mail_hash){
    printf("%40s: %s (%s)\n", $mail, "*" x $mail_hash{$mail}, $mail_hash{$mail});
}
