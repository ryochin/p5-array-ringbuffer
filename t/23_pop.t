# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 2;

## pop 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->pop for 1..2;

	# compare
	is_deeply( [ qw(1 2 3) ], [ $array->get ], "array comparison" );
}

## pop 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->pop for 1..10;

	# compare
	is_deeply( [ qw() ], [ $array->get ], "array comparison" );
}

__END__

