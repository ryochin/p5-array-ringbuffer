# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 14;

## limit 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	is( $array->limit, scalar @default, "default limit num" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## limit 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );
	$array->limit( 3 );

	is( $array->limit, 3, "limit num" );

	# compare
	is_deeply( [ qw(1 2 3) ], [ $array->get ], "array comparison" );
}

## limit 3

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );
	$array->limit( 10 );

	is( $array->limit, 10, "limit num" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## limit 4

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );
	$array->limit( 0 );    # wrong

	is( $array->limit, scalar @default, "limit num" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## limit 5

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );
	$array->limit("foo");    # wrong

	is( $array->limit, scalar @default, "limit num" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## limit 6

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( \@default, 10 );

	is( $array->limit, 10, "limit num" );

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}

## limit 7

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( \@default, 3 );

	is( $array->limit, 3, "limit num" );

	# compare
	is_deeply( [ qw(1 2 3) ], [ $array->get ], "array comparison" );
}

__END__

