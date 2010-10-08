package MooseX::UndefTolerant::Constructor;
use Moose::Role;

around('_generate_slot_initializer', sub {
        my $orig = shift;
        my $self = shift;
        my $attr = $self->_attributes->[$_[0]]->init_arg;

        my $tolerant_code = 
             qq# delete \$params->{'$attr'} unless # . 
             qq# exists \$params->{'$attr'} && defined \$params->{'$attr'};\n#;

        return $tolerant_code . $self->$orig(@_);
});

no Moose::Role;

1;
