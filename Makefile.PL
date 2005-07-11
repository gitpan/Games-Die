use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME          => 'Games::Die',
  AUTHOR        => 'Ricardo SIGNES <rjbs@cpan.org>',
  VERSION_FROM  => 'lib/Games/Die.pm',
  ABSTRACT_FROM => 'lib/Games/Die.pm',
  PL_FILES      => {},
  PREREQ_PM => {
    'Class::Container' => 0,
    'Test::More'       => 0,
  },
  dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
  clean         => { FILES => 'Games-Die-* cover_db' },
);
