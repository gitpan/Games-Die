package Games::Die::Dice;

=head1 NAME

Games::Die::Dice

=head1 DESCRIPTION

Games::Die::Dice provides a union of any number of Games::Die objects.

=head1 SYNOPSIS

  $four_eight_ten = new Games::Die::Dice(4, 8, 10);
  $pair_of_eights = new Games::Die::Dice('2d8');

  $result = $four_eight_ten->roll() + $pair_of_eights->roll();

=cut

use strict;
use Games::Die; 

=head1 CONSTRUCTOR

=over 4

=item *

new()

Creates a new set of Dice.  Takes a list containing the number of sides of
each die in the set, or a single "Dungeons and Dragons"-style specification
such as "2d8" or "6d20+2".  The d may be upper- or lower-case, and the
modifier may be a positive or negative integer.

=back

=cut

sub new {
  my $class = shift;
  my @sides = @_;

  my $self = {
    diceset => [],
    adjust  => 0,
  };

  bless $self, $class;

  # check for "xDy" with optional +/-N suffix (case insensitive)
  if (@sides == 1 and $sides[0] =~ /^(\d+)d(\d+)([-+]\d+)?$/i) {
    @sides = ($2) x $1;
    $self->{adjust} = $3 if defined $3;
  }

  foreach my $numsides (@sides) {
    push(@{$self->{diceset}}, new Games::Die($numsides));
  }

  return $self;
}

=head1 PUBLIC METHODS

=over 4

=item *

roll()

Rolls each die in the set.  In scalar context, returns the sum.  In list
context, returns the list of values that came up on each die.

=cut

sub roll {
  my $self = shift;
  my @values;

  foreach my $die (@{$self->{diceset}}) {
    push(@values, $die->roll());
  }
  push @values, $self->{adjust};

  if (wantarray) {
    return @values;
  } else {
    my $sum = 0;
    foreach my $value (@values) {
      $sum += $value;
    }
    return $sum;
  }
}
    
=head1 AUTHORS

=over 4

=item Andrew Burke (burke@bitflood.org)

=item Jeremy Muhlich (jmuhlich@bitflood.org)

=back

=cut

1;

