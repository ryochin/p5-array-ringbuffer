# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 21;

## get 1

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	# get
	my @result = $array->get;

	# compare
	is_deeply( \@default, \@result, "array comparison" );
}

## get 2

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	# get
	my @result = $array->get;
	ok( scalar @result, "get as array" );

	# try to alter and re-get
	$result[0] = 42;
	@result = $array->get;

	# compare
	is_deeply( \@default, \@result, "array comparison" );
}

## get 3

{
	# init
	my @default = 1 .. 5;
	my $array = Array::RingBuffer->new( @default );

	# get
	my $result = $array->get;
	ok( ref $result eq 'ARRAY', "get as arrayref" );

	# try to alter and re-get
	$result->[0] = 42;
	$result = $array->get;

	# compare
	is_deeply( \@default, $result, "array comparison" );
}

## get 4

{
	# init
	my @default = 'a' .. 'e';
	my $array = Array::RingBuffer->new( @default );

	# get
	my $t = {
		0 => 'a',
		1 => 'b',
		2 => 'c',
		3 => 'd',
		4 => 'e',
		-00001 => 'e',
		+00001 => 'b',
	};
	while( my ($key, $val) = each %{ $t } ){
		is( $array->get( $key ), $val, "get a value" );
	}
}

## get 5

{
	# init
	my @default = 'a' .. 'e';
	my $array = Array::RingBuffer->new( @default );

	# get
	my @t = (
		-100,
		+100,
		'--00001' => 'e',
		'++00001' => 'b',
		'--',
		'++',
		'foo',
	);
	for my $key( @t ){
		is( $array->get( $key ), undef, "invalid key" );
	}
}

## get 6

{
	# init
	my @default;
	$default[1000] = 'a';
	my $array = Array::RingBuffer->new( @default );

	# get
	my $t = {
		1000 => 'a',
		1_000 => 'a',
		+1_000 => 'a',
	};
	while( my ($key, $val) = each %{ $t } ){
		is( $array->get( $key ), $val, "get a value" );
	}
}

__END__

