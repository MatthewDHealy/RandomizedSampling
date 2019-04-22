#!/usr/bin/perl -w

# RandomSample.pl filename numchunks chunknum seedstring
#
# To sample with replacement, use different seed values
# To sample without replacement, use different chunknum values
# To make a smaller sample, use a larger numchunks value
#
# Repeatable randoumized sampling: the same command run on the
# same input file will always generate the same output
#
# For truly random sampling, use some physical source of
# random noise to generate the seed string
#
# Use of SHA-256 hashing provides a high degree of confidence
# that our sampling is statistically uncorrelated with anything
# else

use strict;
use Digest::SHA qw(sha256);

my ($infile, $modulus, $value, $seed) = @ARGV;

$modulus = 32 unless defined ($modulus);
$seed = 'MyLiTtLeuNiQuEFuNkY572846ChARactEr56StRiNg' unless defined ($seed);
$value = 9 unless defined ($value);

warn ("input=$infile, modulus=$modulus, value=$value, seedstring=$seed\n");
open (my $input, '<:encoding(UTF-8)', $infile) or die qq(Unable to open "$infile": $!);

while(<$input>)
{
    my $line = $_;
    $line =~ s/[\n\r]+//g;
    my $hash = sha256($line .  $seed . $.);
    $hash = unpack("H*", $hash);
    my $digits = $hash;
   $digits =~ s/[^0-9]+//g;
    $digits = substr($digits,0,14);
    # in hex format, 256 bits are 64 characters.  On average about
    # 40 of those 64 hex characters will be decimal digits, and
    # it will be extremely rare that fewer than 25 of them are.
    # So it is almost certain that we'll get at least 14 digits.
    my $mod = $digits % $modulus;
    if (($.==1) or ($mod == $value)) {print "$line\n";}
}

