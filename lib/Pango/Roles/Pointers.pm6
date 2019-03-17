use v6.c;

use NativeCall;

# Number of times compilation has been forced.
constant forced = 0;

role Pango::Roles::Pointers {

  method p {
    nativecast(Pointer, self);
  }

}
