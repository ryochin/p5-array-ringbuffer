# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 3;

## push 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->push( 'a' .. 'z' );

	# compare
	is_deeply( [ qw(v w x y z) ], [ $array->get ], "array comparison" );
}

## push 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->push( 'a' .. 'c' );

	# compare
	is_deeply( [ qw(4 5 a b c) ], [ $array->get ], "array comparison" );
}

## push 3

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	$array->push();

	# compare
	is_deeply( \@default, [ $array->get ], "array comparison" );
}


__END__

