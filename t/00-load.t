#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'MooseX::Attribute::UndefTolerant' );
}

diag( "Testing MooseX::Attribute::UndefTolerant $MooseX::Attribute::UndefTolerant::VERSION, Perl $], $^X" );
