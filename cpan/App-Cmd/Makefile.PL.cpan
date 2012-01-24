
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "write command line apps with less suffering",
  "AUTHOR" => "Ricardo Signes <rjbs\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Data::Dumper" => 0,
    "IPC::Cmd" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.96",
    "base" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "App-Cmd",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "App::Cmd",
  "PREREQ_PM" => {
    "Capture::Tiny" => "0.13",
    "Carp" => 0,
    "Class::Load" => "0.06",
    "Data::OptList" => 0,
    "File::Basename" => 0,
    "Getopt::Long::Descriptive" => "0.084",
    "IO::TieCombine" => 0,
    "Module::Pluggable::Object" => 0,
    "String::RewritePrefix" => 0,
    "Sub::Exporter" => 0,
    "Sub::Exporter::Util" => 0,
    "Sub::Install" => 0,
    "Text::Abbrev" => 0,
    "constant" => 0,
    "parent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.314",
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

WriteMakefile(%WriteMakefileArgs);



