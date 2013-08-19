#!/usr/bin/perl --

use strict;
use warnings;
use Path::Class qw(file dir);

use utf8;

use lib qw(lib);

use  Array::RingBuffer;

my $array =  Array::RingBuffer->new;
#$array->limit( 10 );

use DDP;
p($array);


__END__
