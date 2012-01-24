#!/usr/bin/perl

# Test the various PPI::Statement packages

use strict;
BEGIN {
	no warnings 'once';
	$| = 1;
	$PPI::XS_DISABLE = 1;
	$PPI::Lexer::X_TOKENIZER ||= $ENV{X_TOKENIZER};
}

# Execute the tests
use Test::More tests => 12;
use Test::NoWarnings;
use File::Spec::Functions ':ALL';
use Scalar::Util 'refaddr';
use PPI::Lexer ();





#####################################################################
# Tests for PPI::Statement::Package

SCOPE: {
	# Create a document with various example package statements
	my $Document = PPI::Lexer->lex_source( <<'END_PERL' );
package Foo;
SCOPE: {
	package # comment
	Bar::Baz;
	1;
}
1;
END_PERL
	isa_ok( $Document, 'PPI::Document' );

	# Check that both of the package statements are detected
	my $packages = $Document->find('Statement::Package');
	is( scalar(@$packages), 2, 'Found 2 package statements' );
	is( $packages->[0]->namespace, 'Foo', 'Package 1 returns correct namespace' );
	is( $packages->[1]->namespace, 'Bar::Baz', 'Package 2 returns correct namespace' );
	is( $packages->[0]->file_scoped, 1,  '->file_scoped returns true for package 1' );
	is( $packages->[1]->file_scoped, '', '->file_scoped returns false for package 2' );
}





#####################################################################
# Basic subroutine test

SCOPE: {
	my $doc = PPI::Document->new( \"sub foo { 1 }" );
	isa_ok( $doc, 'PPI::Document' );
	isa_ok( $doc->child(0), 'PPI::Statement::Sub' );
}





#####################################################################
# Regression test, make sure utf8 is a pragma

SCOPE: {
	my $doc = PPI::Document->new( \"use utf8;" );
	isa_ok( $doc, 'PPI::Document' );
	isa_ok( $doc->child(0), 'PPI::Statement::Include' );
	is( $doc->child(0)->pragma, 'utf8', 'use utf8 is a pragma' );
}
