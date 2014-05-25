package Specio::TypeChecks;

use strict;
use warnings;

use Exporter qw( import );
use Module::Runtime qw( is_module_name );
use Scalar::Util qw( blessed );

our @EXPORT_OK = qw(
    does_role
    is_ArrayRef
    is_ClassName
    is_CodeRef
    is_HashRef
    is_Int
    is_Str
    isa_class
);

sub is_ArrayRef {
    return ref $_[0] eq 'ARRAY';
}

sub is_CodeRef {
    return ref $_[0] eq 'CODE';
}

sub is_HashRef {
    return ref $_[0] eq 'HASH';
}

sub is_Str {
    defined( $_[0] ) && !ref( $_[0] ) && ref( \$_[0] ) eq 'SCALAR'
        || ref( \( my $val = $_[0] ) eq 'SCALAR' );
}

sub is_Int {
    ( defined( $_[0] ) && !ref( $_[0] ) && ref( \$_[0] ) eq 'SCALAR'
            || ref( \( my $val = $_[0] ) eq 'SCALAR' ) )
        && $_[0] =~ /^[0-9]+$/;
}

sub is_ClassName {
    is_module_name( $_[0] );
}

sub isa_class {
    blessed( $_[0] ) && $_[0]->isa( $_[1] );
}

sub does_role {
    blessed( $_[0] ) && $_[0]->can('does') && $_[0]->does( $_[1] );
}

1;
