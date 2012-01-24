
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Time zone object base class and factory",
  "AUTHOR" => "Dave Rolsky <autarch\@urth.org>",
  "BUILD_REQUIRES" => {
    "Test::More" => "0.88"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.58"
  },
  "DISTNAME" => "DateTime-TimeZone",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "DateTime::TimeZone",
  "PREREQ_PM" => {
    "Class::Load" => 0,
    "Class::Singleton" => "1.03",
    "Cwd" => 3,
    "Params::Validate" => "0.72",
    "Pod::Man" => "1.14",
    "parent" => 0
  },
  "VERSION" => "1.42",
  "test" => {
    "TESTS" => "t/*.t"
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

if ( $^O eq 'MSWin32' ) {
  $WriteMakefileArgs{PREREQ_PM}{'Win32::TieRegistry'} = '0';
}

if ( $^O eq 'hpux' ) {
  $WriteMakefileArgs{PREREQ_PM}{'DateTime::TimeZone::HPUX'} = '0';
}

WriteMakefile(%WriteMakefileArgs);



