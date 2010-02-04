#

package Array::RingBuffer;

use strict;
use 5.006;    # for attributes
use constant ARRAY => 0;
use constant LIMIT => 1;

our $VERSION = '0.001';
our $Verbose = 0;

sub new {
	my $param = shift;
	my $class = ref $param || $param;

	my ($default, $limit);
	if( defined $_[0] and ref $_[0] eq 'ARRAY' ){
		($default, $limit) = @_;
	}
	else{
		$default = [ @_ ];
	}

	my $self = bless [], $class;
	$self->[ARRAY] = $default;

	if( defined $limit and $limit =~ /^\d+$/o and $limit > 0 ){
		$self->limit( int $limit );
	}
	else{
		$self->limit( $self->scalar );
	}

	return $self;
}

sub get {
	my $self = shift;

	if( defined( my $n = shift ) ){
		if( $n =~ /^[\-\+]?\d+$/o ){
			return $self->[ARRAY]->[ int $n ];
		}
		else{
			$self->message("get: number must be an integer.");
			return;
		}
	}

	return wantarray ? @{ $self->[ARRAY] } : [ @{ $self->[ARRAY] } ];
}

sub limit {
	my $self = shift;

	if( defined( my $limit = shift ) ){
		if( $limit =~ /^\d+$/o and $limit > 0 ){
			$self->[LIMIT] = int $limit;
			$self->_truncate_extra_unshift;
		}
		else{
			$self->message("limit: limit number must be an unsigned integer.");
			return;
		}
	}

	return $self->[LIMIT];
}

sub _truncate_extra_push {
	my $self = shift;

	if( ( my $n = $self->scalar - $self->limit ) > 0 ){
		$self->message("push: limit number is smaller than the slot ones. extra $n slot(s) have been removed.");
		splice @{ $self->[ARRAY] }, 0, $n;
	}

	return $self;
}

sub _truncate_extra_unshift {
	my $self = shift;

	if( ( my $n = $self->scalar - $self->limit ) > 0 ){
		$self->message("unshift: limit number is smaller than the slot ones. extra $n slot(s) have been removed.");
		@{ $self->[ARRAY] } = splice @{ $self->[ARRAY] }, 0, $self->limit;
	}

	return $self;
}

sub push {
	my $self = shift;

	push @{ $self->[ARRAY] }, @_;
	$self->_truncate_extra_push;

	return $self->scalar;
}

sub unshift {
	my $self = shift;

	unshift @{ $self->[ARRAY] }, @_;
	$self->_truncate_extra_unshift;

	return $self->scalar;
}

sub pop {
	my $self = shift;

	return pop @{ $self->[ARRAY] };
}

sub shift : method {
	my $self = shift;

	return shift @{ $self->[ARRAY] };
}

sub scalar {
	my $self = shift;

	return scalar @{ $self->[ARRAY] };
}

sub clear {
	my $self = shift;

	$self->[ARRAY] = [];

	return;
}

sub message {
	my $self = shift;
	my $message = shift;

	return if ( not defined $Verbose or not $Verbose );

	require Carp;
	Carp::carp $message;
}

1;

__END__

=head1 NAME

Array::RingBuffer - RingBuffer Array Object

=head1 SYNOPSIS

 use Array::RingBuffer;

 my @default = 1 .. 5;
 my $array = Array::RingBuffer->new( \@default, 10 );
 my @result = $array->get;
 # 1 2 3 4 5

 # note that the array length never exceeds 10.
 $array->push( 'a' .. 'z' );
 # q r s t u v w x y z

 $array->push( 'A' .. 'C' );
 # t u v w x y z A B C

 $array->unshift( 1 .. 5 );
 # 1 2 3 4 5 t u v w x y

 $array->unshift( 'a' .. 'g' );
 # a b c d e f g 1 2 3

 # same as core functions
 my $value = $array->pop;
 my $value = $array->shift;
 # b c d e f g 1 2

 # limit
 $array->limit( 15 );    # set
 my $n = $array->limit;    # get

 # get
 my $val = $array->get( 5 );    # like: $a->[5]

 # get all
 my @result = $array->get;
 my $result = $array->get;    # array ref

 # scalar
 my $len = $array->scalar;    # like: scalar @{ $a }

 # clear
 $array->clear;

=head1 DESCRIPTION

In other words, an array you create won't exceed. ...



you can tie an array to having limited number of "slot"s.

so the length of the array never exceeds the specified limit.


# limit

in this case,
if it has already over 3 slots, 
automatically truncates trailing fourth value and later.


=head1 METHODS

=over 4

=item B<new>

 my $array = Array::RingBuffer->new( \@default );
 my $array = Array::RingBuffer->new( \@default, 10 );

 First value is default list as array reference, second value is limit length.



 my $array = Array::RingBuffer->new( @default );

 If an naked array is set, the limit number is assumed by the length of it.



=item B<clear>

blah.

=item B<get>

blah.

=item B<limit>

blah.

=item B<message>

blah.

=item B<pop>

blah.

=item B<push>

blah.

=item B<scalar>

blah.

=item B<shift>

blah.

=item B<unshift>

blah.

=back

=head1 VERBOSE OPTION

Set $Verbose to true if you need to be warned with invalid operations.

 local $Array::RingBuffer::Verbose = 1;

=head1 TODO

To enable objects to use an ordinary arrayref using overload.

=head1 DEPENDENCY

None.

=head1 SEE ALSO

List::Cycle, List::Rotation, Array::Iterator

=head1 LICENSE

This module is distributed under the same terms as perl itself.

=head1 AUTHOR

Ryo Okamoto <ryo at aquahill dot net>

=cut
