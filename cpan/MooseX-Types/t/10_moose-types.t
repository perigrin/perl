#!/usr/bin/env perl
use warnings;
use strict;

use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";
use MooseX::Types::Moose ':all', 'Bool';

my @types = MooseX::Types::Moose->type_names;

for my $t (@types) {
    ok my $code = __PACKAGE__->can($t), "$t() was exported";
    if ($code) {
        is $code->(), $t, "$t() returns '$t'";
    }
    else {
        diag "Skipping $t() call test";
    }
    ok __PACKAGE__->can("is_$t"), "is_$t() was exported";
}

done_testing;
