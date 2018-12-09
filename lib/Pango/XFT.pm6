use v6.c;

use Pango::Compat::Types;
use Pango::Raw::Types;
use Pango::Raw::XFT;

use Pango::Roles::Types;

class Pango::XFTFont {
  also does Pango::Roles::Types;

  method font_get_display {
    pango_xft_font_get_display($!pxft);
  }

  method font_get_font {
    pango_xft_font_get_font($!pxft);
  }

  method font_get_glyph (Int() $wc) {
    my gunichar $wwc = self.RESOLVE-UINT($wc);
    pango_xft_font_get_glyph($!pxft, $wwc);
  }

  method font_get_type {
    pango_xft_font_get_type();
  }

  method font_get_unknown_glyph (Int() $wc) {
    my gunichar $wwc = self.RESOLVE-UINT($wc);
    pango_xft_font_get_unknown_glyph($!pxft, $wwc);
  }

  method font_has_char (Int() $wwc) {
    my gunichar $wwc = self.RESOLVE-UINT($wc);
    pango_xft_font_has_char($!pxft, $wc);
  }

  method font_lock_face {
    pango_xft_font_lock_face($!pxft);
  }

  method font_unlock_face {
    pango_xft_font_unlock_face($!pxft);
  }

  method get_font_map (Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_get_font_map($!pxft, $s);
  }

  method set_default_substitute (
    Int() $screen,
    &func,
    $data,
    &notify = Callable
  ) {
    die q:to/D/.chomp unless $user_data.REPR eq <CPointer CStruct>.any;
<user_data> parameter must be of CPointer or CStruct representation.
D

    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_set_default_substitute($!pxft, $s, &func, $data, &notify);
  }

  method shutdown_display (Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_shutdown_display($!pxft, $s);
  }

  method substitute_changed (Int() $screen) {
    my gint $s = self.RESOLVE-INT($screen);
    pango_xft_substitute_changed($!pxft, $s);
  }

}
