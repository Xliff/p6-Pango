use v6.c;

use NativeCall;

role Pango::Roles::Pointers {

  method p {
    nativecast(Pointer, self);
  }

}
