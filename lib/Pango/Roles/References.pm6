use v6.c;

use NativeCall;

use Pango::Compat::Types;

role Pango::Roles::References {
  has Pointer $!ref;

  # We use these for inc/dec ops
  method upref   {   g_object_ref($!ref); self; }
  method downref { g_object_unref($!ref); self; }
}

sub g_object_ref(Pointer $p)
  is native(gobject)
  is export
  { * }
sub g_object_unref(Pointer $p)
  is native(gobject)
  is export
  { * }
