use v6.c;

use NativeCall;

# Number of times compilation has been forced.
my constant forced = 17;

role Pango::Roles::Pointers {

  method p {
    nativecast(Pointer, self);
  }

}