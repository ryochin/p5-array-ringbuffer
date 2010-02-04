# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 3;

## unshift 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->unshift( 'a' .. 'z' );

	# compare
	is_deeply( [ qw(a b c d e) ], [ $array->get ], "array comparison" );
}

## unshift 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->unshift( 'a' .. 'c' );

	# compare
	is_deeply( [ qw(a b c 1 2) ], [ $array->get ], "array comparison" );
}

## unshift 3

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->unshift();

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}


__END__

