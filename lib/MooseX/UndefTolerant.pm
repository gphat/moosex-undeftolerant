package MooseX::UndefTolerant;

use strict;
use warnings;

use Moose qw();
use Moose::Exporter;

use MooseX::UndefTolerant::Attribute;
use MooseX::UndefTolerant::Class;
use MooseX::UndefTolerant::Constructor;


my %metaroles = (
    class_metaroles => {
        attribute => [ 'MooseX::UndefTolerant::Attribute' ],
    }
);
if ( $Moose::VERSION < 1.9900 ) {
    $metaroles{class_metaroles}{constructor} = [
        'MooseX::UndefTolerant::Constructor',
    ];
}
else {
    $metaroles{class_metaroles}{class} = [
        'MooseX::UndefTolerant::Class',
    ];
    $metaroles{role_metaroles} = {
        applied_attribute => [
            'MooseX::UndefTolerant::Attribute',
        ],
        role => [
            'MooseX::UndefTolerant::Role',
        ],
        application_to_class => [
            'MooseX::UndefTolerant::ApplicationToClass',
        ],
        application_to_role => [
            'MooseX::UndefTolerant::ApplicationToRole',
        ],
    };
}


Moose::Exporter->setup_import_methods(%metaroles);

1;

# ABSTRACT: Make your attribute(s) tolerant to undef initialization

__END__

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
the attributes they will not be initialized, effectively behaving as if you
had not provided a value at all.

You can also apply the 'UndefTolerant' trait to individual attributes. See
L<MooseX::UndefTolerant::Attribute> for details.

There will be no change in behaviour to any attribute with a type constraint
that accepts undef values (for example C<Maybe> types), as it is presumed that
since the type is already "undef tolerant", there is no need to avoid
initializing the attribute value with C<undef>.

As of Moose 1.9900, this module can also be used in a role, in which case all
of that role's attributes will be undef-tolerant.

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
    $class = My:Class->new(foo => $foo, bar => 123);
  } else {
    $class = My:Class->new(bar => 123);
  }

Or some type of codemulch using ternary conditionals.  This module allows you
to make your attributes more tolerant of undef so that you can keep the first
example: have your cake and eat it too!

=head1 PER ATTRIBUTE

See L<MooseX::UndefTolerant::Attribute>.

=head1 CAVEATS

This extension does not currently work in immutable classes when applying the
trait to some (but not all) attributes in the class. This is because the
inlined constructor initialization code currently lives in
L<Moose::Meta::Class>, not L<Moose::Meta::Attribute>. The good news is that
this is expected to be changing shortly.

=head1 ACKNOWLEDGEMENTS

Many thanks to the crew in #moose who talked me through this module:

Hans Dieter Pearcey (confound)

Jesse Luehrs (doy)

Tomas Doran (t0m)

Dylan Hardison (dylan)

Jay Shirley (jshirley)

Mike Eldridge (diz)

=cut
