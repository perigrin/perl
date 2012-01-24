
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601",
    "Test::Fatal" => 0,
    "Test::More" => "0.88"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "XS implementation of parts of Class::Load",
  "dist_author" => [
    "Dave Rolsky <autarch\@urth.org>"
  ],
  "dist_name" => "Class-Load-XS",
  "dist_version" => "0.03",
  "license" => "artistic_2",
  "module_name" => "Class::Load::XS",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Class::Load" => "0.11"
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
