#!perl -T

use Test::More tests => 2;

use_ok( 'Games::Die' );
use_ok( 'Games::Die::Dice' );

diag( "Testing Games::Die $Games::Die::VERSION" );
