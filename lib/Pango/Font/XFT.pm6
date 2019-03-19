use v6.c;

use Method::Also;

use Pango::Compat::Types;
use Pango::Raw::XFT;
use Pango::Raw::Types;

use Pango::Font::FC;

class Pango::Font::XFT is Pango::Font::FC {
  has PangoXFTFont $!pxftf;

  method get_display is also<get-display> {
    pango_xft_font_get_display($!pxftf);
  }

  method get_font is also<get-font> {
    pango_xft_font_get_font($!pxftf);
  }

  method get_type is also<get-type> {
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
