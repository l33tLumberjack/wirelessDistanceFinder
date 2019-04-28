#!/usr/bin/perl
use warnings;
use strict;
use Getopt::Long;

#Init
my $freeSpacePathLoss = 27.55;
my $distanceMeters = undef;
my $distanceMetersUpper = undef;
my $distanceMetersLower = undef;
my $targetDB = undef;
my $frequency = undef;
my $exparamentalMeters = undef;
my $help;


sub log10 {
    my $n = shift;
    return log($n)/log(10);
}

sub avg {
    my $total;
    $total += $_ foreach @_;
    return $total / @_;
}

sub distanceMeters {
    my $db = $_[0];
    chomp($db);
    my $frequency = $_[1];
    chomp($frequency);
    my $freeSpacePathLoss = 27.55;
    my $distanceInMeters = 10^(($freeSpacePathLoss - (20*log10($frequency)) + abs($targetDB))/20);
    return sprintf("%0.2f", $distanceInMeters);
}

GetOptions(
    'decibels|d=i'    => \$targetDB,
    'frequency|f=i'     => \$frequency,
    'help|?|h'     => \$help)
or die("Error in command line arguments\n");

if( $help ) {
    print "NAME\n";
    print "\twirelessDistanceFinder.pl - Estimate distances to a 2.4GHz wireless network\n";
    print "\n";
    print "SYNOPSIS\n";
    print "\twirelessDistanceFinder.pl -d -60 -f 2450\n";
    print "\n";
    print "DESCRIPTION\n";
    print "\tMandatory arguments to long options are mandatory for short options too.";
    print "\n";
    print "\t-d, --decibels\n";
    print "\t\t\tDecibels of the wifi access point you are looking at, option should be negative\n";
    print "\n";
    print "\t-f, --frequency\n";
    print "\t\t\tFrequency of the wifi access point you are looking at, option should be in MHz\n";
    print "\n";
    print "\t-?, -h, --help\n";
    print "\t\t\tDisplay this help information\n";
    print "\n";
    exit
}

chomp($targetDB);
chomp($frequency);
$distanceMetersLower = distanceMeters($targetDB, 2400);
$distanceMetersUpper = distanceMeters($targetDB, 2500);
$distanceMeters = avg($distanceMetersLower, $distanceMetersUpper);
$exparamentalMeters = distanceMeters($targetDB, $frequency);

## Devs notes because he dosnt want to write spaghetti code again in the future and have to reR&D everything again
## distance = 10 ^ ((27.55 - (20 * log10(frequency)) + signalLevel)/20) <- The actual thing
## https://stackoverflow.com/questions/11217674/how-to-calculate-distance-from-wifi-router-using-signal-strength
## http://rvmiller.com/2013/05/part-1-wifi-based-trilateration-on-android/
#PERL IMPLEMENTATION# $distMeters = 10^(($freeSpacePathLoss - (20*log10($frequency)) + abs($targetDB))/20);

print "Distance calculated at 2.4 GHz: " . $distanceMetersLower . "\n";
print "Distance calculated at 2.5 GHz: " . $distanceMetersUpper . "\n";
print "Distance calculated Average: " . $distanceMeters . "\n";
print "Distance calculated at " . $frequency . " MHz: " . $exparamentalMeters . "\n";
exit;
