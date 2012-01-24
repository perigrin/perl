#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';
use Test::Fatal;

use ok 'MooseX::Types::Set::Object';

{
    package Blah;
    use Moose;

    has stuff => (
        isa => "Set::Object",
        is  => "rw",
        coerce => 1,
    );

    has junk => (
        isa => "Set::Object",
        is  => "rw",
    );

    has misc => (
        isa => "Set::Object[Foo]",
        is  => "rw",
        coerce => 1,
    );

    has moo => (
        isa    => 'ArrayRef',
        is     => 'rw',
        coerce => 1,
    );

    package Foo;
    use Moose;

    package Bar;
    use Moose;

    extends qw(Foo);

    package Gorch;
    use Moose;
}

my @objs = (
    "foo",
    Foo->new,
    [ ],
);

my $obj = Blah->new( stuff => \@objs );

isa_ok( $obj->stuff, "Set::Object" );
is( $obj->stuff->size, 3, "three items" );

foreach my $item ( @objs ) {
    ok( $obj->stuff->includes($item), "'$item' is in the set");
}

like( exception { Blah->new( junk => [ ] ) }, qr/type.*Set::Object/i, "fails without coercion");

like( exception { Blah->new( junk => \@objs ) }, qr/type.*Set::Object/i, "fails without coercion");


{
    local $TODO = "coercion for parameterized types seems borked";
    is( exception { Blah->new( misc => [ ] ) }, undef, "doesn't fail with empty array for parameterized set type");
}

is( exception { Blah->new( misc => Set::Object->new ) }, undef, "doesn't fail with empty set for parameterized set type");

like( exception { Blah->new( misc => \@objs ) }, qr/Foo/, "fails on parameterized set type");

like( exception { Blah->new( misc => Set::Object->new(@objs) ) }, qr/Foo/, "fails on parameterized set type");

{
    local $TODO = "coercion for parameterized types seems borked";
    is( exception { Blah->new( misc => [ Foo->new, Bar->new ] ) }, undef, "no error on coercion from array filled with the right type");
}

is( exception { Blah->new( misc => Set::Object->new(Foo->new, Bar->new) ) }, undef, "no error with set filled with the right type");
like( exception { Blah->new( misc => Set::Object->new(Foo->new, Gorch->new, Bar->new) ) }, qr/Foo/, "error with set that has a naughty object");
