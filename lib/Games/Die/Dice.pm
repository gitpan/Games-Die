package Games::Die::Dice;

use strict;
use warnings;

use Games::Die; 
use Games::Die::Dice::Result; 
use Carp;

use vars qw($VERSION);
$VERSION = '0.07_01';

=head1 NAME

Games::Die::Dice - more than one die

=head1 DESCRIPTION

Games::Die::Dice provides a union of any number of Games::Die objects.

=head1 VERSION

version 0.07_01

 $Id: Dice.pm,v 1.5 2004/10/19 03:52:28 rjbs Exp $

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

sub _expand_spec {
	my ($self) = @_;

	if ($self->{dice}[0] =~ /^(\d+)d(\d+)([-+]\d+)?$/i) {
		$self->{dice} = [ ($2) x $1 ];
		$self->{adjust} = $3 if defined $3;
	}
}

sub new {
	my $class = shift;

	bless my $self = { adjust => 0, dice => [ @_ ] } => $class;

	$self->_expand_spec if @_ == 1;

	$self->{dice} = [
		map { UNIVERSAL::isa($_, 'Games::Die') ? $_ : Games::Die->new($_) }
		@{$self->{dice}}
	];
	
	return unless @{$self->{dice}};
	return $self;
}

=head2 C<< dice >>

This returns a list of the Games::Die objects in the set.

=cut

sub dice {
	my ($self) = @_;
	@{$self->{dice}};
}

=head2 C<< roll >>

Rolls each die in the set.	In scalar context, returns the sum.	In list
context, returns the list of values that came up on each die (and also
the adjust value if specified).

=cut

sub roll {
	my $self = shift;

	$self->{last_result} = Games::Die::Dice::Result->new(
		rolls => [ map { $_->roll } @{$self->{dice}} ],
		adjust => $self->{adjust}
	);

	$self->{last_result}->value;
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

