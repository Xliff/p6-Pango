use v6.c;

use Method::Also;

use Pango::Raw::Types;
use Pango::Raw::XFT;

use GLib::Roles::StaticClass;

class Pango::XFT {
  also does GLib::Roles::StaticClass;

  method get_font_map (Display $display, Int() $screen) is also<get-font-map> {
    my gint $s = $screen;
    
    pango_xft_get_font_map($display, $s);
  }

  method set_default_substitute (
    Display $display,
    Int() $screen,
    &func,
    $data,
    &notify = Callable
  )
    is also<set-default-substitute>
  {
    die q:to/D/.chomp unless $data.REPR eq <CPointer CStruct>.any;
<user_data> parameter must be of CPointer or CStruct representation.
D

    my gint $s = $screen;

    pango_xft_set_default_substitute($display, $s, &func, $data, &notify);
  }

  method shutdown_display (Display $display, Int() $screen)
    is also<shutdown-display>
  {
    my gint $s = $screen;

    pango_xft_shutdown_display($display, $s);
  }

  method substitute_changed (Display $display, Int() $screen)
    is also<substitute-changed>
  {
    my gint $s = $screen;

    pango_xft_substitute_changed($display, $s);
  }

}
