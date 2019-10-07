#!/usr/bin/env perl

use strict;
use Getopt::Long;
Getopt::Long::Configure("bundling");

my $verseNumbers;
my $countQ;

GetOptions (
  "v|verses=s"  => \$verseNumbers,
  "c|count"     => \$countQ,
);

my $file = $ARGV[0];

die "ERROR: no file!\n\tchose-verse.pl [filename] -v \"verse numbers (eg. 1 2 .. 99)\"\n" if !$file;

if ($countQ) {
  $verseNumbers = "x";
}


die "ERROR: no verse numbers!\n\tchose-verse.pl [filename] -v \"verse numbers (eg. 1 2 .. 99)\"\n" if !$verseNumbers;

my @VNum = split(" ", $verseNumbers);

open(FILE, $file);
my @content = <FILE>;
close(FILE);

my @kernGrep = grep "\*\*kern", @content;
my @filemap = split("\t", $kernGrep[0]);

my $countVerses;
my $tempCountVerses;
for (my $i = 0; $i < @filemap; $i++) {


  if ($filemap[$i] =~ /\*\*kern/) {
    if ($tempCountVerses > $countVerses) {
      $countVerses = $tempCountVerses;
    }
    $tempCountVerses = 0;

  } elsif ($filemap[$i] =~ /\*\*text/) {
    $tempCountVerses++;
    if ($i == @filemap) {
      if ($tempCountVerses > $countVerses) {
        $countVerses = $tempCountVerses;
      }

    }

  }

}

if ($countQ) {
  print "Number of verses: $countVerses\n";
  exit;
}



for (my $i = 0; $i < @VNum; $i++) {
  die "ERROR: one or more given verse numbers exceed total number of verses\n" if ($VNum[$i] > $countVerses);
}

my @spines;
my $kernNumber;
for (my $i = 0; $i < @filemap; $i++) {
  my $spinenumber = $i+1;
  if ($filemap[$i] =~ /\*\*kern/) {
    push(@spines, $spinenumber);
    $kernNumber = $spinenumber;
  } elsif ($filemap[$i] =~ /\*\*text/) {
    my $currentVerseNo = $spinenumber - $kernNumber;

    for (my $j = 0; $j < @VNum; $j++) {
      if ($VNum[$j] eq $currentVerseNo) {
        push(@spines, $spinenumber);
        last;
      }

    }

  } else {
    push(@spines, $spinenumber);
  }

}

my $spineList = join(",", @spines);

my $command = "extractx -s $spineList $file";

my $output = `$command`;
print $output;
