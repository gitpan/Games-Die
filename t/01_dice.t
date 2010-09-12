#!/usr/bin/perl
use Test::More qw(no_plan);
use Test::Differences;
use Games::Die;

sub regexp {
    my %vars = ( times => 20, @_ );
    my $regexp = join( '|', ( $vars{'first'} .. $vars{'last'} ) );
    like( $vars{value}, qr/$regexp/, "test $_/$vars{times}" )
      for ( 1 .. $vars{times} );
}
regexp(
    'value' => roll("3d6"),
    'first' => 3,
    'last'  => 18,
    'times' => 100
);
regexp(
    'value' => roll("d6-1"),
    'first' => 1,
    'last'  => 5,
    'times' => 20
);
regexp(
    'value' => roll("d2+d3"),
    'first' => 2,
    'last'  => 5,
    'times' => 20
);
regexp(
    'value' => roll("4d{1}6"),
    'first' => 3,
    'last'  => 18,
    'times' => 1
);
is( roll("1d1=1"),     '1*' );
is( roll("1d1>1"),     '1' );
is( roll("1d1>=1"),    '1*' );
is( roll("1>>1"),      '1>>2' );
is( roll("(1d1=1)+1"), '2*' );
is( roll("1d1=1+1"),   '1' );
is( roll("2=1+1"),     '2*' );

