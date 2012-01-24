
use strict;
use warnings;

use 5.008000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Organise your Moose types in libraries",
  "AUTHOR" => "Robert \"phaylon\" Sedlacek <rs\@474.at>",
  "BUILD_REQUIRES" => {
    "FindBin" => 0,
    "Test::Fatal" => 0,
    "Test::Moose" => 0,
    "Test::More" => "0.88",
    "Test::Requires" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "MooseX-Types",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "MooseX::Types",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Carp::Clan" => "6.00",
    "Moose" => "1.06",
    "Scalar::Util" => "1.19",
    "Sub::Install" => "0.924",
    "Sub::Name" => 0,
    "namespace::clean" => "0.19"
  },
  "VERSION" => "0.31",
  "test" => {
    "TESTS" => "t/*.t t/regressions/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



