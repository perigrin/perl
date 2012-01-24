# test script for: https://rt.cpan.org/Ticket/Display.html?id=46086
use strict;
use warnings;

use Test::More qw(no_plan);
use Test::Requires {
    'Test::NoWarnings' => 0.01
};

BEGIN {
    package OnlyUsedOnce;
    use strict;
    use warnings;
    use MooseX::Singleton;
}

BEGIN { OnlyUsedOnce->initialize; }

my $s = OnlyUsedOnce->instance;
