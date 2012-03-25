package MooseX::UndefTolerant::Class;

# applied to metaclass, for Moose >= 1.9900

use strict;
use warnings;

use Moose::Role;

# TODO: this code should be in the attribute trait, in the inlined version of
# initialize_instance_slot, but this does not yet exist!

around _inline_init_attr_from_constructor => sub {
    my $orig = shift;
    my $self = shift;
    my ($attr, $idx) = @_;

    my @source = $self->$orig(@_);

    my $init_arg = $attr->init_arg;

    return
        "if ( exists \$params->{$init_arg} && defined \$params->{$init_arg} ) {",
            @source,
        '} else {',
            "delete \$params->{$init_arg};",
        '}';
};

no Moose::Role;
1;
