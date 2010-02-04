# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 4;

## new 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( 1 .. 5 );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## new 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( [ 1 .. 5 ] );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## new 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( [ 1 .. 5 ], 10 );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## new 4

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( [ 1 .. 5 ], "foo" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}



__END__

