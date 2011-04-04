#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Test::Moose;
use Test::Fatal;

plan skip_all => "only relevant for Moose 2.0"
    if Moose->VERSION < 1.9900;

{
    package Foo::Role;
    use Moose::Role;
    use MooseX::UndefTolerant;

    has foo => (
        is        => 'ro',
        isa       => 'Str',
        predicate => 'has_foo',
    );
}

{
    package Foo;
    use Moose;

    with 'Foo::Role';
}

{
    package Bar::Role;
    use Moose::Role;
}

{
    package Bar;
    use Moose;

    with 'Foo::Role', 'Bar::Role';
}

with_immutable {
    my $foo;
    is(exception { $foo = Foo->new(foo => undef) }, undef,
       "can set to undef in constructor");
    ok(!$foo->has_foo, "role attribute isn't set");

    my $bar;
    is(exception { $bar = Bar->new(foo => undef) }, undef,
       "can set to undef in constructor");
    ok(!$bar->has_foo, "role attribute isn't set");
} 'Foo', 'Bar';

done_testing;
