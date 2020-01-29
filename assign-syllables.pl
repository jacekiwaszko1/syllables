#!/usr/bin/env perl

use strict;

my $kernFile = $ARGV[0];
my $textFile = $ARGV[1];
my $debugQ;

if (!$kernFile || !$textFile || @ARGV > 2 ) {
  print "ERROR: wrong arguments\n\tassign-syllables [file.krn] [text.krn]\n";
  exit;
}

open(FILE, $kernFile);
my @kern = <FILE>;
close(FILE);

open(FILE, $textFile);
my @text = <FILE>;
close(FILE);

my @grepText = grep ("\*\*text", @text);
my $textLine = $grepText[0];
my $verseCount = split("\t", $textLine);


my @grepKern = grep(/^\*\*kern/, @kern);
my $kernLine = $grepKern[0];
print "kernLine = $kernLine\n" if $debugQ;
my @spineMap = split("\t", $kernLine);

my $textCount;
for (my $h = 0; $h < @spineMap; $h++) {
  if ($spineMap[$h] =~ /text/) {
    $textCount++;
  }
}

my @voiceTextLineCount;
for (my $g = 0; $g < $textCount; $g++) {
  $voiceTextLineCount[$g] = 1;
}



for (my $i = 0; $i < @kern; $i++) {
  my $voiceWithTextCount = 0;
  if ($kern[$i] =~ /^!!/) {
    print $kern[$i];
    next;
  }
  my @line = split("\t", $kern[$i]);

  for (my $j = 0; $j < @line; $j++) {
    chomp $line[$j];
    if ($spineMap[$j] =~ /kern/ ) {
      next;
    } else {
      if ($line[$j] =~ /^\*/
      || $line[$j] =~ /^!/
      || $line[$j] =~ /^\./
      || $line[$j] =~ /^=/ ) {
        $line[$j] = multiplicateToken($line[$j], $verseCount);
        #print "$line[$j]";
      } else {
        my $textToken = $text[$voiceTextLineCount[$voiceWithTextCount]];
        chomp $textToken;
        $line[$j] = $textToken;
        $voiceTextLineCount[$voiceWithTextCount]++;
      }

      $voiceWithTextCount++;
    }

  }
  print join("\t", @line), "\n";
}


#####################################
##
## multiplicateToken --
##

sub multiplicateToken {
  my ($token,$multiplier) = @_;
  my $multipliedToken;
  for (my $i = 0; $i < $multiplier; $i++) {
    $multipliedToken .= $token;
    if ($i < $multiplier - 1) {
      $multipliedToken .= "\t";
    }

  }
  return $multipliedToken;

}
