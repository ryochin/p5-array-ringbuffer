# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 3;

## scalar 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	is( $array->scalar, 5, "scalar num" );
}

## scalar 2

{
	# init
	my $array = Array::RingBuffer->new( [] );

	is( $array->scalar, 0, "scalar num" );
}

## scalar 3

{
	# init
	my $array = Array::RingBuffer->new( [], 100 );

	is( $array->scalar, 0, "scalar num" );
}

__END__

