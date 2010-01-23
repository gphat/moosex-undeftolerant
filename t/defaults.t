#!/usr/bin/perl

use Test::More;

package Foo;

use Moose;
use MooseX::UndefTolerant::Attribute;

has bar => (
   is => 'rw',
   traits => ['MooseX::UndefTolerant::Attribute'],
   default => 'baz'
);

1;

package main;

my $foo = Foo->new( bar => undef );
is ( $foo->bar, 'baz', 'does the default value get set when passing undef in the constructor' );

done_testing;
