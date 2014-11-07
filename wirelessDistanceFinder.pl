#!/usr/bin/perl
use warnings;
use strict;

#-#!-#!-#!-#!-#!-#!-#!-#
#l33tLumberjack
#Date: October, 11 2012
#Function of Code: Uses math and the strength of a wireless signal in dB to calculate approximate distance from station
#-#!-#!-#!-#!-#!-#!-#!-#

my $constant = -27.55;
my $distanceMeters = undef;
my $distanceMetersUpper = undef;
my $distanceMetersLower = undef;
my $frequencyMHzUpper = 2400;
my $frequencyMHzLower = 2500;
my $targetDB = undef;
my $frequency = undef;
my $distMeters = undef;

print "Please enter the dB of the signal \n";
$targetDB = <>;
chomp($targetDB);
print "Please enter frequency of the signal in MHz \n";
$frequency = <>;
chomp($frequency);
$distanceMetersUpper = 10*($targetDB - $constant - 20*(log($frequencyMHzUpper)/log(10)))/20;
$distanceMetersLower = 10*($targetDB - $constant - 20*(log($frequencyMHzLower)/log(10)))/20;
$distanceMeters = (10*($targetDB - $constant - 20*(log($frequency)/log(10))))/20;
#Experimental Equation
$distMeters = 10^((20*(log($frequency)/log(10))+$constant-$targetDB)/-20);
$distMeters = sprintf("%0.2f", $distMeters);
#-----------------------------------------------
$distanceMetersUpper = sprintf("%0.2f", $distanceMetersUpper);
$distanceMetersLower = sprintf("%0.2f", $distanceMetersLower);
$distanceMeters = sprintf("%0.2f", $distanceMeters);
print "Your target access point is somewhere between " . $distanceMetersLower . " and " . $distanceMetersUpper . " meters from your current location \n";
print "Your target is approx " . $distanceMeters . " meters from your current position \n";
print "Exparamental distance: " . $distMeters . " meters \n";
exit;

