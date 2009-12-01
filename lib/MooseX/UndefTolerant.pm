package MooseX::UndefTolerant;

use Moose qw();
use Moose::Exporter;

use MooseX::UndefTolerant::Attribute;

our $VERSION = '0.01';

Moose::Exporter->setup_import_methods(
    attribute_metaclass_roles => [ 'MooseX::UndefTolerant::Attribute' ]
);

1;

__END__

=head1 NAME

MooseX::Attribute::UndefTolerant - The great new MooseX::Attribute::UndefTolerant!

=head1 SYNOPSIS

    use MooseX::Attribute::UndefTolerant;


=head1 AUTHOR

Cory G Watson, C<< <gphat at cpan.org> >>

=head1 ACKNOWLEDGEMENTS

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
