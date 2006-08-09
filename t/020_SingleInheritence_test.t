#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;
use Test::Exception;

BEGIN {
    use_ok('Moose::Policy');
}

{
    package Foo;
    use Moose::Policy 'Moose::Policy::SingleInheritence';
    use Moose;
    
    package Bar;
    use Moose::Policy 'Moose::Policy::SingleInheritence';
    use Moose;    

    extends 'Foo';
    
    package Baz;
    use Moose::Policy 'Moose::Policy::SingleInheritence';    
    use Moose;    
    
    ::dies_ok {
        extends 'Foo', 'Bar';
    } '... violating the policy';
}

