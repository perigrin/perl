################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/call instead.
#
################################################################################

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    @INC = ('../lib', '../ext/Devel/PPPort/t') if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ] ) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }
  else {
    unshift @INC, 't';
  }

  eval "use Test";
  if ($@) {
    require 'testutil.pl';
    print "1..44\n";
  }
  else {
    plan(tests => 44);
  }
}

use Devel::PPPort;
use strict;
$^W = 1;

sub eq_array
{
  my($a, $b) = @_;
  join(':', @$a) eq join(':', @$b);
}

sub f
{
  shift;
  unshift @_, 'b';
  pop @_;
  @_, defined wantarray ? wantarray ? 'x' : 'y' : 'z';
}

my $obj = bless [], 'Foo';

sub Foo::meth
{
  return 'bad_self' unless @_ && ref $_[0] && ref($_[0]) eq 'Foo';
  shift;
  shift;
  unshift @_, 'b';
  pop @_;
  @_, defined wantarray ? wantarray ? 'x' : 'y' : 'z';
}

my $test;

for $test (
    # flags                      args           expected         description
    [ &Devel::PPPort::G_SCALAR,  [ ],           [ qw(y 1) ],     '0 args, G_SCALAR'  ],
    [ &Devel::PPPort::G_SCALAR,  [ qw(a p q) ], [ qw(y 1) ],     '3 args, G_SCALAR'  ],
    [ &Devel::PPPort::G_ARRAY,   [ ],           [ qw(x 1) ],     '0 args, G_ARRAY'   ],
    [ &Devel::PPPort::G_ARRAY,   [ qw(a p q) ], [ qw(b p x 3) ], '3 args, G_ARRAY'   ],
    [ &Devel::PPPort::G_DISCARD, [ ],           [ qw(0) ],       '0 args, G_DISCARD' ],
    [ &Devel::PPPort::G_DISCARD, [ qw(a p q) ], [ qw(0) ],       '3 args, G_DISCARD' ],
)
{
    my ($flags, $args, $expected, $description) = @$test;
    print "# --- $description ---\n";
    ok(eq_array( [ &Devel::PPPort::call_sv(\&f, $flags, @$args) ], $expected));
    ok(eq_array( [ &Devel::PPPort::call_sv(*f,  $flags, @$args) ], $expected));
    ok(eq_array( [ &Devel::PPPort::call_sv('f', $flags, @$args) ], $expected));
    ok(eq_array( [ &Devel::PPPort::call_pv('f', $flags, @$args) ], $expected));
    ok(eq_array( [ &Devel::PPPort::call_argv('f', $flags, @$args) ], $expected));
    ok(eq_array( [ &Devel::PPPort::eval_sv("f(qw(@$args))", $flags) ], $expected));
    ok(eq_array( [ &Devel::PPPort::call_method('meth', $flags, $obj, @$args) ], $expected));
};

ok(&Devel::PPPort::eval_pv('f()', 0), 'y');
ok(&Devel::PPPort::eval_pv('f(qw(a b c))', 0), 'y');

