# 

use strict;
use lib qw(blib/lib);
use Array::RingBuffer;

use Test::More tests => 10;

my $array = Array::RingBuffer->new;

isa_ok( $array, "Array::RingBuffer" );

my @method = qw(
	new
	get
	limit
	clear
	scalar
	pop
	push
	shift
	unshift
);

for(@method){
	can_ok( $array, $_ );
}

__END__

