package Games::Die;

=head1 NAME

Games::Die

=head1 DESCRIPTION

Games::Die provides an object-oriented implementation of a die.  The die may
contain any number of sides, not just those for which a physical
implementation is possible/feasible.  You can create a 7-, 29-, or 341-sided
die if the mood strikes you.  There is no limit to the number of sides.

=head1 SYNOPSIS

  $six_sided = new Games::Die(6);

  $twenty_sided = new Games::Die();
  $twenty_sided->sides(20);

  $result = $six_sided->roll() + $twenty_sided->roll();

=cut

use strict;
use vars qw($VERSION);

$VERSION = 0.03;

=head1 CONSTRUCTOR

=over 4

=item *

new()

Creates a new Die.  Takes the number of sides.

=back

=cut

sub new {
  my $class = shift;
  my $sides = shift;

  my $self = {
    sides => $sides,
  };

  bless $self, $class;
  return $self;
}

=head1 PUBLIC METHODS

=over 4

=item *

sides([$numsides])

If called without an argument, returns the number of sides the current die
has.  If called with a numerical argument, sets the number of sides.

=cut

sub sides {
  my $self = shift;
  my $sides = shift;
  if($sides) { $self->{sides} = $sides; }
  return $sides;
}

=item *

roll()

Rolls the die and returns the number that came up.

=cut

sub roll {
  my $self = shift;

  return 1 + int(rand() * ($self->{sides}-1));
}

=head1 AUTHORS

=over 4

=item Andrew Burke (burke@bitflood.org)

=item Jeremy Muhlich (jmuhlich@bitflood.org)

=back

=cut


1;

