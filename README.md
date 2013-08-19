# NAME

Array::RingBuffer - RingBuffer Array Object

# SYNOPSIS

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

# DESCRIPTION

Array object with limited slots like ring buffer.

# METHODS

- __new__

        my $array = Array::RingBuffer->new( \@default );
        my $array = Array::RingBuffer->new( \@default, 10 );

        The first value is default list as array reference, the asecond is limit length.

        my $array = Array::RingBuffer->new( @default );

        If a naked array is set, the limit number is assumed by the length of it.
- __clear__

    blah.

- __get__

    blah.

- __limit__

    blah.

- __message__

    blah.

- __pop__

    blah.

- __push__

    blah.

- __scalar__

    blah.

- __shift__

    blah.

- __unshift__

    blah.

# VERBOSE OPTION

Set $Verbose to true if you need to be warned with invalid operations.

    local $Array::RingBuffer::Verbose = 1;

# TODO

To enable objects to use an ordinary arrayref using overload.

# DEPENDENCY

None.

# SEE ALSO

List::Cycle, List::Rotation, Array::Iterator

# REPOSITORY

https://github.com/ryochin/p5-array-ringbuffer

# AUTHOR

Ryo Okamoto <ryo@aquahill.net>

# COPYRIGHT & LICENSE

Copyright (c) Ryo Okamoto, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
