use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::XFT;

use Pango::Roles::Types;

class Pango::XFT {
  also does Pango::Roles::Types;

  method get_font_map (Display $display, Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_get_font_map($display, $s);
  }

  method set_default_substitute (
    Display $display,
    Int() $screen,
    &func,
    $data,
    &notify = Callable
  ) {
    die q:to/D/.chomp unless $user_data.REPR eq <CPointer CStruct>.any;
<user_data> parameter must be of CPointer or CStruct representation.
D

    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_set_default_substitute($display, $s, &func, $data, &notify);
  }

  method shutdown_display (Display $display, Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_shutdown_display($display, $s);
  }

  method substitute_changed (Display $display, Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_substitute_changed($display, $s);
  }

}
