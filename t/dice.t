use Test::More tests => 3008;

use strict;
use warnings;

BEGIN { use_ok('Games::Die::Dice'); }

{
	my $dice = Games::Die::Dice->new("10e12");
	is($dice, undef, "10e12 isn't a valid dice spec");
}

{
	my @sides = (2, 6, 10);
	my $dice = new Games::Die::Dice(@sides);
	isa_ok($dice, 'Games::Die::Dice');
	cmp_ok($dice->roll, '>', 3, "minimum roll reached");

	SKIP: for my $i (1 .. 1000) {
		my @roll = $dice->roll;
		skip "one broke", (1000 - $i) unless roll_ok(\@roll, \@sides);
	}
}

{
	my @sides = (20) x 6;
	my $dice = new Games::Die::Dice('6d20');
	isa_ok($dice, 'Games::Die::Dice');
	cmp_ok($dice->roll, '>', 6, "minimum roll reached");

	SKIP: for my $i (1 .. 1000) {
		my @roll = $dice->roll;
		skip "one broke", (1000 - $i) unless roll_ok(\@roll, \@sides);
	}
}

{
	my @sides = (6) x 3;
	my $dice = Games::Die::Dice->new("3d6+1");
	isa_ok($dice,"Games::Die::Dice");
	cmp_ok($dice->roll, '>', 4, "minimum roll reached");

	SKIP: for my $i (1 .. 1000) {
		my @roll = $dice->roll;
		skip "one broke", (1000 - $i)
			unless roll_ok(\@roll, \@sides, { adjust => 1 });
	}

}

sub roll_ok {
  my ($roll, $sides, $options) = @_;
  my $adjust = 0;
  if ($options and $options->{adjust}) { $adjust = $options->{adjust} }
  my $ok = 1;

  foreach my $index (0..@$sides-1) {
    if (!defined $roll->[$index]) {
			diag "Die #" . ($index+1) . ": rolled an undefined value";
      undef $ok;
      next;
    }
    if ($roll->[$index] < 1) {
      diag "Die #" . ($index+1) . ": rolled an impossibly-low number: $roll->[$index]\n";
      undef $ok;
      next;
    }
    if ($roll->[$index] > $sides->[$index]) {
      diag "Die #" . ($index+1) . ": rolled an impossibly high number: $roll->[$index] ($sides->[$index] sides)";
      $ok = undef;
      next;
    }
  }

  my ($minimum, $maximum) = (-$adjust, +$adjust);
  $maximum += $_ for @$sides;
  my $total = 0;
  $total += $_ for @$roll;
	
	if ($total > $maximum) {
		diag "total roll ($total) exceeds maximum ($maximum)";
		undef $ok;
	} elsif ($total < $minimum) {
		diag "total roll ($total) falls short of  minimum ($minimum)";
		undef $ok;
	}


  return ok($ok);
}

