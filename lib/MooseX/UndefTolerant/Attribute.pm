package MooseX::UndefTolerant::Attribute;
use Moose::Role;

around('initialize_instance_slot', sub {
    my $orig = shift;
    my $self = shift;

    my $ia = $self->init_arg;

    # $_[2] is the hashref of options passed to the constructor. If our
    # parameter passed in was undef, quietly do nothing but return.
    return unless exists($_[2]->{$ia}) && defined($_[2]->{$ia});

    # If it was defined, call the real init slot method
    $self->$orig(@_)
});

1;

=head1 NAME

MooseX::UndefTolerant::Attribute - Make your attribute tolerant to undef intitialization

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
will not be initialized.  Effectively behaving as if you had not provided a
value at all.

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2009 Cory G Watson.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
