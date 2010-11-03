use Test::More tests => 12;
use Test::Fatal;

# TODO: this test should be renamed constructor.t, since all it tests is
# UT behaviour during construction.

{
    package Foo;
    use Moose;

    has 'attr1' => (
        traits => [ qw(MooseX::UndefTolerant::Attribute)],
        is => 'ro',
        isa => 'Num',
        predicate => 'has_attr1'
    );

    has 'attr2' => (
        is => 'ro',
        isa => 'Num',
        predicate => 'has_attr2'
    );
}

{
    package Bar;
    use Moose;
    use MooseX::UndefTolerant;

    has 'attr1' => (
        is => 'ro',
        isa => 'Num',
        predicate => 'has_attr1'
    );
    has 'attr2' => (
        is => 'ro',
        isa => 'Num',
        predicate => 'has_attr2'
    );
}

package main;

note 'Testing class with a single UndefTolerant attribute';
{
    my $obj = Foo->new;
    ok(!$obj->has_attr1, 'attr1 has no value before it is assigned');
    ok(!$obj->has_attr2, 'attr2 has no value before it is assigned');
}

{
    my $obj = Foo->new(attr1 => undef);
    ok(!$obj->has_attr1, 'UT attr1 has no value when assigned undef in constructor');
    ok (exception { $obj = Foo->new(attr2 => undef) },
        'But assigning undef to attr2 generates a type constraint error');
}

{
    my $obj = Foo->new(attr1 => 1234);
    is($obj->attr1, 1234, 'assigning a defined value during construction works as normal');
    ok($obj->has_attr1, '...and the predicate returns true as normal');
}


note '';
note 'Testing class with the entire class being UndefTolerant';
{
    my $obj = Bar->new;
    ok(!$obj->has_attr1, 'attr1 has no value before it is assigned');
}

{
    my $obj = Bar->new(attr1 => undef);
    ok(!$obj->has_attr1, 'attr1 has no value when assigned undef in constructor');
    ok (!exception { $obj = Bar->new(attr2 => undef) },
        'assigning undef to attr2 does not produce an error');
    ok(!$obj->has_attr2, 'attr2 has no value when assigned undef in constructor');
}

{
    my $obj = Bar->new(attr1 => 1234);
    is($obj->attr1, 1234, 'assigning a defined value during construction works as normal');
    ok($obj->has_attr1, '...and the predicate returns true as normal');
}


