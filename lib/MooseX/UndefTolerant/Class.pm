package MooseX::UndefTolerant::Class;
use Moose::Role;

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
