#
# Skeleton Perl Makefile
#
# Last updated by jmuhlich on Wed Feb 21 01:47:04 EST 2001
#

use strict;

# Check for modules we need.
$| = 1;
my $missing_modules = 0;


use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'	   => 'Games::Die',
    'VERSION_FROM' => 'lib/Games/Die.pm',

    'dist'         => {
                         COMPRESS => 'gzip -9f',
                         SUFFIX => 'gz',
                      },
);

