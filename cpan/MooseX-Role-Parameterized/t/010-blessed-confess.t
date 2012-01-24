#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

do {
    package MyRole;
    use MooseX::Role::Parameterized;
    ::is(\&confess, \&Carp::confess, 'confess');
    ::is(\&blessed, \&Scalar::Util::blessed, 'blessed');
};

done_testing;

