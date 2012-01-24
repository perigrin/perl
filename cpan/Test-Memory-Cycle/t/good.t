#!perl -T

use strict;

use Test::Builder::Tester tests => 2;
use Test::More;
use CGI;

BEGIN {
    use_ok( 'Test::Memory::Cycle' );
}

GOOD: {
    my $cgi = new CGI;

    memory_cycle_ok( $cgi, "CGI doesn't leak" );
}
