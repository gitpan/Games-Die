package Games::Die::Dice::Result;

use warnings;
use strict;

=head1 NAME

Games::Die::Dice::Result - what you get when you roll some dice

=head1 VERSION

version 0.07_01

 $Id: Result.pm,v 1.1 2004/10/19 03:52:28 rjbs Exp $

=cut

our $VERSION = '0.07_01';

=head1 SYNOPSIS

 push @results, $dice->roll for (1 .. 10);
 
 @results = sort { $_->value <=> $_->value } @results;

 print "best roll: ",  join(' ', sort $results[0]->rolls), "\n";
 print "worst roll: ", join(' ', sort $results[9]->rolls), "\n";

=head1 DESCRIPTION

Result objects are returned when the C<roll> method is called on a
Game::Die::Dice set.

=head1 METHODS

=head2 new

This method creates a new result set.  You shouldn't need to use it outside of
the Dice class.  It is given the named argument C<rolls>, a reference to an
array of die results.  The argument C<adjust> is optional, and specifies a
number to be added to the totals.

=cut

sub new {
	my ($class, %arg) = @_;
	return unless $arg{rolls};
	bless \%arg => $class;
}

=head2 rolls

This returns a list of the die results.

=cut

sub rolls {
	my $self = shift;
	return @{$self->{rolls}};
}

=head2 total

This returns the total of the rolls, plus the adjustment.

=cut

sub total {
	my $self = shift;

	my $total = 0;
	$total += $_ for $self->rolls;
	$total += $self->{adjust};
	return $total;
}

=head2 value

In list context, this calls C<rolls> and calls C<total> otherwise.

=cut

sub value {
	my $self = shift;

	return $self->rolls if wantarray;
	return $self->total;
}

=head1 AUTHOR

Ricardo SIGNES, <C<rjbs@cpan.org>>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-games-die-dice-results@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically be
notified of progress on your bug as I make changes.

=head1 COPYRIGHT

Copyright 2004, Ricardo SIGNES.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
