package MooseX::UndefTolerant;

use Moose qw();
use Moose::Exporter;

use MooseX::UndefTolerant::Attribute;

our $VERSION = '0.04';

Moose::Exporter->setup_import_methods(
    class_metaroles => { attribute => [ 'MooseX::UndefTolerant::Attribute' ] }
);

1;

__END__

=head1 NAME

MooseX::UndefTolerant - Make your attribute(s) tolerant to undef intitialization

=head1 SYNOPSIS

  package My::Class;

  use Moose;
  use MooseX::UndefTolerant;

  has 'name' => (
    is => 'ro',
    isa => 'Str',
    predicate => 'has_name'
  );

  # Meanwhile, under the city...

  # Doesn't explode
  my $class = My::Class->new(name => undef);
  $class->has_name # False!

Or, if you only want one attribute to have this behaviour:

  package My:Class;
  use Moose;

  use MooseX::UndefTolerant::Attribute;

  has 'bar' => (
      traits => [ qw(MooseX::UndefTolerant::Attribute)],
      is => 'ro',
      isa => 'Num',
      predicate => 'has_bar'
  );

=head1 DESCRIPTION

Loading this module in your L<Moose> class makes initialization of your
attributes tolerant of undef.  If you specify the value of undef to any of
the attributes they will not be initialized.  Effectively behaving as if you
had not provided a value at all.

=head1 MOTIVATION

I often found myself in this quandry:

  package My:Class;
  use Moose;

  has 'foo' => (
    is => 'ro',
    isa => 'Str',
  );

  # ... then

  my $foo = ... # get the param from something

  my $class = My:Class->new(foo => $foo, bar => 123);

What if foo is undefined?  I didn't want to change my attribute to be
Maybe[Str] and I still want my predicate (C<has_foo>) to work.  The only
real solution was:

  if(defined($foo)) {
    $class = My:CLass->new(foo => $foo, bar => 123);
  } else {
    $class = My:CLass->new(bar => 123);
  }

Or some type of codemulch using ternarys.  This module allows you to make
your attributes more tolerant of undef so that you can keep the first
example: have your cake and eat it too!

=head1 PER ATTRIBUTE

=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

Many thanks to the crew in #moose who talked me through this module:

Hans Dieter Pearcey (confound)

Jesse Luehrs (doy)

Tomas Doran (t0m)

Dylan Hardison (dylan)

Jay Shirley (jshirley)

Mike Eldridge (diz)

=head1 COPYRIGHT & LICENSE

Copyright 2009 Cory G Watson.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
