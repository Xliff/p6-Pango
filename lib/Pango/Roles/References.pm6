use v6.c;

use NativeCall;
use Method::Also;

use Pango::Compat::Types;

role Pango::Roles::References {
  has Pointer $!ref;

  # We use these for inc/dec ops
  method upref
    is also<ref>
  {
    g_object_ref($!ref);
    self;
  }
  method downref
    is also<unref>
  { g_object_unref($!ref); }
}

sub g_object_ref (Pointer $p)
  is native(gobject)
  is export
{ * }

sub g_object_unref (Pointer $p)
  is native(gobject)
  is export
{ * }
