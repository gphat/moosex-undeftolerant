use inc::Module::Install;

name     'MooseX-Attribute-UndefTolerant';
all_from 'lib/MooseX/UndefTolerant.pm';
author   q{Cory G Watson <gphat@cpan.org>};
license  'perl';

build_requires 'Test::More';

requires 'Moose';

WriteAll;
