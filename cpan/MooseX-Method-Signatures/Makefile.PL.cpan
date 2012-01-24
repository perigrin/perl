
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Method declarations with type constraints and no source filter",
  "AUTHOR" => "Florian Ragwitz <rafl\@debian.org>, Ash Berlin <ash\@cpan.org>, Cory Watson <gphat\@cpan.org>, Daniel Ruoso <daniel\@ruoso.com>, Dave Rolsky <autarch\@urth.org>, Hakim Cassimally <hakim.cassimally\@gmail.com>, Jonathan Scott Duff <duff\@pobox.com>, Justin Hunter <justin.d.hunter\@gmail.com>, Kent Fredric <kentfredric\@gmail.com>, Maik Hentsche <maik.hentsche\@amd.com>, Matt Kraai <kraai\@ftbfs.org>, Rhesa Rozendaal <rhesa\@cpan.org>, Ricardo SIGNES <rjbs\@cpan.org>, Steffen Schwigon <ss5\@renormalist.net>, Yanick Champoux <yanick\@babyl.dyndns.org>, Nicholas Perez <nperez\@cpan.org>",
  "BUILD_REQUIRES" => {
    "FindBin" => 0,
    "Moose::Role" => 0,
    "MooseX::Meta::Method::Authorized" => 0,
    "MooseX::Meta::Method::Transactional" => 0,
    "Test::Exception" => 0,
    "Test::Moose" => 0,
    "Test::More" => "0.89",
    "Test::Pod" => 0,
    "attributes" => 0,
    "metaclass" => 0,
    "namespace::clean" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "MooseX-Method-Signatures",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "MooseX::Method::Signatures",
  "PREREQ_PM" => {
    "B::Hooks::EndOfScope" => "0.07",
    "Carp" => 0,
    "Context::Preserve" => 0,
    "Devel::Declare" => "0.005011",
    "Devel::Declare::Context::Simple" => 0,
    "Moose" => "0.89",
    "Moose::Meta::Class" => 0,
    "Moose::Meta::Method" => 0,
    "Moose::Util" => 0,
    "Moose::Util::TypeConstraints" => 0,
    "MooseX::LazyRequire" => "0.06",
    "MooseX::Meta::TypeConstraint::ForceCoercion" => 0,
    "MooseX::Types" => "0.19",
    "MooseX::Types::Moose" => "0.19",
    "MooseX::Types::Structured" => "0.20",
    "MooseX::Types::Util" => 0,
    "Parse::Method::Signatures" => "1.003014",
    "Parse::Method::Signatures::Param::Named" => 0,
    "Parse::Method::Signatures::Param::Placeholder" => 0,
    "Parse::Method::Signatures::TypeConstraint" => 0,
    "Parse::Method::Signatures::Types" => 0,
    "Scalar::Util" => 0,
    "Sub::Name" => 0,
    "Task::Weaken" => 0,
    "Text::Balanced" => 0,
    "aliased" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.37",
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



