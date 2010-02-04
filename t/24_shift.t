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

	$array->shift for 1..2;

	# compare
	is_deeply( [ qw(3 4 5) ], [ $array->get ], "array comparison" );
}

## pop 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->shift for 1..10;

	# compare
	is_deeply( [ qw() ], [ $array->get ], "array comparison" );
}

__END__

