use strict;
use Test;

BEGIN { plan tests => 6 };

ok(eval { require Games::Die::Dice; });

use Games::Die::Dice;
ok(1);

my @sides = (2, 6, 10);
my $dice = new Games::Die::Dice(@sides);
ok($dice);

my (@roll, $ok);

$ok = 1;
for (my $i=0; $i<1000; $i++) {
  @roll = $dice->roll;
  if (!valid_roll(\@roll, \@sides)) {
    $ok = undef;
    print STDERR "Invalid roll: ", join(',', @roll),
          " (dice sides: ", join(',', @sides), ")\n";
    last;
  }
}
ok($ok);

$dice = new Games::Die::Dice('6d20');
@sides = (20) x 6;
$ok = 1;
for (my $i=0; $i<1000; $i++) {
  @roll = $dice->roll;
  if (!valid_roll(\@roll, \@sides)) {
    $ok = undef;
    print STDERR "Invalid roll: ", join(',', @roll),
          " (dice sides: ", join(',', @sides), ")\n";
    last;
  }
}
ok($ok);

my $sum = $dice->roll;
$ok = 1;
for (my $i=0; $i<1000; $i++) {
  if ($sum > 180) { # 6 * 20 from above
    $ok = undef;
    last;
  }
}
ok($ok);


sub valid_roll {
  my ($roll, $sides) = @_;
  my $ret;

  $ret = 1;

  foreach my $index (0..@$sides-1) {
    if (!defined $roll->[$index]) {
      print STDERR "Die #", $index+1, ": rolled an undefined value\n";
      $ret = undef;
      next;
    }
    if ($roll->[$index] <= 0) {
      print STDERR "Die #", $index+1, ": rolled a non-positive number: $roll->[$index]\n";
      $ret = undef;
      next;
    }
    if ($roll->[$index] > $sides->[$index]) {
      print STDERR "Die #", $index+1, ": only has $sides->[$index] sides, rolled a $roll->[$index]\n";
      $ret = undef;
      next;
    }
  }

  return $ret;
}

