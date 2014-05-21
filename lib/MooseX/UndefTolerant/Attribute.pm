package MooseX::UndefTolerant::Attribute;
use Moose::Role;

around('initialize_instance_slot', sub {
    my $orig = shift;
    my $self = shift;
    my ($meta_instance, $instance, $params) = @_;

    my $key_name = $self->init_arg;

    # If our parameter passed in was undef, remove it from the parameter list...
    # but leave the value unscathed if the attribute's type constraint can
    # handle undef (or doesn't have one, which implicitly means it can)
    if (not defined $key_name or not defined($params->{$key_name}))
    {
        my $type_constraint = $self->type_constraint;
        if ($type_constraint and not $type_constraint->check(undef))
        {
            delete $params->{$key_name};
        }
    }

    # Invoke the real init, as the above line cleared the undef
    $self->$orig(@_)
});

1;

# ABSTRACT: Make your attribute(s) tolerant to undef intitialization

__END__

=head1 SYNOPSIS

  package My:Class;
  use Moose;

  use MooseX::UndefTolerant::Attribute;

  has 'bar' => (
      traits => [ qw(MooseX::UndefTolerant::Attribute)],
      is => 'ro',
      isa => 'Num',
      predicate => 'has_bar'
  );

  # Meanwhile, under the city...

  # Doesn't explode
  my $class = My::Class->new(bar => undef);
  $class->has_bar # False!

=head1 DESCRIPTION

Applying this trait to your attribute makes it's initialization tolerant of
of undef.  If you specify the value of undef to any of the attributes they
will not be initialized (or will be set to the default, if applicable).
Effectively behaving as if you had not provided a value at all.

=cut
