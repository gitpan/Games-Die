use strict;
use Test;

BEGIN { plan tests => 4 };

ok(eval { require Games::Die; });

use Games::Die;
ok(1);

my $die = new Games::Die(6);
ok($die);

my ($roll1, $roll2);
$roll1 = $die->roll;
$roll2 = $die->roll;
ok(defined $roll1 and defined $roll2);
