#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'MooseX::UndefTolerant' );
}

diag( "Testing MooseX::UndefTolerant $MooseX::UndefTolerant::VERSION, Perl $], $^X" );
