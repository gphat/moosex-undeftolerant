package MooseX::UndefTolerant::Constructor;
use Moose::Role;

around('_generate_slot_initializer', sub {
        my $orig = shift;
        my $self = shift;
        my $attr = $self->_attributes->[$_[0]]->init_arg;

        # insert a line of code at the start of the initializer,
        # clearing the param if it's undefined.

        if (defined $attr) {
                my $tolerant_code = 
                     qq# delete \$params->{'$attr'} unless # . 
                     qq# exists \$params->{'$attr'} && defined \$params->{'$attr'};\n#;

                return $tolerant_code . $self->$orig(@_);
        }
        else {
                return $self->$orig(@_);
        }
});

no Moose::Role;

1;
