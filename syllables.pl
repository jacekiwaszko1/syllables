#!/usr/bin/perl -CS

use strict;
#use warnings;

use Encode;

use Getopt::Long;
Getopt::Long::Configure("bundling");


my $latinQ;
my $polishQ;

GetOptions (
"l|latin" => \$latinQ,
"p|polish" => \$polishQ,
);


my @line = <>;

my @vowels = qw(a ą e ę i o ó u y æ);
my @consonants = qw(b c ć d f g h j k l ł m n ń p q r s ś t v w x z ź ż);
my @interpunctions = qw(, . ; : ? ! " );
my @diphthongs;
my @triphthongs;

if ($latinQ) {
  @diphthongs = qw(ae oe ph th qu au  );
  @triphthongs = qw(qui qua que quo gui gua gue);
} elsif ($polishQ) {
  @diphthongs = qw(gr tw kr sk cz sz rz ch ie ia dz iu io ió ię ią);
  @triphthongs = qw(grz krz);
} else {
  @diphthongs = qw(gr tw sk kr cz sz rz ch ie ia dz iu io ió ią ię);
  @triphthongs = qw(grz krz);
}




my @syllables;
my $syllableCount = 0;

foreach my $zzlines (@line) {
  $zzlines = encode 'utf-8', $zzlines;
}


foreach my $cons (@consonants) {
  $cons = decode 'utf-8', $cons;
}

foreach my $vows (@vowels) {
  $vows = decode 'utf-8', $vows;
}

foreach my $diphs (@diphthongs) {
  $diphs = decode 'utf-8', $diphs;
}



for (my $i = 0; $i < @line; $i++) {
  chomp $line[$i];
  #print $line[$i], "\t";
  my @words = split(" ", $line[$i]);
  my $previous;
  my $next;
  my $next2;
  for (my $j = 0; $j < @words; $j++) {
    my $encWord = decode 'utf-8', $words[$j];
    my @letters = split("", $encWord);
    my $vowelQ;
    for (my $k = 0; $k < @letters; $k++) {

      my $type = checkType($letters[$k]);

      #print "$letters[$k]";
      #print "($type)";

      $next = $letters[$k+1];
      $next2 = $letters[$k+2];

      ######################
      ### Jednoliterówki ###
      ######################

      if (!$previous && !$next) {
        $syllables[$syllableCount] .= $letters[$k];
        if ($type eq "v") {
          $previous = "";
          $syllables[$syllableCount] .= " ";
          $syllableCount++;
          $vowelQ = "";
        } elsif ($type eq "c") {
          $previous = "$letters[$k]";
          $syllables[$syllableCount] .= "_";
        }

      ########################
      ### Ostatnia literka ###
      ########################

      } elsif ($previous && !$next) {
        if ($latinQ) {
          if (checkType($previous) eq "v" && checkType($letters[$k]) eq "v" && !checkDiphthongs($previous, $letters[$k])) {
            $syllables[$syllableCount] .= "-";
            $syllableCount++;
            $previous = "-";
          }

        }

        $syllables[$syllableCount] .= "$letters[$k] ";
        $syllableCount++;
        $previous = "";
        $vowelQ = "";

      ########################
      ### Pierwsza literka ###
      ########################

      } elsif (!$previous && $next) {
        $syllables[$syllableCount] .= "$letters[$k]";
        $previous = $letters[$k];



      ########################
      ### Literki środkowe ###
      ########################

    } elsif ($previous && $next) {
        if (checkTriphthongs($previous, $letters[$k], $next)) {
          $syllables[$syllableCount] .= "$letters[$k]";
          $syllables[$syllableCount] .= "$next";
          $previous = $next;
          if (!$next2) {
            $syllables[$syllableCount] .= " ";
            $syllableCount++;
            $previous = "";
            $vowelQ = "";
          }

          $k++;




        } elsif (!$vowelQ) {
          if (checkDiphthongs($previous, $letters[$k])) {
            $syllables[$syllableCount] .= "$letters[$k]";
            $previous = $letters[$k];
          } else {
            $syllables[$syllableCount] .= "$letters[$k]";
            $previous = $letters[$k];
          }


        } elsif ($vowelQ) {

          if ($type eq "v" && checkDiphthongs($previous, $letters[$k])) {
              $syllables[$syllableCount] .= "$letters[$k]";
              $previous = $letters[$k];

          } else {

            if (checkForEnd($previous, $letters[$k], $next, $k, @letters)) {
              $syllables[$syllableCount] .= "-";
              $syllableCount++;
              $syllables[$syllableCount] .= "$letters[$k]";
              $previous = $letters[$k];
              $vowelQ = "";
            } else {
              $syllables[$syllableCount] .= "$letters[$k]";
              $previous = $letters[$k];
            }

          }



        }


      }
      if ($type eq "v") {
        $vowelQ++;
      }
    }

    #print " ";
  }
  $syllables[$syllableCount] .= "\n";
  #print "\n";
}

print @syllables;



#########################
### Oznacz typ litery ###
#########################

sub checkType {
  my ($letter) = @_;

  my @vowQ;
  my @consQ;
  my @interpQ;
  my $type;

  if ($letter eq "?" || $letter eq "(" || $letter eq ")") {
    $type = "i";
    return $type;
  } else {
    @vowQ = grep(/$letter/i, @vowels);
    @consQ = grep(/$letter/i, @consonants);
    @interpQ = grep(/$letter/i, @interpunctions);

    if (@interpQ > 0) {
      $type = "i";
    } elsif (@vowQ > 0) {
      $type = "v";
    } elsif (@consQ > 0) {
      $type = "c";
    }
    return $type;

  }

}


########################
### Sprawdź dyftongi ###
########################

sub checkDiphthongs {
  my ($first, $second) = @_;
  if (checkType($first) eq "i" || checkType($second) eq "i") {
    return 0;
  } else {
    my @diphQ = grep(/^$first$second$/i, @diphthongs);
    if (@diphQ > 0) {
      return 1;
    }
  }


}

########################
### Sprawdź tryftongi ###
########################

sub checkTriphthongs {
  my ($first, $second, $third) = @_;

  my @triphQ = grep(/^$first$second$third$/i, @triphthongs);
  if (@triphQ > 0) {
    return 1;
  }

}

#############################
### Sprawdź koniec sylaby ###
#############################

sub checkForEnd {
  my ($prev, $curr, $next, $curK, @lett) = @_;

  my $nextK2 = $curK + 2;
  my $next2 = $lett[$nextK2];

  my $nextK3 = $curK + 3;
  my $next3 = $lett[$nextK3];

    ## samogłoska przy samogłosce (swo-ich)
    if (checkType($curr) eq "v") {
      return 1;
    ## spółgloska i samogłoska po samogłosce
    } elsif (checkType($curr) eq "c" && checkType($next) eq "v") {
      return 1;
    } elsif (checkTriphthongs($curr, $next, $next2)) {
      if (checkType($next3) eq "v") {
        return 1;
      } else {
        return 0;
      }

    } elsif (checkDiphthongs($curr, $next)) {
      if (checkType($next2) eq "v") {
        return 1;
      } else {
        return 0;
      }



    }





}
