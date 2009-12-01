package MooseX::UndefTolerant::Attribute;
use Moose::Role;

around('initialize_instance_slot', sub{
    my $orig = shift;
    my $self = shift;

    # If the parameter passed in was undef, quietly do nothing but return
    return unless defined($_->[2]);

    # If it was defined, call the real init slot method
    $self->$orig(@_)
});

1;