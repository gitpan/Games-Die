use strict;
use Test::More tests => 16;

BEGIN { use_ok("Games::Die"); }

{
	our $warning;
	local $SIG{__WARN__} = sub { $warning = shift };
	my $die = Games::Die->new("bananaphone");
	is($die, undef, "invalid sides for die");
	like($warning, qr/non-negative/, "got correct warning");
}

{
	my $die = Games::Die->new(6);
	isa_ok($die, 'Games::Die');

	cmp_ok($die->sides,     '==',  6, "six-sided die created");

	our $warning;
	local $SIG{__WARN__} = sub { $warning = shift };
	is($die->sides("x"),   undef, "can't change to invalid sides");
	like($warning, qr/non-negative/, "got correct warning");

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

