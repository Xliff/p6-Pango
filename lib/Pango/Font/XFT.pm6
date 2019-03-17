use v6.c;

use Pango::Compat::Types;
use Pango::Raw::XFT;
use Pango::Raw::Types;

use Pango::Font::FC;

class Pango::XFTFont is Pango::Font::FC {
  has PangoFont $!pxftf;

  method get_display {
    pango_xft_font_get_display($!pxftf);
  }

  method get_font {
    pango_xft_font_get_font($!pxftf);
  }

  method get_type {
    pango_xft_font_get_type();
  }

  # DEPRECATED
  #
  # method font_get_glyph (Int() $wc) {
  #   my gunichar $wwc = self.RESOLVE-UINT($wc);
  #   pango_xft_font_get_glyph($!pxft, $wwc);
  # }
  # method font_get_unknown_glyph (Int() $wc) {
  #   my gunichar $wwc = self.RESOLVE-UINT($wc);
  #   pango_xft_font_get_unknown_glyph($!pxft, $wwc);
  # }
  # method font_has_char (Int() $wwc) {
  #   my gunichar $wwc = self.RESOLVE-UINT($wc);
  #   pango_xft_font_has_char($!pxft, $wc);
  # }
  # method font_lock_face {
  #   pango_xft_font_lock_face($!pxft);
  # }
  # method font_unlock_face {
  #   pango_xft_font_unlock_face($!pxft);
  # }
}
