package Games::Die::Dice;

use strict;
use vars qw($VERSION);
use Games::Die; 

$VERSION = 0.01;

sub new {
  my $class = shift;
  my @sides = @_;

  my $self = {
    diceset => [],
  };

  bless $self, $class;

  foreach my $numsides (@sides) {
    push(@{$self->{diceset}}, new Games::Die($numsides));
  }

  return $self;
}

sub roll {
  my $self = shift;
  my @result;

  foreach my $die (@{$self->{diceset}}) {
    push(@result, $die->roll());
  }

  return @result;
}
    

1;

