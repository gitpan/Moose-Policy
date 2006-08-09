#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 11;

BEGIN {
    use_ok('Moose::Policy');
}

{
    package Foo;

    use Moose::Policy 'Moose::Policy::JavaAccessors';
    use Moose;

    has 'bar' => (is => 'rw', default => 'Foo::bar');
    has 'baz' => (is => 'ro', default => 'Foo::baz');
}

isa_ok(Foo->meta, 'Moose::Meta::Class');
is(Foo->meta->attribute_metaclass, 'Moose::Policy::JavaAccessors::Attribute', '... got our custom attr metaclass');

isa_ok(Foo->meta->get_attribute('bar'), 'Moose::Policy::JavaAccessors::Attribute');

my $foo = Foo->new;
isa_ok($foo, 'Foo');

can_ok($foo, 'getBar');
can_ok($foo, 'setBar');

can_ok($foo, 'getBaz');
ok(! $foo->can('setBaz'), 'without setter');

is($foo->getBar, 'Foo::bar', '... got the right default value');
is($foo->getBaz, 'Foo::baz', '... got the right default value');

