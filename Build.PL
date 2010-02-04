#

use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Array::RingBuffer',
    license             => 'perl',
    dist_author         => 'Ryo Okamoto <ryo at aquahill dot net>',
    dist_version_from   => 'lib/Array/RingBuffer.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => { },
    add_to_cleanup      => [ 'Array-RingBuffer-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();

