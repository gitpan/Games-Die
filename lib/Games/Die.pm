package Games::Die;

use strict;
use warnings;

use Carp;

use vars qw($VERSION);

$VERSION = 0.06;

=head1 NAME

Games::Die - a die; you can roll it!

=head1 VERSION

version 0.06

 $Id: Die.pm,v 1.3 2004/10/13 23:52:07 rjbs Exp $

=head1 SYNOPSIS

	$six_sided = new Games::Die(6);

	$twenty_sided = new Games::Die();
	$twenty_sided->sides(20);

	$result = $six_sided->roll() + $twenty_sided->roll();

=head1 DESCRIPTION

Games::Die provides an object-oriented implementation of a die.	The die may
contain any number of sides, not just those for which a physical
implementation is possible/feasible.	You can create a 7-, 29-, or 341-sided
die if the mood strikes you.	There is no limit to the number of sides.

=head1 METHODS

=cut

# _sides_ok($sides)
#
# T if sides is valid number of sides; F otherwise

my $integer = qr/^\d+$/;
sub _sides_ok {
	my ($class, $sides) = @_;
	unless ($sides =~ $integer) {
		carp "number of sides not a non-negative integer";
		return;
	}
	return 1
}

=head2 C<< new($sides) >>

This method creates and returns a new Die.	The number of sides must be a
non-negative integer.

=cut

sub new {
	my $class = shift;
	my $sides = shift;

	return unless $class->_sides_ok($sides);

	bless { sides => $sides } => $class;
}

=head2 C<< sides( [$sides] ) >>

If called without an argument, returns the number of sides the current die
has.	If called with a numerical argument, sets the number of sides.

=cut

sub sides {
	my $self = shift;
	return $self->{sides} unless @_;
	my $sides = shift;
	return unless $self->_sides_ok($sides);
	$self->{sides} = $sides;
}

=head2 C<< roll >>

Rolls the die and returns the number that came up.

=cut

sub roll {
	my $self  = shift;
	my $sides = $self->sides;

	return 0 if $sides == 0;
	return int(rand($sides)) + 1;
}

=head1 TODO

=over 4

=item * more extensive validation of parameters

=item * improved access to members of a Dice set

=item * return results as a Results object; last results cached on the Dice

=back

=head1 THANKS

...to Dave Ranney, for finding the stupid minus-one bug in roll() in 0.03

...to Thomas R. Sibley, for pointing out the poor roll() implementation in 0.02

=head1 AUTHORS

Andrew Burke <C<burke@bitflood.org>>

Jeremy Muhlich <C<jmuhlich@bitflood.org>>

Ricardo SIGNES <C<rjbs@cpan.org>>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
