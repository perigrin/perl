#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use Test::Requires {
    'Test::JSON' => 0.01, # skip all if not installed
    'JSON::Any' => 0.01,
};

BEGIN {
    plan tests => 12;
    use_ok('MooseX::Storage');
}

{

    package Foo;
    use Moose;
    use MooseX::Storage;

    with Storage( 'format' => 'JSON' );

    has 'number' => ( is => 'ro', isa => 'Int' );
    has 'string' => ( is => 'ro', isa => 'Str' );
    has 'float'  => ( is => 'ro', isa => 'Num' );
    has 'array'  => ( is => 'ro', isa => 'ArrayRef' );
    has 'hash'   => ( is => 'ro', isa => 'HashRef' );
    has 'object' => ( is => 'ro', isa => 'Object' );
}

{
    my $foo = Foo->new(
        number => 10,
        string => 'foo',
        float  => 10.5,
        array  => [ 1 .. 10 ],
        hash   => { map { $_ => undef } ( 1 .. 10 ) },
        object => Foo->new( number => 2 ),
    );
    isa_ok( $foo, 'Foo' );

    my $json = $foo->freeze;

    is_valid_json($json, '.. this is valid JSON');


    is_json(
        $json,
'{"array":[1,2,3,4,5,6,7,8,9,10],"hash":{"6":null,"3":null,"7":null,"9":null,"2":null,"8":null,"1":null,"4":null,"10":null,"5":null},"float":10.5,"object":{"number":2,"__CLASS__":"Foo"},"number":10,"__CLASS__":"Foo","string":"foo"}',
        '... got the right JSON'
    );

}

{
    my $foo =
      Foo->thaw(
'{"array":[1,2,3,4,5,6,7,8,9,10],"hash":{"6":null,"3":null,"7":null,"9":null,"2":null,"8":null,"1":null,"4":null,"10":null,"5":null},"float":10.5,"object":{"number":2,"__CLASS__":"Foo"},"number":10,"__CLASS__":"Foo","string":"foo"}'
      );
    isa_ok( $foo, 'Foo' );

    is( $foo->number, 10,    '... got the right number' );
    is( $foo->string, 'foo', '... got the right string' );
    is( $foo->float,  10.5,  '... got the right float' );
    is_deeply( $foo->array, [ 1 .. 10 ], '... got the right array' );
    is_deeply(
        $foo->hash,
        { map { $_ => undef } ( 1 .. 10 ) },
        '... got the right hash'
    );

    isa_ok( $foo->object, 'Foo' );
    is( $foo->object->number, 2,
        '... got the right number (in the embedded object)' );
}

