use strict;
use Test::More tests => 14;

BEGIN { use_ok("Games::Die"); }

{
	my $die = Games::Die->new("bananaphone");
	is($die, undef, "invalid sides for die");
}

{
	my $die = Games::Die->new(6);
	isa_ok($die, 'Games::Die');

	cmp_ok($die->sides,     '==',  6, "six-sided die created");
	    is($die->sides("x"),   undef, "can't change to invalid sides");
	cmp_ok($die->sides,     '==',  6, "still a six-sided die");
}

{
	my $die = Games::Die->new(6);
	isa_ok($die, 'Games::Die');

	cmp_ok($die->sides,     '==',  6, "six-sided die created");
	cmp_ok($die->sides(10), '==', 10, "made into a d10");
	cmp_ok($die->sides,     '==', 10, "still a ten-sided die");

	my ($roll1, $roll2) = ($die->roll, $die->roll);
	ok((defined $roll1 and defined $roll2), "some die rolls return values");
}

{
	my $die = Games::Die->new(0);
	isa_ok($die, 'Games::Die');

	cmp_ok($die->sides,     '==',  0, "one-sided die created");
	cmp_ok($die->roll,      '==',  0, "roll a d0, get a zero");
}

