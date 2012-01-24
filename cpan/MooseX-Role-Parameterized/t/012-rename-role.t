#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

do {
    package MyRole;
    use MooseX::Role::Parameterized (
        role => { -as => 'parameterized_role' },
        'method',
    );

    parameterized_role {
        method ok => sub {};
    };
};

my $role = MyRole->meta->generate_role;
ok($role->has_method('ok'), "renaming the role block export works");

done_testing;

