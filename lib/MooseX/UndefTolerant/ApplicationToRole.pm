package MooseX::UndefTolerant::ApplicationToRole;
use Moose::Role;

around apply => sub {
    my $orig  = shift;
    my $self  = shift;
    my ($role, $class) = @_;

    Moose::Util::MetaRole::apply_metaroles(
        for             => $class,
        role_metaroles => {
            application_to_class => [
                'MooseX::UndefTolerant::ApplicationToClass',
            ],
            application_to_role => [
                'MooseX::UndefTolerant::ApplicationToRole',
            ],
        }
    );

    $self->$orig( $role, $class );
};

no Moose::Role;

1;
