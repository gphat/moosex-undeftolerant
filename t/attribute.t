use Test::More;

package Foo;
use Moose;

has 'bar' => (
    traits => [ qw(MooseX::UndefTolerant::Attribute)],
    is => 'ro',
    isa => 'Num',
    predicate => 'has_bar'
);

package Foo2;
use Moose;
use MooseX::UndefTolerant;

has 'bar' => (
    is => 'ro',
    isa => 'Num',
    predicate => 'has_bar'
);

package main;

{
    my $foo = Foo->new;
    ok(!$foo->has_bar);
}

{
    my $foo = Foo->new(bar => undef);
    ok(!$foo->has_bar);
}

{
    my $foo = Foo2->new(bar => undef);
    ok(!$foo->has_bar);
}


done_testing;