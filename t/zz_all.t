use strict;
use Test;

BEGIN { plan tests => 7 };

ok(eval { require Games::Die; });
ok(eval { require Games::Die::Dice; });

use Games::Die;
ok(1);
use Games::Die::Dice;
ok(1);

my $die = new Games::Die(6);
ok($die);
my $dice = new Games::Die::Dice(2,6,10);
ok($dice);
my $dice2 = new Games::Die::Dice('30d100');
ok($dice2);

