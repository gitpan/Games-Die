package Games::Die;

use strict;
use vars qw($VERSION);

$VERSION = 0.01;

sub new {
  my $class = shift;
  my $sides = shift;

  my $self = {
    sides => $sides,
  };

  bless $self, $class;
  return $self;
}

sub roll {
  my $self = shift;

  return 1 + ((rand() * 100) % $self->{sides});
}


1;

