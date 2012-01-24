#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';#tests => 6;
use Test::Exception;

BEGIN {
    use_ok('MooseX::Storage');
}

{   package Point;
    use Moose;
    use MooseX::Storage;

    with Storage( traits => [qw|OnlyWhenBuilt|] );

    has 'x' => (is => 'rw', lazy_build => 1 );
    has 'y' => (is => 'rw', lazy_build => 1 );
    has 'z' => (is => 'rw', builder => '_build_z' );
    
    
    sub _build_x { 'x' }
    sub _build_y { 'y' }
    sub _build_z { 'z' }

}

my $p = Point->new( 'x' => $$ );
ok( $p,                         "New object created" );

my $href = $p->pack;

ok( $href,                      "   Object packed" );
is( $href->{'x'}, $$,           "       x => $$" );
is( $href->{'z'}, 'z',          "       z => z" );
ok( not(exists($href->{'y'})),  "       y does not exist" );

is_deeply( 
    $href, 
    { '__CLASS__' => 'Point',
      'x' => $$,
      'z' => 'z'
    },                          "   Deep check passed" );
