use inc::Module::Install;

name     'MooseX-UndefTolerant';
all_from 'lib/MooseX/UndefTolerant.pm';
author   q{Cory G Watson <gphat@cpan.org>};
license  'perl';

build_requires 'Test::Fatal';
build_requires 'Test::More' => '0.002';

requires 'Moose' => '0.89';
requires 'Moose::Exporter';

WriteAll;
