package Games::Die::Dice;

use strict;
use warnings;

use Games::Die; 

use vars qw($VERSION);
$VERSION = 0.06;

=head1 NAME

Games::Die::Dice - more than one die

=head1 DESCRIPTION

Games::Die::Dice provides a union of any number of Games::Die objects.

=head1 VERSION

version 0.06

 $Id: Dice.pm,v 1.3 2004/10/13 23:52:07 rjbs Exp $

=head1 SYNOPSIS

	$four_eight_ten = new Games::Die::Dice(4, 8, 10);
	$pair_of_eights = new Games::Die::Dice('2d8');

	$result = $four_eight_ten->roll() + $pair_of_eights->roll();

=head1 METHODS

=head2 C<< new >>

Creates a new set of Dice.	Takes a list containing the number of sides of
each die in the set, or a single "Dungeons and Dragons"-style specification
such as "2d8" or "6d20+2".	The d may be upper- or lower-case, and the
modifier may be a positive or negative integer.

=cut

sub new {
	my $class = shift;
	my @sides = @_;

	my $self = {
		diceset => [],
		adjust	=> 0,
	};

	bless $self, $class;

	# check for "xDy" with optional +/-N suffix (case insensitive)
	if (@sides == 1 and $sides[0] =~ /^(\d+)d(\d+)([-+]\d+)?$/i) {
		@sides = ($2) x $1;
		$self->{adjust} = $3 if defined $3;
	}

	foreach my $numsides (grep { $_ =~ /^\d+$/ } @sides) {
		push(@{$self->{diceset}}, new Games::Die($numsides));
	}
	
	return unless @{$self->{diceset}};
	return $self;
}

=head2 C<< roll() >>

Rolls each die in the set.	In scalar context, returns the sum.	In list
context, returns the list of values that came up on each die (and also
the adjust value if specified).

=cut

sub roll {
	my $self = shift;

	my @values = map { $_->roll } @{$self->{diceset}};

	push @values, $self->{adjust} if $self->{adjust};

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

Andrew Burke <C<burke@bitflood.org>>

Jeremy Muhlich <C<jmuhlich@bitflood.org>>

Ricardo SIGNES <C<rjbs@cpan.org>>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;

